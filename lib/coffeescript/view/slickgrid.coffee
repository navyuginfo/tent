require "./table"
require "../template/slick"
require "../data/collection"
require '../mixin/grid_sorting_support'
require '../mixin/grid_paging_support'
require '../mixin/grid_filtering_support'
require './grid/cell_formatters'

# TODO: refactor out single and multi select code

Tent.SlickGrid = Ember.View.extend Tent.FieldSupport, Tent.GridPagingSupport, Tent.GridSortingSupport, Tent.GridFilteringSupport,
	classNames: ['slickgrid']
	templateName: 'slick'
	rowSelection: null
	grid: null
	multiSelect: false
	dataType: null
	dataStore: null
	columnsBinding: 'collection.columnsDescriptor'

	defaults:  
		enableCellNavigation: true
		enableColumnReorder: true
		multiColumnSort: true
		
	init: ->
		@_super()
		@ensureCollectionAvailable()
		@set('delegate', if @get('multiSelect') then Tent.MultiSelectGrid.create({parent: @}) else Tent.SingleSelectGrid.create({parent:@}))

	ensureCollectionAvailable: ->
		if !@get('collection')
			collection = Tent.Data.Collection.create
				store: @get('dataStore')
				dataType: @get('dataType')
				pageSize: @get('pageSize')
			@set('collection', collection)
		else
			@get('collection').set('pageSize', @get('pageSize'))

	formLayout: (->
		return (@get('style')==Tent.SlickGrid.STYLES.FORM)
	).property()
	
	_listContentDidChange: (->
		if @get('grid')?
			@setDataViewItems()
			@get('grid').invalidate()
			if @get('remotePaging')
				@get('grid').setData(@get('collection.content'))
				@get('dataView').listDataDidChange()
			@get('grid').render()
	).observes 'collection.content'

	_rowSelectionDidChange: (->
		# Allow the controller field to observe any selection changes
		if @get('multiSelect')
			select = []
			for item in @get('rowSelection')
				select.push(@getModelWithId(item.id))
			@set('selection', select)
		else
			@set('selection', @getModelWithId(@get('rowSelection').id))
	).observes 'rowSelection'

	getModelWithId: (id) ->
		for model in @get('collection.modelData').toArray()
			return model if model.get('id') == id
	
	didInsertElement: ->
		@renderGrid()

	columnsDidChange: (->
		if @.$() 		# if dom ready
			@renderGrid()
	).observes('columns')

	renderGrid: ->
		if @readyToRender()
			@extendOptions()
			@createDataView()
			@setDataViewItems()
			@get('delegate').createGrid()
			@listenForSelections()
			@get('grid').render()
			@setupFilter()
			@setupColumnFilters()

	readyToRender: ->
		@get('columns')

	extendOptions: ->
		# Allow custom options to be specified in the markup
		# e.g. {{view Pad.CustomList ... options="{\"enableColumnReorder\": false}"
		customOptions = if @get("options") then JSON.parse(@get('options')) else {}
		customOptions.showHeaderRow = if @get('useColumnFilters')? then @get('useColumnFilters') else false
		@set("options", $.extend({}, @get('defaults'), customOptions))

	createDataView: -> 
		if @get("remotePaging")
			@set('dataView', Tent.RemotePagedData.create(
				parentView: @
				collection: @get('collection')
			))
		else
			@set('dataView', new Slick.Data.DataView({inlineFilters: true}))
		if @get("pageSize")
			@get('dataView').setPagingOptions({pageSize: @get("pageSize")})


	createGrid: ->
		if @get("remotePaging")
			@set('grid', new Slick.Grid(@.$().find(".grid"), @get('dataView').getItems() || [], @get('adaptedColumns'), @get('options')))
		else
			@set('grid', new Slick.Grid(@.$().find(".grid"), @get('dataView'), @get('adaptedColumns'), @get('options')))
		return @get('grid')

	setDataViewItems: (items)->
		dataItems = if items? then items else @get('collection.content')
		if dataItems?
			@get('dataView').beginUpdate();
			@get('dataView').setItems(dataItems);
			@get('dataView').endUpdate();		

	listenForSelections: ->
		@get('dataView').onRowCountChanged.subscribe((e, args) =>
			@get('grid').updateRowCount()
			@get('grid').render()
		)
		@get('dataView').onRowsChanged.subscribe((e, args) =>
			@get('grid').invalidateRows(args.rows)
			@get('grid').render()
		)

	willDestroyElement: ->
		@get('grid').onClick.unsubscribe(->)
		@get('grid').destroy()
	


