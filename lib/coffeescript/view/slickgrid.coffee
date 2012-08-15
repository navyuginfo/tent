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

	formLayout: (->
		return (@get('style')==Tent.SlickGrid.STYLES.FORM)
	).property()
	
	_listContentDidChange: (->
		if @grid?
			console.log 'render list  with ' + @list.length + ' items'
			#@grid.setData(@get("list"))
			@dataView.beginUpdate();
			@dataView.setItems(@get('list'));
			@dataView.endUpdate();
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
		@dataView = new Slick.Data.DataView()
		@dataView.setPagingOptions({pageSize: @get("pageSize")})
		@dataView.syncPagedGridSelection = (grid, preserveHidden) ->
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
				for rowInCurrentPage in @getRows() 
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

		if @multiSelect
			@renderMultiSelectGrid()
		else
			@renderSingleSelectGrid()

		if @paged
			pager = new Slick.Controls.Pager(@dataView, @grid, @$().find(".pager"));

		@dataView.onRowCountChanged.subscribe((e, args) =>
			@grid.updateRowCount()
			@grid.render()
		)
		@dataView.onRowsChanged.subscribe((e, args) =>
			@grid.invalidateRows(args.rows)
			@grid.render()
		)
		@dataView.beginUpdate();
		@dataView.setItems(@get('list'));
		@dataView.endUpdate();

		@grid.onSort.subscribe((e, args) =>
			@sortCallback e,args
		)
		@grid.render()

	renderMultiSelectGrid: ->
		checkboxSelector = new Slick.CheckboxSelectColumn({
			cssClass: "slick-cell-checkboxsel"
		});
		@columns.splice(0,0,checkboxSelector.getColumnDefinition())  #Add the checkbox column
		@grid = new Slick.Grid(@$().find(".grid"), @dataView, @columns, @options)
		@rowSelectionModel = new Slick.RowSelectionModel({selectActiveRow: false})
		@grid.setSelectionModel(@rowSelectionModel)
		@grid.registerPlugin(checkboxSelector)
		@dataView.syncPagedGridSelection(@grid, true);
		@grid.onSelectedRowsChanged.subscribe((e, args) =>
			@multiRowSelectionCallback e,args
		)
		
	renderSingleSelectGrid: ->
		@grid = new Slick.Grid(@$().find(".grid"), @dataView, @columns, @options)
		@rowSelectionModel = new Slick.RowSelectionModel()
		@grid.setSelectionModel(@rowSelectionModel)
		@grid.onSelectedRowsChanged.subscribe((e, args) =>
			@rowSelectionCallback e,args
		)
		@dataView.syncGridSelection(@grid, true);

	extendOptions: ->
		# Allow custom options to be specified in the markup
		# e.g. {{view Pad.CustomList ... options="{\"enableColumnReorder\": false}"
		customOptions = if @get("options") then JSON.parse(@get('options')) else {}
		@set("options", $.extend({}, @get('defaults'), customOptions))

	willDestroyElement: ->
		@grid.onClick.unsubscribe(->)
		@grid.destroy()

	rowSelectionCallback: (e, range) ->
		# When paging occurs (single-select) there may be nothing on the page
		if range.rows.length
			# Check that the item is not already selected. 
			# If it is, we dont want to trigger an update
			newSelectedRow = @getSelectedRow(range)
			if not (@get('rowSelection')? and @get('rowSelection').id == newSelectedRow.id)
				@.set('rowSelection', newSelectedRow)
		e.stopPropagation

	multiRowSelectionCallback: (e, range) ->

		# Rebuild the selection from the dataView
		ids = @grid.selectedRowIds
		rowSelection = []
		for id in ids
			rowSelection.push(this.grid.getData().getItemById(id))
		@set("rowSelection", rowSelection)

		#if range.rows.length
		#	@.set('rowSelection', @getSelectedRows(range))
		#	console.log 'selection...'
		e.stopPropagation

	getSelectedRow: (range) ->
		row = @grid.getDataItem range.rows[0]

	getSelectedRows: (range) ->
		rows = []
		for item in range.rows
			rows.push(@grid.getDataItem item)
		return rows

	sortCallback: (e, args) ->
		console.log 'sort'
		if args.multiColumnSort
			@get('controller').sortMultiColumn(args.sortCols)
		else
			@get('controller').sortSingleColumn(args.sortCol, args.sortAsc)

Tent.SlickGrid.STYLES = 
	FORM: "form"
	WIDE: "wide"
