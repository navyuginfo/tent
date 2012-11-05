require '../template/jqgrid'

###*
* @class Tent.JqGrid
* @extends Ember.View
*
* Create a jqGrid view which displays the data provided by a Collection object
* The grid will bind to the following properties of the collection:
* 	
* - columnsDescriptor: an array of descriptor objects defining the columns to be displayed
* 			e.g. [
				{id: "id", name: "id", title: "_hID", field: "id", sortable: true, hideable: false},
				{id: "title", name: "title", title: "_hTitle", field: "title", sortable: true},
				{id: "amount", name: "amount", title: "_hAmount", field: "amount", sortable: true, formatter: "amount",  align: 'right'},
			]
* - totalRows: the total number of rows in the entire result set (including pages not visible)
* - totalPages: The total number of pages of data available
*
* The collection should also provide the following methods:
*
* - sort(sortdata): Sort the collection according to the sortdata provided
* 			e.g. 
				{fields: [
							sortAsc: true
							field: 'title'
					]
				}
*				
* - goToPage(pageNumber): Navigate to the pagenumber provided (1 = first page)
*
* ##Usage
*		{{view Tent.JqGrid
                  label="Tasks"
                  collectionBinding="Pad.tasksCollection"
                  selectionBinding="Pad.selectedTasks"
                  paged=true
                  pageSize=6           
                  multiSelect=true             
              }}
*
*
###

