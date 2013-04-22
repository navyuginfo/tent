require '../template/jqgrid'
require '../mixin/grid/collection_support' 
require '../mixin/grid/selection_support' 
require '../mixin/grid/data_adapters'
require '../mixin/grid/export_support'
require '../mixin/grid/editable_support'
require '../mixin/grid/grouping_support'
require '../mixin/grid/column_chooser_support'
require '../mixin/grid/column_menu'
require '../mixin/toggle_visibility'
require '../mixin/grid/maximize_grid'

###*
* @class Tent.JqGrid
* @mixins Tent.ValidationSupport
* @mixins Tent.MandatorySupport
* @mixins Tent.Grid.CollectionSupport
* @mixins Tent.Grid.SelectionSupport
* @mixins Tent.Grid.Adapters
* @mixins Tent.Grid.ExportSupport
* @mixins Tent.Grid.EditableSupport
* @mixins Tent.Grid.GroupingSupport
* @mixins Tent.Grid.ColumnChooserSupport
* @mixins Tent.Grid.ColumnMenu
* @mixins Tent.Grid.Maximize
* 
*
* Create a jqGrid view which displays the data provided by its content property
*
* ##Usage
*		{{view Tent.JqGrid
                  label="Tasks"
                  collectionBinding="Pad.collection"
                  selectionBinding="Pad.selectedTasks"
                  multiSelect=true             
              }}
*
* - collection: A collection representing an array of records, one for each row of the grid.
* - selection: An array of selected objects. This will provide the initial selections, as well as 
* contain the items selected from the grid.
*
* The content of the grid will be bound to the collection.
* The columns for the grid will be bound to collection.columnsDescriptor
###

