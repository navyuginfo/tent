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

# TODO: refactor out single and multi select code

Tent.SlickGrid = Ember.View.extend Tent.FieldSupport,
	templateName: 'slick'
	rowSelection: null
	grid: null
	multiSelect: false
	listBinding: 'controller.list'
	paged: false
	remotePaging: true

	defaults:  
		enableCellNavigation: true
		enableColumnReorder: true
		multiColumnSort: true

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
		@setupPaging()
		@setupSorting()
		@get('grid').render()

	extendOptions: ->
		# Allow custom options to be specified in the markup
		# e.g. {{view Pad.CustomList ... options="{\"enableColumnReorder\": false}"
		customOptions = if @get("options") then JSON.parse(@get('options')) else {}
		@set("options", $.extend({}, @get('defaults'), customOptions))

	createDataView: -> 
		if @get("remotePaging")
			@set('dataView', Tent.RemotePagedData.create(
				controller: @get("controller")
			))
			#@get('dataView').syncPagedGridSelection = @handleRemotePagedSelections

		else
			@set('dataView', new Slick.Data.DataView())
			@get('dataView').syncPagedGridSelection = @handlePagedSelections
		if @get("pageSize")
			@get('dataView').setPagingOptions({pageSize: @get("pageSize")})
		@setDataViewItems()


	createGrid: ->
		if @get("remotePaging")
			@set('grid', new Slick.Grid(@.$().find(".grid"), @get('dataView').getItems() || [], @get('columns'), @get('options')))
			@get('dataView').set('grid', @get('grid'))			
		else
			@set('grid', new Slick.Grid(@.$().find(".grid"), @get('dataView'), @get('columns'), @get('options')))

	setDataViewItems: ->
		if (@get('list')?)
			@get('dataView').beginUpdate();
			@get('dataView').setItems(@get('list'));
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

	setupPaging: ->
		if @get("paged")
			pager = new Slick.Controls.Pager(@get('dataView'), @get('grid'), @$().find(".pager"));


	setupSorting: -> 
		@get('grid').onSort.subscribe((e, args) =>
			@sortCallback e,args
		)

	willDestroyElement: ->
		@get('grid').onClick.unsubscribe(->)
		@get('grid').destroy()
	
	# The native grid/dataview does not manage selections across pages
	# This code adds listeners to enable this 
	handlePagedSelections: (grid, preserveHidden) ->
			selectedRowIds = @mapRowsToIds(grid.getSelectedRows())
			inHandler = false
			grid.onSelectedRowsChanged.subscribe (e, args) =>
				if inHandler then return # Called from a paging request
				@updateSelectedIdsWithCurrentPageSelection(grid)

			@updateSelectedIdsWithCurrentPageSelection = (grid) ->
				currentPageSelectedIds = @mapRowsToIds(grid.getSelectedRows())
				for id in currentPageSelectedIds
					selectedRowIds.push(id) if id not in selectedRowIds
				selectedRowIds = @removeUnselectedRows(selectedRowIds, currentPageSelectedIds)
				grid.selectedRowIds = selectedRowIds

			@removeUnselectedRows = (selectedRowIds, currentPageSelectedIds) ->
				counter = @getLength()
				while counter
					rowInCurrentPage = @getItem(counter-=1)
					selectedRowIds = $.grep(selectedRowIds, (element, index) ->
						if element == rowInCurrentPage.id
							if element not in currentPageSelectedIds then return false
						return true
					)
				selectedRowIds

			@onRowsChanged.subscribe((e, args) =>
				if selectedRowIds.length > 0
					inHandler = true
					selectedRowsOnCurrentPage = @mapIdsToRows(selectedRowIds)
					if not preserveHidden 
						selectedRowIds = @mapRowsToIds(selectedRowsOnCurrentPage)
					grid.setSelectedRows(selectedRowsOnCurrentPage)
					inHandler = false
			)

	


	sortCallback: (e, args) ->
		console.log 'sort'
		if args.multiColumnSort
			@get('controller').sortMultiColumn(args.sortCols)
		else
			@get('controller').sortSingleColumn(args.sortCol, args.sortAsc)

Tent.SlickGrid.STYLES = 
	FORM: "form"
	WIDE: "wide"



Tent.SingleSelectGrid = Ember.Object.extend
	
	createGrid: ->
		@get('parent').createGrid()
		grid = @get('parent').get('grid')
		grid.setSelectionModel(new Slick.RowSelectionModel())
		grid.onSelectedRowsChanged.subscribe((e, args) =>
			@updateRowSelectionWithCurrentlySelectedItem e,args
		)
		@get('parent').get('dataView').syncGridSelection(grid, true);

	updateRowSelectionWithCurrentlySelectedItem: (e, range) ->
		# When paging occurs (single-select) there may be nothing on the page
		if range.rows.length
			# Check that the item is not already selected. 
			# If it is, we dont want to trigger an update
			newSelectedRow = @getSelectedRow(range)
			if not (@get('parent').get('rowSelection')? and @get('parent').get('rowSelection').id == newSelectedRow.id)
				@get('parent').set('rowSelection', newSelectedRow)
				@get('parent').get('dataView').selectedRowIds = [newSelectedRow.id]
		e.stopPropagation

	getSelectedRow: (range) ->
		row = @get('parent').get('grid').getDataItem range.rows[0]		