Tent.SlickGrid.STYLES = 
	FORM: "form"
	WIDE: "wide"



Tent.SingleSelectGrid = Ember.Object.extend
	
	createGrid: ->
		@_initializeColumns()
		grid = @get('parent').createGrid()
		grid.setSelectionModel(new Slick.RowSelectionModel())
		@_listenForDisplayedContentChange(grid)
		@_listenForSelectedRowsChange(grid)
		@selectionDidChange()
	
	_initializeColumns: ->
		@get('parent').set('adaptedColumns', @get('parent').get('columns'))

	# If new rows are selected, update the controller with the new selected objects
	_listenForSelectedRowsChange: (grid) ->
		grid.onSelectedRowsChanged.subscribe((e, args) =>
			@_updateRowSelectionWithCurrentlySelectedItem e,args
			#grid.selectedRowIds = grid.mapRowsToIds(grid.getSelectedRows());
		)

	_updateRowSelectionWithCurrentlySelectedItem: (e, range) ->
		# When paging occurs (single-select) there may be nothing on the page
		# Range gives the index of the selected item in the current page
		if range.rows.length
			# Check that the item is not already selected. 
			# If it is, we dont want to trigger an update
			newSelectedObject = @_getSelectedObjectFromGrid(range)
			if not @_isRowAlreadySelected(newSelectedObject)
				@get('parent').set('rowSelection', newSelectedObject)
				@get('parent').get('dataView').selectedRowIds = [newSelectedObject.id]
		# Need to override the default behavior of clearing selectedRowIds when the selected
		# item is not on the current page
		@get('parent').get('dataView').selectedRowIds = @get('parent').get('dataView').selectedRowIdsAllPages
		@get('parent').get('grid').selectedRowIds = @get('parent').get('dataView').selectedRowIdsAllPages
		e.stopPropagation

	_isRowAlreadySelected: (newSelectedObject) ->
		@get('parent').get('rowSelection')? and @get('parent').get('rowSelection').id == newSelectedObject.id

	_getSelectedObjectFromGrid: (range) ->
		row = @get('parent').get('grid').getDataItem range.rows[0]		

	# Ensure that we respond to paging events and updated data content
	_listenForDisplayedContentChange: (grid) ->
		#@get('parent').get('dataView').syncGridSelection(grid, true);
		grid = @get('parent').get('grid')
		dataView = @get('parent').get('dataView')
		preserveHidden = true
		@get('parent').get('dataView').onRowsChanged.subscribe((e, args) ->
			if dataView.selectedRowIds? and dataView.selectedRowIds.length > 0
				inHandler = true
				selectedRows = dataView.mapIdsToRows(dataView.selectedRowIds)
				if (!preserveHidden)
					dataView.selectedRowIds = dataView.mapRowsToIds(selectedRows)
				grid.setSelectedRows(selectedRows)
				inHandler = false
		)

	# Changes to the selection should be reflected in the grid 
	selectionDidChange: (->
		if not @get("parent.remotePaging")
			selectedIds = []
			selectedIds.push(@get('parent.selection').get('id'))
			@get('parent.dataView').selectedRowIdsAllPages = selectedIds
			@get('parent.dataView').selectedRowIds = selectedIds
			selectedRows = @get('parent.dataView').mapIdsToRows(selectedIds)
			@get('parent.grid').setSelectedRows(selectedRows)
		else 
			selectedIds = []
			selectedIds.push(@get('parent.selection').get('id'))
			@get('parent.dataView').selectedRowIdsAllPages = selectedIds
			@get('parent.dataView').selectedRowIds = selectedIds
			@get('parent.dataView').highlightSelectedRowsOnGrid()
	).observes('parent.selection')


