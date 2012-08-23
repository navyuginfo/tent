require "./table"
require "../template/slick"
require "vendor/scripts/jquery-ui-1.8.16.custom.min"
require "vendor/scripts/jquery.event.drag-2.0.min"
require "vendor/scripts/slick.rowselectionmodel"
require "vendor/scripts/slick.checkboxselectcolumn"
require "vendor/scripts/slick.dataview"
require "vendor/scripts/slick.pager"
require "vendor/scripts/slick.core"
require "vendor/scripts/slick.grid"
require '../mixin/grid_sorting_support'
require '../mixin/grid_paging_support'

# TODO: refactor out single and multi select code

Tent.SlickGrid = Ember.View.extend Tent.FieldSupport, Tent.GridPagingSupport, Tent.GridSortingSupport, 
	templateName: 'slick'
	rowSelection: null
	grid: null
	multiSelect: false
	listBinding: 'controller.list'

	defaults:  
		enableCellNavigation: true
		enableColumnReorder: true
		multiColumnSort: false

	init: ->
		@_super()
		@set('delegate', if @get('multiSelect') then Tent.MultiSelectGrid.create({parent: @}) else Tent.SingleSelectGrid.create({parent:@}))

	formLayout: (->
		return (@get('style')==Tent.SlickGrid.STYLES.FORM)
	).property()
	
	_listContentDidChange: (->
		if @get('grid')?
			@setDataViewItems()
			@get('grid').invalidate()
			if @get('remotePaging')
				@get('grid').setData(@get('list'))
				@get('dataView').listDataDidChange()
			@get('grid').render()
	).observes 'list'

	_rowSelectionDidChange: (->
		# Allow the controller field to observe any selection changes
		@get('controller').set('rowSelection', @get('rowSelection'))
	).observes 'rowSelection'
	 
	didInsertElement: ->
		@renderGrid()

	renderGrid: ->
		@extendOptions()
		@createDataView()
		@get('delegate').createGrid()
		@listenForSelections()
		@get('grid').render()

	extendOptions: ->
		# Allow custom options to be specified in the markup
		# e.g. {{view Pad.CustomList ... options="{\"enableColumnReorder\": false}"
		customOptions = if @get("options") then JSON.parse(@get('options')) else {}
		@set("options", $.extend({}, @get('defaults'), customOptions))

	createDataView: -> 
		if @get("remotePaging")
			@set('dataView', Tent.RemotePagedData.create(
				parentView: @
			))
		else
			@set('dataView', new Slick.Data.DataView())

		if @get("pageSize")
			@get('dataView').setPagingOptions({pageSize: @get("pageSize")})
		@setDataViewItems()


	createGrid: ->
		if @get("remotePaging")
			@set('grid', new Slick.Grid(@.$().find(".grid"), @get('dataView').getItems() || [], @get('columns'), @get('options')))
		else
			@set('grid', new Slick.Grid(@.$().find(".grid"), @get('dataView'), @get('columns'), @get('options')))
		return @get('grid')

	setDataViewItems: (items)->
		dataItems = if items? then items else @get('list')
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
		grid = @get('parent').createGrid()
		grid.setSelectionModel(new Slick.RowSelectionModel())
		@_listenForDisplayedContentChange(grid)
		@_listenForSelectedRowsChange(grid)
	
	# If new rows are selected, update the controller with the new selected objects
	_listenForSelectedRowsChange: (grid) ->
		grid.onSelectedRowsChanged.subscribe((e, args) =>
			@_updateRowSelectionWithCurrentlySelectedItem e,args
		)

	_updateRowSelectionWithCurrentlySelectedItem: (e, range) ->
		# When paging occurs (single-select) there may be nothing on the page
		if range.rows.length
			# Check that the item is not already selected. 
			# If it is, we dont want to trigger an update
			newSelectedObject = @_getSelectedObjectFromGrid(range)
			if not (@get('parent').get('rowSelection')? and @get('parent').get('rowSelection').id == newSelectedObject.id)
				@get('parent').set('rowSelection', newSelectedObject)
				@get('parent').get('dataView').selectedRowIds = [newSelectedObject.id]
		e.stopPropagation

	_getSelectedObjectFromGrid: (range) ->
		row = @get('parent').get('grid').getDataItem range.rows[0]		

	# Ensure that we respond to paging events and updated data content
	_listenForDisplayedContentChange: (grid) ->
		@get('parent').get('dataView').syncGridSelection(grid, true);



Tent.MultiSelectGrid = Ember.Object.extend

	createGrid: ->
		grid = @_createGridWithCheckbox()
		grid.setSelectionModel(new Slick.RowSelectionModel({selectActiveRow: false}))
		@_listenForDisplayedContentChange(grid)
		@_listenForSelectedRowsChange(grid)
		

	_createGridWithCheckbox: ->
		checkboxSelector = new Slick.CheckboxSelectColumn
			cssClass: "slick-cell-checkboxsel"
		@_addCheckboxesAsFirstColumn(checkboxSelector)
		grid = @get('parent').createGrid()
		grid.registerPlugin(checkboxSelector)
		return grid

	_addCheckboxesAsFirstColumn: (checkboxSelector)->
		@get('parent').get('columns').splice(0,0,checkboxSelector.getColumnDefinition())

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


Tent.RemotePagedData = Ember.Object.extend
	parentView: null
	pagesize: 5
	pagenum: 0
	totalRows: 9
	selectedRowIds: []
	onPagingInfoChanged: new Slick.Event()
	onRowCountChanged: new Slick.Event()
	onRowsChanged: new Slick.Event()

	getPagingInfo: ->
		@totalPages = if @pagesize then Math.max(1, Math.ceil(@totalRows / @pagesize)) else 1
		return {pageSize: @pagesize, pageNum: @pagenum, totalRows: @totalRows, totalPages: @totalPages}
    
    # This will be called by the slick pager plugin
	setPagingOptions: (args) ->
		if args.pageSize != undefined
			@pagesize = args.pageSize
			@pagenum = if @pagesize then Math.min(@pagenum, Math.max(0, Math.ceil(@totalRows / @pagesize) - 1)) else 0
		
		if args.pageNum != undefined
			@pagenum = Math.min(args.pageNum, Math.max(0, Math.ceil(@totalRows / @pagesize) - 1))

		@get("parentView").page(@getPagingInfo())
	
	listDataDidChange: ->
		@highlightSelectedRowsOnGrid()

	highlightSelectedRowsOnGrid: ->
		grid=  @get('parentView').get('grid')
		if (@get('selectedRowIds').length > 0) and grid?
			selectedRowsOnCurrentPage = []
			items = @get('items')
			for item, i in items
				for match in @get('selectedRowIds') when match == item.id
					selectedRowsOnCurrentPage.push(i)
			grid.setSelectedRows(selectedRowsOnCurrentPage)

	beginUpdate: ->
	endUpdate: ->
	setItems: (items)->	@set("items", items)
	getItems: -> @get("items")
	getItem: (i)-> return @get("items")[i]
	setRefreshHints: ->
	syncPagedGridSelection: ->
	syncGridSelection: ->