Tent.JqGrid = Ember.View.extend Tent.ValidationSupport, Tent.MandatorySupport, Tent.Grid.CollectionSupport, Tent.Grid.SelectionSupport, Tent.Grid.Adapters, Tent.Grid.ColumnChooserSupport, Tent.Grid.ExportSupport, Tent.Grid.EditableSupport, Tent.Grid.ColumnMenu, Tent.Grid.GroupingSupport, Tent.ToggleVisibility, Tent.Grid.Maximize,
	templateName: 'jqgrid'
	classNames: ['tent-jqgrid']
	classNameBindings: ['fixedHeader', 'hasErrors:error', 'paged']

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
	* @property {Boolean} filtering A boolean to indicate that the grid can be filtered.
	###
	filtering: false

	###*
	* @property {Boolean} grouping A boolean to indicate that the grid can be grouped.
	###
	grouping: true

	###*
	* @property {String} groupField The name of the field by which to group the grid
	###
	groupField: null

	###* 
	* @property {Boolean} clearAction Set this property to true to deselect all the selected items and restore all the editable fields. 
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
	#columnsBinding: 'collection.columnsDescriptor'

	###*
	* @property {Array} selection The array of items selected in the list. This can be used as a setter
	* and a getter.
	###
	selection: []

	init: ->
		@_super()
		#@set('selection',[]) if not @get('selection')?

	valueForMandatoryValidation: (->
		@get('selection')
	).property('selection')

	focus: ->
		@getTableDom().focus()

	didInsertElement: ->
		@_super()
		widget = @
		$.subscribe("/ui/refresh", ->
			widget.resizeToContainer()
			if widget.$()?
				widget.columnsDidChange()
		)
		@setupDomIDs()
		@bindHeaderView()
		@drawGrid()

	# The header is a separate View, so we provide it with a reference to the grid
	# in case it needs it.
	bindHeaderView: ->
		@getHeaderView().set('grid', @)

	getHeaderView: ->
		Ember.View.views[@$('.grid-header').attr('id')]
  
	drawGrid: ->
		@setupColumnTitleProperties()
		@setupColumnWidthProperties()
		@setupColumnVisibilityProperties()
		@buildGrid()
		@gridDataDidChange()
		@addNavigationBar()
		@setupColumnGroupingProperties()
		@setupColumnOrderingProperties()

	applyStoredPropertiesToGrid: ->
		if @get('collection.personalizable')
			@set('columnModel', {}) #reset the columnModel
			@setupColumnTitleProperties();
			@setupColumnWidthProperties();
			@setupColumnVisibilityProperties();
			@clearAllGrouping();
			@getTableDom().GridUnload();
			@buildGrid();
			@setupColumnGroupingProperties();
			@setupColumnOrderingProperties();

	willDestroyElement: ->
		if @get('fullScreen')
			@removeBackdrop()

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
			#sortable: true, #columns can be dragged		    
			sortable: { 
				update: (permutation) =>
					@columnsDidChange()
			}
			resizeStop: (width, index)=>
				# Fires when a column is finished resizing
				@columnsDidChange(index)
			loadComplete:widget.get('content.isLoaded')
			loadtext: '<div class="wait"><i class="icon-spinner icon-spin icon-2x"></i></div>',
			forceFit: true, #column widths adapt when one is resized
			shrinkToFit: true,
			viewsortcols: [true,'vertical',false],
			hidegrid: false, # display collapse icon on top right
			viewrecords: true, # 'view 1 - 6 of 27'
			rowNum: if @get('paged') then @get('pagingInfo.pageSize') else -1,
			gridview: true,
			toppager:false,
			cloneToTop:false,
			#cellEdit: true,
			#cellsubmit: 'clientArray',
			editurl: 'clientArray',
			#scroll: true,
			pager: @getPagerId() if @get('paged'),
			toolbar: [false,"top"],
			grouping: @get('grouping')
			onSelectRow: (itemId, status, e) ->
				widget.didSelectRow(itemId, status, e)
			,
			onSelectGroup: (itemId, status, e) ->
				widget.didSelectGroup(itemId, status, e)
			,
			onSelectAll: (rowIds, status) ->
				widget.didSelectAll(rowIds, status)
		})

		#@$('.ui-jqgrid-titlebar').remove()
		@setInitialViewRecordsAttribute()
		@addMarkupToHeaders()
		@addColumnDropdowns()
		#@gridDataDidChange()
		@resizeToContainer()
		@columnsDidChange()
		@getTableDom().bind('jqGridRemapColumns', (e, permutation, updateCells, keepHeader)=>
			if keepHeader then @storeColumnOrderingToCollection(permutation)
		)
			
	setInitialViewRecordsAttribute:()->
	    ###
	    * Set initial value of viewrecords to be false so that the text "no records to view" does not
	    * appear when page is refreshed or is first visited, this was not possible in initial definition
	    * of jqGrid as jqGrid never shows viewrecords if it is set false in first call to jqGrid
	    ###
	    @getTableDom()[0].p.viewrecords = false

	getItemFromModel: (id, contentArray)-> 
		intValue = parseInt(id)
		@get('content').find((item)->
			item.get('id') == intValue
		)

	markErrorCell: (rowId, iCell) ->
		@getCell(rowId, iCell).addClass('error')

	unmarkErrorCell: (rowId, iCell) ->
		@getCell(rowId, iCell).removeClass('error')

	getCell: (rowId, iCell) ->
		return @getTableDom().find('#'+rowId ).children().eq(iCell)

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

	# jqGrid-generated markup is not granular enough for the styling that we want.
	# Here we add the markup rather than modifying the plugin code.
	addMarkupToHeaders: ->
		@$('.ui-th-column div').each(()->
			$(this).contents().filter(()->
				this.nodeType == 3
			).replaceWith($('<span class="title">' + $(this).text() + '</span>'))
		)

	addNavigationBar: ->
		@_super()

	columnsDidChange: (colChangedIndex)->
		@_super()
		@adjustHeight()
		@removeLastDragBar()
		@storeColumnDataToCollection()

	# After any changes to the dimensions of the grid, re-calculate for display
	adjustHeight: ->
		if @get('fixedHeader')
			top = @$('.ui-jqgrid-htable').height() # + @$('.grid-header').height() + 6
			@$('.ui-jqgrid-bdiv').css('top', top)
			@$('.ui-jqgrid-bdiv').css('height', 'auto') if Tent.Browsers.isIE()
			@$('.ui-jqgrid-view').css('height', '100%') if not Tent.Browsers.isIE()
		else
			@$('.ui-jqgrid-bdiv').css('height', 'auto') if Tent.Browsers.isIE()

	removeLastDragBar: ->
		@$('.ui-th-column .ui-jqgrid-resize').show()
		@getLastColumn().find('.ui-jqgrid-resize').hide()

	getLastColumn: ->
		@$('.ui-th-column').filter(->
			$(this).css('display') != 'none'
		).last()

	resizeToContainer: ->
		if @$()?
			@getTableDom().setGridWidth(@$().width(), true)
			# Removed for performance reasons
			# @columnsDidChange()

	hideGrid: ->
		@$(".gridpager").hide()
		@$(".grid-table").hide()

	showGrid: ->
		@$(".gridpager").show()
		@$(".grid-table").show()

	showSpinner: (->
		if @get('content.isLoaded') or not @get('content.isLoaded')?
			@getTableDom()[0].endReq()
		else
			@getTableDom()[0].beginReq()
	).observes('content.isLoaded')

	updatePagingForGroups: (grid,data) ->
		grid.p.lastpage = data.total
		grid.p.page = @get('collection.currentGroupPage')
		grid.p.reccount = data.rows.length
		grid.p.records = data.records
		# show page message only when the content has been loaded
		if @get('content.isLoaded')
		  grid.p.viewrecords = true
		grid.updatepager(null, false)

	getColumnTitle: (columnName)->
		for col in @get('columns')
			if col.name == columnName
				return Tent.I18n.loc(col.title)
		return columnName

	# Bug in jqGrid: Calling addJSONData() causes the grouping to be recalculated, preserving previous
	# grouping so that they accumulate. We need to explicitly clear the grouping here.
	#
	resetGrouping: ->
		if @get('grouping')
			this.getTableDom().groupingSetup()
		#this.getTableDom()[0].p.groupingView.groups=[]

	selectedIds: (->
		#selectedIDs should observe selection
		sel = []
		if @get('selection')?
			for item in @get('selection') 
				id = "" + item.get('id')
				sel.pushObject(id)
		return sel

	).property('selection.@each')

	updateGrid: (doValidation)->
		if @getTableDom()?
			@unHighlightAllRows()
			@highlightRows()
			@showEditableCells()
		@validate() if doValidation
		$.publish("/grid/rendered")

	highlightRows: ()->
		table = @getTableDom()
		if table?
			grid = table.get(0)
			#table.jqGrid('resetSelection')
			for item in @get('selectedIds')
				@highlightRow(item, table)
			@setSelectAllCheckbox(grid)

	isRowSelectedMultiSelect: (id, grid)->
		# Is the row registered as selected within jqGrid
		grid.p.selarrrow.contains(id)

	isRowSelectedSingleSelect: (id, grid)->
		# Is the row registered as selected within jqGrid
		grid.p.selrow == id

	unHighlightAllRows: ()->
		table = @getTableDom()
		selectedIds = @get('selectedIds')
		for id in table.getDataIDs()
			if not selectedIds.contains(id)
				if @get('multiSelect')
					if @isRowSelectedMultiSelect(id, table.get(0))
						table.jqGrid('setSelection', id, false)
						@restoreRow(id, table)
				else
					if @isRowSelectedSingleSelect(id, table.get(0))
						table.jqGrid('setSelection', id, false)
						@restoreRow(id, table)
	
	highlightRow: (id, table)->
		table = table or @getTableDom()
		if table?
			if @get('multiSelect')
				if not @isRowSelectedMultiSelect(id, table.get(0))
					table.jqGrid('setSelection', id, false)
					@editRow(id, table)
			else
				if not @isRowSelectedSingleSelect(id, table.get(0))
					table.jqGrid('setSelection', id, false)
					@editRow(id, table)
			#@$('#'+id).addClass("ui-state-highlight").attr({"aria-selected":"true", "tabindex" : "0"});

	clearAllSelections: (->
		if (@get("clearAction") &&  @getTableDom()?)
			@set('selection',[])
			@set "clearAction", false
			#@gridDataDidChange()
	).observes("clearAction")

	setSelectAllCheckbox: (grid) ->
		if grid?
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