Tent.MultiSelectGrid = Ember.Object.extend

	createGrid: ->
		grid = @_createGridWithCheckbox()
		grid.setSelectionModel(new Slick.RowSelectionModel({selectActiveRow: false}))
		@_listenForDisplayedContentChange(grid)
		@_listenForSelectedRowsChange(grid)
		@selectionDidChange()

	_createGridWithCheckbox: ->
		checkboxSelector = new Slick.CheckboxSelectColumn
			cssClass: "slick-cell-checkboxsel"
		@_addCheckboxesAsFirstColumn(checkboxSelector)
		grid = @get('parent').createGrid()
		grid.registerPlugin(checkboxSelector)
		return grid

	_addCheckboxesAsFirstColumn: (checkboxSelector)->
		adaptedColumns = $.merge([], @get('parent').get('columns'))
		adaptedColumns.splice(0,0,checkboxSelector.getColumnDefinition())
		@get('parent').set('adaptedColumns', adaptedColumns)

	# If new rows are selected, update the controller with the new selected objects
	_listenForSelectedRowsChange: (grid) ->
		grid.onSelectedRowsChanged.subscribe((e, args) =>
			@_updateRowSelectionWithAllItems e,args
		)

	_updateRowSelectionWithAllItems: (e, range) ->
		# Rebuild the selection from the dataView
		if @get('parent').get('remotePaging')
			@_updateRowSelectionRemote(range)
		else
			@_updateRowSelectionOnClient()
		e.stopPropagation

	_updateRowSelectionRemote: (range) ->
		currentSelectionAfterRemovals = @_removeDeselectedItems(range)
		newSelection = @_getNewSelectedObjects(range)
		@get('parent').set("rowSelection", $.merge(newSelection,currentSelectionAfterRemovals))

	_removeDeselectedItems: (range) ->
		idsToRemove = @_getIdsToRemove(range)
		@_removeItemsFromSelectedRowIds(idsToRemove)
		return @_removeObjectsFromRowSelection(idsToRemove)

	_getIdsToRemove: (range)->
		allObjectsInGrid = @get('parent').get('dataView').getItems()
		idsToRemove = []
		$.each(allObjectsInGrid, (index, value) ->
			if not (index in range.rows)
				id = value.id
				idsToRemove.push(id)
		)
		return idsToRemove

	_removeItemsFromSelectedRowIds: (idsToRemove)->
		currentSelectedObjectIDs = @get('parent').get('dataView').selectedRowIds
		for id in idsToRemove
			if (pos = currentSelectedObjectIDs.indexOf(id)) != -1
					currentSelectedObjectIDs.splice(pos, 1)
		@get('parent').get('dataView').set('selectedRowIds', currentSelectedObjectIDs)

	_removeObjectsFromRowSelection: (idsToRemove) ->
		currentSelectedObjects = @get('parent').get("rowSelection") || []
		currentSelectionAfterRemovals = []
		$.each(currentSelectedObjects, (index, value) ->
			currentSelectionAfterRemovals.push(value) if value.id not in idsToRemove
		)
		return currentSelectionAfterRemovals

	_updateRowSelectionOnClient: ->
		rowSelection = []
		idsForAllRowsSelected = @get('parent').get('grid').selectedRowIds || []
		for id in idsForAllRowsSelected
			rowSelection.push(@get('parent').get('grid').getData().getItemById(id))
		@get('parent').set("rowSelection", rowSelection)

	_getNewSelectedObjects: (range)->
		newSelection = []
		idsForAllRowsSelected = @get('parent').get('dataView').selectedRowIds
		for rownum in range.rows
				item = @get('parent').get('dataView').getItem(rownum)
				if not (item.id in idsForAllRowsSelected)
					newSelection.push(item)
					idsForAllRowsSelected.push(item.id)
		return newSelection

	# Ensure that we respond to paging events and updated data content
	_listenForDisplayedContentChange: (grid) ->
		@get('parent').get('dataView').syncPagedGridSelection(grid, true);

	# Changes to the selection should be reflected in the grid 
	selectionDidChange: (->
		if not @get("parent.remotePaging")
			selectedIds = []
			for item in @get('parent.selection') 
				selectedIds.push(item.get('id'))
			@get('parent.dataView').selectedRowIdsAllPages = selectedIds
			@get('parent.dataView').selectedRowIds = selectedIds
			selectedRows = @get('parent.dataView').mapIdsToRows(selectedIds)

			if not @rowsHaveChanged(@get('parent.grid').getSelectedRows(), selectedRows)
				@get('parent.grid').setSelectedRows(selectedRows)
		else 
			selectedIds = []
			for item in @get('parent.selection') ? []
				selectedIds.push(item.get('id'))
			@get('parent.dataView').selectedRowIdsAllPages = selectedIds
			@get('parent.dataView').selectedRowIds = selectedIds
			@get('parent.dataView').highlightSelectedRowsOnGrid()
	).observes('parent.selection')

	rowsHaveChanged: (rows1, rows2)->
		(rows1.length == rows2.length) and rows1.every((element,index,array)->
			return element in rows2
		)