Tent.MultiSelectGrid = Ember.Object.extend

	createGrid: ->
		checkboxSelector = new Slick.CheckboxSelectColumn({
			cssClass: "slick-cell-checkboxsel"
		});
		@get('parent').get('columns').splice(0,0,checkboxSelector.getColumnDefinition())  #Add the checkbox column
		@get('parent').createGrid()
		grid = @get('parent').get('grid')
		grid.setSelectionModel(new Slick.RowSelectionModel({selectActiveRow: false}))
		grid.registerPlugin(checkboxSelector)
		@get('parent').get('dataView').syncPagedGridSelection(grid, true);
		grid.onSelectedRowsChanged.subscribe((e, args) =>
			@updateRowSelectionWithAllItems e,args
		)

	updateRowSelectionWithAllItems: (e, range) ->
		# Rebuild the selection from the dataView
		if @get('parent').get('remotePaging')
			
			currentSelection = @get('parent').get("rowSelection") || []
			
			#remove unselected rows
			idsForAllRowsSelected = @get('parent').get('dataView').selectedRowIds
			
			allRowObjects = @get('parent').get('dataView').getItems()
			idsToRemove = []
			$.each(allRowObjects, (index, value) ->
				if not (index in range.rows)
					id = value.id
					idsToRemove.push(id)
					if (pos = idsForAllRowsSelected.indexOf(id)) != -1
						idsForAllRowsSelected.splice(pos, 1)
					# remove item from currentSelection
					
					#currentSelection.grep
					#if (pos = currentSelection.indexOf(value)) != -1
					#	currentSelection.splice(pos, 1)
					return true
			)
			
			currentSelectionAfterRemovals = []
			$.each(currentSelection, (index, value) ->
				currentSelectionAfterRemovals.push(value) if value.id not in idsToRemove
			)

			@get('parent').get('dataView').set('selectedRowIds', idsForAllRowsSelected)
			
			newSelection = @getNewSelectedObjects(range)
			#@removeUnselectedRows(currentSelection, range)
			merged = $.merge(newSelection,currentSelectionAfterRemovals)
			 
			@get('parent').set("rowSelection", merged)
		else
			rowSelection = []
			idsForAllRowsSelected = @get('parent').get('grid').selectedRowIds
			for id in idsForAllRowsSelected
				rowSelection.push(@get('parent').get('grid').getData().getItemById(id))
			@get('parent').set("rowSelection", rowSelection)

		e.stopPropagation	

	getNewSelectedObjects: (range)->
		newSelection = []
		idsForAllRowsSelected = @get('parent').get('dataView').selectedRowIds
		for rownum in range.rows
				item = @get('parent').get('dataView').getItem(rownum)
				if not (item.id in idsForAllRowsSelected)
					newSelection.push(item)
					idsForAllRowsSelected.push(item.id)
		return newSelection

	 

 
 


Tent.RemotePagedData = Ember.Object.extend
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
    
	setPagingOptions: (args) ->
		if args.pageSize != undefined
			@pagesize = args.pageSize
			@pagenum = if @pagesize then Math.min(@pagenum, Math.max(0, Math.ceil(@totalRows / @pagesize) - 1)) else 0
		
		if args.pageNum != undefined
			@pagenum = Math.min(args.pageNum, Math.max(0, Math.ceil(@totalRows / @pagesize) - 1))

		@get("controller").page(@getPagingInfo())
	
	listDataDidChange: ->
		@highlightSelectedRowsOnGrid()

	highlightSelectedRowsOnGrid: ->
		if (@get('selectedRowIds').length > 0) and @get('grid')?
			selectedRowsOnCurrentPage = []
			items = @get('items')
			for item, i in items
				for match in @get('selectedRowIds') when match == item.id
					selectedRowsOnCurrentPage.push(i)
			@get('grid').setSelectedRows(selectedRowsOnCurrentPage)

	mapIdsToRows: () ->
		#for id in @get('selectedRowIds')


	
	beginUpdate: ->

	endUpdate: ->

	setItems: (items)->
		@set("items", items)

	getItems: ->
		@get("items")

	getItem: (i)->
		return @get("items")[i]

	setRefreshHints: ->

	syncPagedGridSelection: ->

	syncGridSelection: ->


