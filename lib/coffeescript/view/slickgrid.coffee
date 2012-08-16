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

	defaults:  
		enableCellNavigation: true
		enableColumnReorder: true
		multiColumnSort: true

	init: ->
		@_super()
		@delegate = if @multiSelect then Tent.MultiSelectGrid.create({parent: @}) else Tent.SingleSelectGrid.create({parent:@})

	formLayout: (->
		return (@get('style')==Tent.SlickGrid.STYLES.FORM)
	).property()
	
	_listContentDidChange: (->
		if @grid?
			@setDataViewItems()
			@grid.invalidate()
			@grid.render()
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
		@delegate.createGrid()
		@listenForSelections()
		@setupPaging()
		@setupSorting()
		@grid.render()

	extendOptions: ->
		# Allow custom options to be specified in the markup
		# e.g. {{view Pad.CustomList ... options="{\"enableColumnReorder\": false}"
		customOptions = if @get("options") then JSON.parse(@get('options')) else {}
		@set("options", $.extend({}, @get('defaults'), customOptions))

	createDataView: -> 
		@dataView = new Slick.Data.DataView()
		@dataView.setPagingOptions({pageSize: @get("pageSize")})
		@dataView.syncPagedGridSelection = @handlePagedSelections
		@setDataViewItems()

	createGrid: ->
		@grid = new Slick.Grid(@.$().find(".grid"), @dataView, @columns, @options)

	setDataViewItems: ->
		@dataView.beginUpdate();
		@dataView.setItems(@get('list'));
		@dataView.endUpdate();		

	listenForSelections: ->
		@dataView.onRowCountChanged.subscribe((e, args) =>
			@grid.updateRowCount()
			@grid.render()
		)
		@dataView.onRowsChanged.subscribe((e, args) =>
			@grid.invalidateRows(args.rows)
			@grid.render()
		)

	setupPaging: ->
		if @paged
			pager = new Slick.Controls.Pager(@dataView, @grid, @$().find(".pager"));

	setupSorting: -> 
		@grid.onSort.subscribe((e, args) =>
			@sortCallback e,args
		)

	willDestroyElement: ->
		@grid.onClick.unsubscribe(->)
		@grid.destroy()

	
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
		@grid = @parent.createGrid()
		@grid.setSelectionModel(new Slick.RowSelectionModel())
		@grid.onSelectedRowsChanged.subscribe((e, args) =>
			@rowSelectionCallback e,args
		)
		@parent.dataView.syncGridSelection(@grid, true);

	rowSelectionCallback: (e, range) ->
		# When paging occurs (single-select) there may be nothing on the page
		if range.rows.length
			# Check that the item is not already selected. 
			# If it is, we dont want to trigger an update
			newSelectedRow = @getSelectedRow(range)
			if not (@parent.get('rowSelection')? and @parent.get('rowSelection').id == newSelectedRow.id)
				@parent.set('rowSelection', newSelectedRow)
		e.stopPropagation

	getSelectedRow: (range) ->
		row = @parent.grid.getDataItem range.rows[0]		


Tent.MultiSelectGrid = Ember.Object.extend

	createGrid: ->
		checkboxSelector = new Slick.CheckboxSelectColumn({
			cssClass: "slick-cell-checkboxsel"
		});
		@parent.columns.splice(0,0,checkboxSelector.getColumnDefinition())  #Add the checkbox column
		@grid = @parent.createGrid()
		@grid.setSelectionModel(new Slick.RowSelectionModel({selectActiveRow: false}))
		@grid.registerPlugin(checkboxSelector)
		@parent.dataView.syncPagedGridSelection(@grid, true);
		@grid.onSelectedRowsChanged.subscribe((e, args) =>
			@rowSelectionCallback e,args
		)

	rowSelectionCallback: (e, range) ->
		# Rebuild the selection from the dataView
		rowSelection = []
		ids = @grid.selectedRowIds
		for id in ids
			rowSelection.push(@grid.getData().getItemById(id))
		@parent.set("rowSelection", rowSelection)
		e.stopPropagation