Tent.RemotePagedData = Ember.Object.extend
	parentView: null
	collection: null
	pagenum: 0
	selectedRowIds: []
	onPagingInfoChanged: new Slick.Event()
	onRowCountChanged: new Slick.Event()
	onRowsChanged: new Slick.Event()

	getPagingInfo: ->
		@set('totalPages', if @get('collection.pageSize') then Math.max(1, Math.ceil(@get('collection.totalRows') / @get('collection.pageSize'))) else 1)
		return {pageSize: @get('collection.pageSize'), pageNum: @get('collection.currentPage'), totalRows: @get('collection.totalRows'), totalPages: @get('totalPages')}
    
    # This will be called by the slick pager plugin
	setPagingOptions: (args) ->
		if args.pageSize != undefined
			@pagesize = args.pageSize
			@pagenum = if @get('collection.pageSize') then Math.min(@pagenum, Math.max(0, Math.ceil(@get('collection.totalRows') / @get('collection.pageSize')) - 1)) else 0
		
		if args.pageNum != undefined
			@pagenum = Math.min(args.pageNum, Math.max(0, Math.ceil(@get('collection.totalRows') / @get('collection.pageSize')) - 1))

		@set('collection.currentPage', @pagenum)
		@get("parentView").page(@getPagingInfo())
		@onPagingInfoChanged.notify(@getPagingInfo(), null, null);

	notifyPagerUI: (->
		@onPagingInfoChanged.notify(@getPagingInfo(), null, null);
	).observes('collection.totalRows', 'collection.currentPage')
	
	listDataDidChange: ->
		@highlightSelectedRowsOnGrid()

	highlightSelectedRowsOnGrid: ->
		grid=  @get('parentView').get('grid')
		if @get('selectedRowIds')? and (@get('selectedRowIds').length > 0) and grid?
			selectedRowsOnCurrentPage = []
			items = @get('items')
			for item, i in items
				for match in @get('selectedRowIds') when match == item.id
					selectedRowsOnCurrentPage.push(i)
			if not @rowsHaveChanged(grid.getSelectedRows(), selectedRowsOnCurrentPage)
				grid.setSelectedRows(selectedRowsOnCurrentPage)

	# Dont re-select if there is no change
	rowsHaveChanged: (rows1, rows2)->
		if not(rows1? and rows2?)
			return false
		(rows1.length == rows2.length) and rows1.every((element,index,array)->
			return element in rows2
		)

			

	beginUpdate: ->
	endUpdate: ->
	setItems: (items)->	@set("items", items)
	getItems: -> @get("items")
	getItem: (i)-> return @get("items")[i]
	setRefreshHints: ->
	syncPagedGridSelection: ->
	syncGridSelection: ->
	refresh: ->


