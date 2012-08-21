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
	remotePaging: false

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
			@get('grid').render()
	).observes 'list'

	_rowSelectionDidChange: (->
		# Allow the controller field to observe any selection changes
		@set('controller.rowSelection', @get('rowSelection'))
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
		else
			@set('dataView', new Slick.Data.DataView())
			@get('dataView').syncPagedGridSelection = @handlePagedSelections
		if @get("pageSize")
			@get('dataView').setPagingOptions({pageSize: @get("pageSize")})
		@setDataViewItems()


	createGrid: ->
		if @get("remotePaging")
			@set('grid', new Slick.Grid(@.$().find(".grid"), @get('dataView').getItems(), @get('columns'), @get('options')))
		else
			@set('grid', new Slick.Grid(@.$().find(".grid"), @get('dataView'), @get('columns'), @get('options')))

	setDataViewItems: ->
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
				if inHandler then return
				currentPageSelectedRows = @mapRowsToIds(grid.getSelectedRows())
				for row in currentPageSelectedRows
					selectedRowIds.push(row) if row not in selectedRowIds
				selectedRowIds = @removeUnselectedRows(selectedRowIds, currentPageSelectedRows)
				grid.selectedRowIds = selectedRowIds

			@removeUnselectedRows = (selectedRowIds, currentPageSelectedRows) ->
				counter = @getLength()
				while counter
					rowInCurrentPage = @getItem(counter-=1)
					selectedRowIds = $.grep(selectedRowIds, (element, index) ->
						if element == rowInCurrentPage.id
							if element not in currentPageSelectedRows then return false
						return true
					)
				selectedRowIds

			@onRowsChanged.subscribe((e, args) =>
				if selectedRowIds.length > 0
					inHandler = true
					selectedRows = @mapIdsToRows(selectedRowIds)
					if not preserveHidden 
						selectedRowIds = @mapRowsToIds(selectedRows)
					grid.setSelectedRows(selectedRows)
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
			@rowSelectionCallback e,args
		)
		@get('parent').get('dataView').syncGridSelection(grid, true);

	rowSelectionCallback: (e, range) ->
		# When paging occurs (single-select) there may be nothing on the page
		if range.rows.length
			# Check that the item is not already selected. 
			# If it is, we dont want to trigger an update
			newSelectedRow = @getSelectedRow(range)
			if not (@get('parent').get('rowSelection')? and @get('parent').get('rowSelection').id == newSelectedRow.id)
				@get('parent').set('rowSelection', newSelectedRow)
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
			@rowSelectionCallback e,args
		)

	rowSelectionCallback: (e, range) ->
		# Rebuild the selection from the dataView
		rowSelection = []
		ids = @get('parent').get('grid').selectedRowIds
		for id in ids
			rowSelection.push(@get('parent').get('grid').getData().getItemById(id))
		@get('parent').set("rowSelection", rowSelection)
		e.stopPropagation	

Tent.RemotePagedData = Ember.Object.extend
	pagesize: 5
	pagenum: 1
	totalRows: 9

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
		@onPagingInfoChanged.notify(@getPagingInfo(), null, @);

	onPagingInfoChanged: new Slick.Event()
	onRowCountChanged: new Slick.Event()
	onRowsChanged: new Slick.Event()

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


