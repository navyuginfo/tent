require '../template/jqgrid'
require '../mixin/grid/collection_support' 
require '../mixin/grid/export_support'

###*
* @class Tent.JqGrid
* @mixins Tent.ValidationSupport
* @mixins Tent.MandatorySupport
* @mixins Tent.Grid.CollectionSupport
* @mixins Tent.Grid.ExportSupport
*
* Create a jqGrid view which displays the data provided by its content property
*
* ##Usage
*		{{view Tent.JqGrid
                  label="Tasks"
                  contentBinding="Pad.gridContent"
                  selectionBinding="Pad.selectedTasks"
                  multiSelect=true             
              }}
*
* - content: An array of objects, one for each row
* - columns: An array of column descriptors
* - selection: An array of selected objects. This will provide the initial selections, as well as 
* contain the items selected from the grid.
###

Tent.JqGrid = Ember.View.extend Tent.ValidationSupport, Tent.MandatorySupport, Tent.Grid.CollectionSupport, Tent.Grid.ExportSupport,
	templateName: 'jqgrid'
	classNames: ['tent-jqgrid']
	classNameBindings: ['fixedHeader', 'hasErrors:error']

	###*
	* @property {String} title The title caption to appear above the table
	###
	title: null

	###*
	* @property {Boolean} multiSelect Boolean indicating that the list is a multi-select list
	###
	multiSelect: false

	###*
	* @property {Boolean} fixedHeader Boolean indicating that the header remains in view when the content is scrolled.
	###
	fixedHeader: false

	###*
	* @property {Boolean} showColumnChooser Display a button at the top of the grid which presents
	* a dialog to show/hide columns. Any columns which have a property **'hideable:false'** will not be shown
	* in this dialog
	###
	showColumnChooser: true

	###*
	* @property {Boolean} showMaximizeButton Display a button at the top of the grid which presents
	* a dialog to maximize the grid view.
	###
	showMaximizeButton: true

	###*
	* @property {Function} onEditRow A callback function which will be called when a row is made editable. 
	* The context of the function is this JqGrid View, and it will accept the following parameters:
	* 
	* -rowId: the id of the selected row
	* -grid: the jqGrid
	*  
	###
	onEditRow: null

	###*
	* @property {Function} onRestoreRow A callback function which will be called when editing of a row is cancelled,
	* and the original values restored to the cells. 
	* The context of the function is this JqGrid View, and it will accept the following parameters:
	* 
	* -rowId: the id of the selected row
	* -grid: the jqGrid
	*  
	###
	onRestoreRow: null

	###*
	* @property {Function} onSaveCell A callback function which will be called when an editable cell is saved. (This 
	* usually occurs on change or blur) 
	* The context of the function is this JqGrid View, and it will accept the following parameters:
	* 
	* -rowId: the id of the selected row
	* -grid: the jqGrid
	* -cellName: the name of the edited cell
	* -iCell: the position of the edited cell
	*
	###
	onSaveCell: null

	###*
	* @property {Boolean} Set this property to true to deselect all the selected items and restore all the editable fields. 
	###
	clearAction: null
	fullScreen: false
	 

	###*
	* @property {Array} content The array of items to display in the grid.
	* By default this will be retrieved from the collection, if provided
	###
	contentBinding: 'collection'

	###*
	* @property {Array} columns The array of column descriptors used to represent the data. 
	* By default this will be retrieved from the collection, if provided
	###
	columnsBinding: 'collection.columnsDescriptor'

	###*
	* @property {Array} selection The array of items selected in the list. This can be used as a setter
	and a getter.
	###
	selection: []

	init: ->
		@_super()
		
		widget = @
		$.subscribe("/ui/refresh", ->
			widget.resizeToContainer()
		)

	selectionDidChange: (->
		@updateGrid()
	).observes('selection.@each')

	selectedIds: (->
		#selectedIDs should observe selection
		sel = []
		for item in @get('selection')
			id = "" + item.get('id')
			sel.pushObject(id)
		return sel
	).property('selection.@each')

	valueForMandatoryValidation: (->
		@get('selection')
	).property('selection')

	focus: ->
		@getTableDom().focus()

	didInsertElement: ->
		@_super()
		@setupDomIDs()
		@buildGrid()
		@gridDataDidChange()
		@columnsDidChange()

	setupDomIDs: ->
		@set('tableId', @get('elementId') + '_jqgrid')
		@$('.grid-table').attr('id', @get('tableId'))
		@$('.gridpager').attr('id', @get('elementId') + '_pager')

	getTableDom: ->
		@$('#' + @get('tableId'))

	getTopPagerId: ->
		'#' + @get('tableId') + '_toppager_left'

	getPagerId: ->
		'#' + @get('elementId') + '_pager'

	getColModel: ->
		this.getTableDom().getGridParam('colModel')

	buildGrid: ->
		widget = @
		@getTableDom().jqGrid({
			parentView: widget
			datatype: (postdata) ->
				widget.onPageOrSort(postdata)
			height: @get('height') or 'auto',
			colNames: @get('colNames'),
			colModel: @get('columnModel'),
			multiselect: @get('multiSelect'),
			caption: Tent.I18n.loc(@get('title')) if @get('title')?, 
			autowidth: true,
			sortable: true, #columns can be dragged
			forceFit: true, #column widths adapt when one is resized
			shrinkToFit: true,
			viewsortcols: [false,'vertical',false],
			hidegrid: false, # display collapse icon on top right
			viewrecords: true, # 'view 1 - 6 of 27'
			rowNum: @get('pageSize') if @get('paged'),
			gridview: true,
			toppager:false,
			cloneToTop:false,
			#cellEdit: true,
			#cellsubmit: 'clientArray',
			editurl: 'clientArray',
			#scroll: true,
			pager: @getPagerId() if @get('paged'),
			#pgbuttons:false, 
			#recordtext:'', 
			#pgtext:''
			onSelectRow: (itemId, status, e) ->
				widget.didSelectRow(itemId, status, e)
			,
			onSelectAll: (rowIds, status) ->
				widget.didSelectAll(rowIds, status)
		})

		@addNavigationBar()
		@gridDataDidChange()


	didSelectRow: (itemId, status, e)->
		if not @get('multiSelect')
			@selectItemSingleSelect(itemId)
		else 
			@selectItemMultiSelect(itemId, status)

	selectItemSingleSelect: (itemId) ->
		@clearSelection()
		@selectItem(itemId)
		#@showEditableCells(itemId)

	selectItemMultiSelect: (itemId, status) ->
		if status #status indicates whether the row is being selected or unselected
				@selectItem(itemId)
			else 
				@deselectItem(itemId)
		#@showEditableCells(itemId)

	showEditableCells: ->
		if @getTableDom()?
			for id in @getTableDom().jqGrid('getDataIDs')
				if @get('selectedIds').contains(id)
					@editRow(id)
				else
					@restoreRow(id)

	didSelectAll: (rowIds, status) ->
		originalRowsIds = rowIds.filter(-> true)
		for id in originalRowsIds
			if status
				if !@get('selectedIds').contains(id)
					@selectItem(id)
			else 
				@deselectItem(id)

	clearSelection: ->
		@get('selection').clear()

	selectItem: (itemId) ->
		@get('selection').pushObject(@getItemFromModel(itemId))

	deselectItem: (itemId) ->
		@removeItemFromSelection(itemId)

	removeItemFromSelection: (id)->
		@set('selection', @get('selection').filter((item, index)->
				item.get('id') != parseInt(id)
			)
		)

	# When a row is deselected, revert to the previous value 
	restoreRow: (rowId) ->
		#@getTableDom().jqGrid('saveRow', rowId)
		@getTableDom().jqGrid('restoreRow', rowId)
		@saveEditedRow(rowId)
		@get('onRestoreRow').call(@, rowId, @getTableDom()) if @get('onRestoreRow')?

	# Make all editable cells editable
	editRow: (rowId) ->
		@getTableDom().jqGrid('editRow', rowId, false,  @onEditFunc())

	onEditFunc: (rowId) ->
		widget = @
		(rowId) ->
			widget.get('onEditRow').call(widget, rowId, widget.getTableDom()) if widget.get('onEditRow')?

	getItemFromModel: (id)->
		for model in @get('content').toArray()
			return model if model.get('id') == parseInt(id)

	# Called by a cell widget on blur or change
	saveEditableCell: (element)->
		rowId = $(element).parents('tr:first').attr('id')
		cellpos = $(element).parents('tr').children().index($(element).parents('td'))
		cellName = @getColModel()[cellpos].name
		@saveEditedCell(rowId, cellName, null, null, null, $(element).parent())
		@onSaveCell.call(@, rowId, @getTableDom(), cellName, cellpos) if @onSaveCell?

	saveEditedRow: (rowId, status, options)->
		rowData = @getTableDom().getRowData(rowId)
		for col in @getColModel()
			if col.editable
				@saveEditedCell(rowId, col.name, rowData[col.name])

	saveEditedCell: (rowId, cellName, value, iRow, iCell, cell) ->
		# Need to unformat/validate the value before saving 
		formatter = @getTableDom().getColProp(cellName).formatter
		#if formatter?
		if $.fn.fmatter[formatter]?
			if cell?
				@getItemFromModel(rowId).set(cellName, $.fn.fmatter[formatter].unformat(null, {}, cell))
			else
				@getItemFromModel(rowId).set(cellName, $.fn.fmatter[formatter].unformat(value))
		else 
			@getItemFromModel(rowId).set(cellName, value)
		#@getTableDom().triggerHandler()

	markErrorCell: (rowId, iCell) ->
		cell = @getTableDom().find('#'+rowId ).children().eq(iCell)
		cell.addClass('error')

	unmarkErrorCell: (rowId, iCell) ->
		cell = @getTableDom().find('#'+rowId ).children().eq(iCell)
		cell.removeClass('error')

	###*
	* @method sendAction send an action to the router. This is called from the 'action' formatter,
	* which displays cell content as a link
	###
	sendAction: (action, element, rowId)->
		view = @
		while not view.get('controller') and view.get('parentView')?
			view = view.get('parentView')
		if view.get('controller')?
			view.get('controller.namespace.router').send(action, @getItemFromModel(rowId) ) if @get('parentView.controller.namespace.router')?

	addNavigationBar: ->
		@_super()
		tableDom = @getTableDom()
		@renderColumnChooser(tableDom)
		@renderMaximizeButton()
		
	renderColumnChooser: (tableDom)->
		widget =  @
		if @get('showColumnChooser')
			# Ensure that the caption header is displayed
			if not @get('title')?
				tableDom.setCaption('&nbsp;')

			@$(".ui-jqgrid-titlebar").append('<a class="column-chooser"><span class="ui-icon ui-icon-newwin"></span>' + Tent.I18n.loc("jqGrid.hideShowCaption") + '</a>')
			@$('a.column-chooser').click(() ->
				tableDom.jqGrid('setColumns',{
					caption: Tent.I18n.loc("jqGrid.hideShowTitle"),
					showCancel: false,
					ShrinkToFit: true,
					recreateForm: true,
					updateAfterCheck: true,
					colnameview: false,
					top: 60,
					width: 300,
					afterSubmitForm: (itemId, status, e) ->
						widget.columnsDidChange()
					,
				})
			)

	columnsDidChange: ->
		if (@get('fixedHeader'))
			@adjustHeightForFixedHeader()

	adjustHeightForFixedHeader: () ->
		top = @$('.ui-jqgrid-htable').height() + @$('.ui-jqgrid-titlebar').height() + 6
		@$('.ui-jqgrid-bdiv').css('top', top)


	renderMaximizeButton: ->
		widget = @
		if @get('showMaximizeButton')
			@$(".ui-jqgrid-titlebar").append('<a class="maximize"><span class="ui-icon ui-icon-arrow-4-diag"></span> </a>')
			@$('a.maximize').click(() ->
				widget.toggleFullScreen(@)
			)

	toggleFullScreen: (a)->
		if @get('fullScreen')
			@$().removeClass('maximized')
			$('span', a).removeClass('ui-icon-arrow-1-se')
			$('span', a).addClass('ui-icon-arrow-4-diag')
			@set('fullScreen', false)
			@resizeToContainer() 
		else 
			@$().addClass('maximized')
			$('span', a).removeClass('ui-icon-arrow-4-diag')
			$('span', a).addClass('ui-icon-arrow-1-se')
			@set('fullScreen', true)
			@resizeToContainer()

	resizeToContainer: ->
		if @$()?
			@getTableDom().setGridWidth(@$().width())


	# Adapter to get column names from current datastore columndescriptor version  
	colNames: (->
		names = []
		for column in @get('columns')
			names.pushObject(Tent.I18n.loc(column.title))
		names
	).property('columns')

	# Adapter to get column descriptors from current datastore columndescriptor version 
	columnModel: (->
		columns = []
		for column in @get('columns')
			item = 
				name: column.name
				index: column.name
				align: column.align
				editable: column.editable
				formatter: column.formatter
				formatoptions: column.formatoptions
				edittype: Tent.JqGrid.editTypes[column.formatter] or 'text'
				editoptions: column.editoptions or Tent.JqGrid.editOptions[column.formatter]
				editrules: column.editrules or Tent.JqGrid.editRules[column.formatter]
				width: column.width or 20
				position: "right"
				hidden: column.hidden
				hidedlg: true if column.hideable == false
			columns.pushObject(item)
		columns
	).property('columns')
 
	# Adapter to get grid data from current datastore in a format compatible with jqGrid 
	gridData: (->
		models = @get('content').toArray()
		grid = []
		for model in models
			item = {"id" : model.get('id')}
			if @get('selectedIds').contains(model.get('id'))
				item.sel = true
			cell = []
			for column in @get('columnModel')
				#item[column.name] = model.get(column.name)
				cell.push(model.get(column.name))
			item.cell = cell
			grid.push(item)
		return grid
	).property('content','content.isLoaded', 'content.@each')

	gridDataDidChange: (->
		# remove existing grid data
		@getTableDom().jqGrid('clearGridData')
		data = 
			rows: @get('gridData')
			total: @get('totalPages')
			records: @get('totalRows')
			page: @get('pagingData').page
		@getTableDom()[0].addJSONData(data)
		@updateGrid()
	).observes('content', 'content.isLoaded', 'content.@each')

	updateGrid: ->
		if (@getTableDom())
			@highlightRows(@getTableDom().get(0))
			@showEditableCells()
			@validate()

	highlightRows: (grid)->
		if @getTableDom()?
			if not grid?
				grid = @getTableDom().get(0)
			if @getTableDom()?
				for id in @getTableDom().jqGrid('getDataIDs')
					if (@isRowSelected(id))
						@getTableDom().jqGrid('setSelection', id, false)
				for item in @get('selectedIds')
					@highlightRow(item)
				@setSelectAllCheckbox(grid)

	isRowSelected: (id)->
		# Is the row registered as selected within jqGrid
		this.getTableDom().get(0).p.selarrrow.contains(id)

	highlightRow: (item)->
		if @getTableDom()?
			@getTableDom().jqGrid('setSelection', item, false)
			#@editRow(item)

	unHighlightAllRows: (->
	  if (@get("clearAction") &&  @getTableDom()?)
	      a = @get("selectedIds").slice()
	      that = this
	      a.forEach (item) ->
	        that.selectItemMultiSelect item, false
	      @set "clearAction", false
	      @getTableDom().jqGrid "resetSelection"
	).observes("clearAction")

	setSelectAllCheckbox: (grid) ->
		if @allRowsAreSelected(grid)
			grid.setHeadCheckBox(true)
		else
			grid.setHeadCheckBox(false)

	allRowsAreSelected: (grid) ->
		# Check for state of selectAll checkbox
		selectedIds = @get('selectedIds')
		allSelected = true
		for id in $(grid).jqGrid('getDataIDs')
			if !selectedIds.contains(id)
				allSelected = false
		allSelected