Tent.JqGrid = Ember.View.extend Tent.ValidationSupport, Tent.MandatorySupport,
	templateName: 'jqgrid'
	classNames: ['tent-jqgrid']
	classNameBindings: ['fixedHeader', 'hasErrors:error']
	
	###*
	* @property {Object} collection The collection object providing the API to the data source
	###
	collection: null

	###*
	* @property {String} title The title caption to appear above the table
	###
	title: null

	###*
	* @property {Boolean} paged Boolean to indicate the data should be presented as a paged list
	###
	paged: true

	###*
	* @property {Number} pageSize The number of items in each page
	###
	pageSize: 12

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
	* @property {Boolean} showExportButton Display a button in the header which allows the table data to 
	* be exported a selected format.
	###
	showExportButton: true

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
	pagingData: 
		page: 1 
	sortingData: {}
	selectedIds: []
	contentBinding: 'collection'

	###*
	* @property {Array} columnsBinding The array of column descriptors used to represent the data. 
	* By default this will be retrieved from the collection
	###
	columnsBinding: 'collection.columnsDescriptor'
	totalRowsBinding: 'collection.totalRows'
	totalPagesBinding: 'collection.totalPages'

	init: ->
		widget = @
		@_super()
		if not @get('collection')?
			throw new Error("Collection must be provided for Tent.JqGrid")

		if @get('paged')
			@get('collection').set('pageSize', @get('pageSize'))

		@setupInitialSelection()
		$.subscribe("/ui/refresh", ->
			widget.resizeToContainer()
		)

	setupInitialSelection: (->
		if @get('selection')?
			sel = []
			 
			for item in @get('selection')
				id = "" + item.get('id')
				sel.pushObject(id)
				if not @get('selectedIds').contains(id)
					@highlightRow(id)
			@set('selectedIds', sel.uniq())

		if @getTableDom()
			@setSelectAllCheckbox(@getTableDom().get(0))
	).observes('selection')

	selectionDidChange: (->
		@validate()
	).observes('selection.@each')

	valueForMandatoryValidation: (->
		@get('selection')
	).property('selection')

	focus: ->
		@getTableDom().focus()

	didInsertElement: ->
		@setupDomIDs()
		@buildGrid()
		@get('collection').goToPage(1)
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
			,
			loadComplete: () ->
				widget.highlightRows(@)
			#,
			#jqGridInlineEditRow: (rowId, o) ->
			#	console.log 'edit..'
		})

		@addNavigationBar()
		@gridDataDidChange()

	onPageOrSort: (postdata)->
		#	postdata is of the form:
		#       _search: false,	nd: 1349351912240, page: 1, rows: 12, sidx: "", sord: "asc"
		if @shouldSort(postdata)
			@get('collection').sort(
				fields: [
					sortAsc: postdata.sord=="asc"
					field: postdata.sidx
				])
		else 
			@get('pagingData').page = postdata.page
			@get('collection').goToPage(postdata.page)

		@get('sortingData').field = postdata.sidx
		@get('sortingData').asc = postdata.sord

	shouldSort: (postdata)->
		postdata.sidx!="" and (postdata.sidx != @get('sortingData').field or postdata.sord != @get('sortingData').asc)

	highlightRows: (grid)->
		if @getTableDom()?
			for item in @get('selectedIds')
				@highlightRow(item)
			@setSelectAllCheckbox(grid)

	highlightRow: (item)->
		if @getTableDom()?
			@getTableDom().jqGrid('setSelection', item, false)
			@editRow(item)

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

	didSelectRow: (itemId, status, e)->
		if not @get('multiSelect')
			@selectItemSingleSelect(itemId)
		else 
			@selectItemMultiSelect(itemId, status)

	selectItemSingleSelect: (itemId) ->
		@clearSelection()
		@selectItem(itemId)
		@showEditableCellsSingleSelect(itemId)

	selectItemMultiSelect: (itemId, status) ->
		if status #status indicates whether the row is being selected or unselected
				@selectItem(itemId)
			else 
				@deselectItem(itemId)
		@showEditableCellsMultiSelect(itemId)

	showEditableCellsSingleSelect: (itemId) ->
		if itemId != @get('lastSelectedRowId')
			if @get('lastSelectedRowId')?
				@restoreRow(@get('lastSelectedRowId'))
			@editRow(itemId)
			@set('lastSelectedRowId', itemId)

	showEditableCellsMultiSelect: (itemId)->
		if @get('selectedIds').contains(itemId) 
			@editRow(itemId)
		else
			@restoreRow(itemId)

	didSelectAll: (rowIds, status) ->
		for id in rowIds
			if status
				if !@get('selectedIds').contains(id)
					@selectItem(id)
					@editRow(id)
			else 
				@deselectItem(id)
				@restoreRow(id)

	clearSelection: ->
		@get('selectedIds').clear()
		@get('selection').clear()

	selectItem: (itemId) ->
		@get('selectedIds').pushObject(itemId)
		@get('selection').pushObject(@getItemFromModel(itemId))

	deselectItem: (itemId) ->
		@get('selectedIds').removeObject(itemId)
		@removeItemFromSelection(itemId)

	removeItemFromSelection: (id)->
		@set('selection', @get('selection').filter((item, index)->
				item.get('id') != parseInt(id)
			)
		)

	# When a row is deselected, revert to the previous value 
	restoreRow: (rowId) ->
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
	* @method sendAction send and action to the router. This is called from the 'action' formatter
	###
	sendAction: (action, element, rowId)->
		view = @
		while not view.get('controller') and view.get('parentView')?
			view = view.get('parentView')
		if view.get('controller')?
			view.get('controller.namespace.router').send(action, @getItemFromModel(rowId) ) if @get('parentView.controller.namespace.router')?

	addNavigationBar: ->
		tableDom = @getTableDom()
		widget = @
		#tableDom.jqGrid('navGrid', @getPagerId(), {add:false,edit:false,del:false,search:false,refresh:false})

		@renderColumnChooser(tableDom)
		@renderExportButton(tableDom)
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


	renderExportButton: (tableDom)->
		if @get('showExportButton') 
			# Ensure that the caption header is displayed
			if not @get('title')?
				tableDom.setCaption('&nbsp;')

			button = """
				<div class="btn-group export">
					<a class="" data-toggle="dropdown" href="#">
					Export
					<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a class="export-json">#{Tent.I18n.loc("jqGrid.export.json")}</a></li>
						<li><a class="export-xml">#{Tent.I18n.loc("jqGrid.export.xml")}</a></li>
						<li><a class="export-csv">#{Tent.I18n.loc("jqGrid.export.csv")}</a></li>
                        <li><a href="#{@get('collection').getURL('xlsx')}">#{Tent.I18n.loc("jqGrid.export.xlsx")}</a></li>
					</ul>
				</div>
			"""
			@$(".ui-jqgrid-titlebar").append(button)

			@$('a.export-json').click =>
				ret = $.fn.xmlJsonClass.toJson(tableDom.getRowData(),"data","    ",true)
				@clientDownload(ret)
		 
			@$('a.export-xml').click =>
				ret = "<root>" + $.fn.xmlJsonClass.json2xml(tableDom.getRowData(),"    ")+"</root>"
				@clientDownload(ret)

			@$('a.export-csv').click =>
				ret = @exportCSV(tableDom.getRowData(), @getColModel())
				@clientDownload(ret)


	clientDownload: (file) ->
		# Allow the client to save the generated file.
		# For no just print to a window
		if navigator.appName != 'Microsoft Internet Explorer'
			window.open('data:text/csv;charset=utf-8,' + escape(file))
		else
			popup = window.open('', 'csv', '')
			popup.document.body.innerHTML = '<pre>' + file + '</pre>'

	exportCSV: (data, keys)->

		orderedData = [];
		for obj in data
		#for (var i = 0, iLen = data.length; i < iLen; i++) {
		#	temp = data[i];
			arr = []
			for key, value of obj
				arr.push(value)
			orderedData.push(arr);

		if @get('multiSelect')
			keys = keys[1..]

		str = ""
		str += obj.name + ',' for obj in keys
		str  = str.slice(0,-1) + '\r\n' + orderedData.join('\r\n')

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
		@highlightRows(@getTableDom().get(0))
		#@showEditableCells()
	).observes('content', 'content.isLoaded', 'content.@each')
