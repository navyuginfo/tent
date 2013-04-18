require '../template/jqgrid'
require '../mixin/grid/collection_support' 
require '../mixin/grid/export_support'
require '../mixin/grid/editable_support'
require '../mixin/grid/grouping_support'
require '../mixin/grid/column_chooser_support'
require '../mixin/grid/column_menu'
require '../mixin/toggle_visibility'

###*
* @class Tent.JqGrid
* @mixins Tent.ValidationSupport
* @mixins Tent.MandatorySupport
* @mixins Tent.Grid.CollectionSupport
* @mixins Tent.Grid.ExportSupport
* @mixins Tent.Grid.EditableSupport
* @mixins Tent.Grid.ColumnMenu
* @mixins Tent.Grid.FilterSupport
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

Tent.JqGrid = Ember.View.extend Tent.ValidationSupport, Tent.MandatorySupport, Tent.Grid.CollectionSupport, Tent.Grid.ColumnChooserSupport, Tent.Grid.ExportSupport, Tent.Grid.EditableSupport, Tent.Grid.ColumnMenu, Tent.Grid.GroupingSupport, Tent.ToggleVisibility,
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
	and a getter.
	###
	selection: []

	resizeGridSteps: true
	resizeSpeed: 700

	init: ->
		@_super()
		#@set('selection',[]) if not @get('selection')?

	valueForMandatoryValidation: (->
		@get('selection')
	).property('selection')

	columns: (->
		@get('collection.columnsDescriptor')
	).property('collection.columnsDescriptor')

	focus: ->
		@getTableDom().focus()

	didInsertElement: ->
		console.log "didInsertElement"
		@_super()
		widget = @
		$.subscribe("/ui/refresh", ->
			widget.resizeToContainer()
			widget.columnsDidChange()
		)
		@setupDomIDs()
		@bindHeaderView()
		@drawGrid()

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
				#@replaceOriginalColumnWidthsWithNewOnes(width, index)
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
			#pgbuttons:false, 
			#recordtext:'', 
			#pgtext:''

			grouping: @get('grouping')
		#	groupingView: @{
		#		groupField: [@get('groupField')]
		#		groupText : ['<b>' + @getTitleForColumn(@get('groupField')) + ' = {0}</b>']
		#		groupDataSorted: true
		#	}
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
  
	didSelectRow: (itemId, status, e)->
		if not @get('multiSelect')
			@selectItemSingleSelect(itemId)
		else 
			@selectItemMultiSelect(itemId, status)
			
	setInitialViewRecordsAttribute:()->
	    ###
	    * Set initial value of viewrecords to be false so that the text "no records to view" does not
	    * appear when page is refreshed or is first visited, this was not possible in initial definition
	    * of jqGrid as jqGrid never shows viewrecords if it is set false in first call to jqGrid
	    ###
	    @getTableDom()[0].p.viewrecords = false
  
	selectItemSingleSelect: (itemId) ->
    	@clearSelection()
    	@selectItem(itemId)

	selectItemMultiSelect: (itemId, status) ->
		if status!=false #status indicates whether the row is being selected or unselected
			@selectItem(itemId)
		else 
			@deselectItem(itemId)

	didSelectAll: (rowIds, status) ->
		originalRowsIds = rowIds.filter(-> true)
		selectedIds = @get('selectedIds')
		if @get('paged')
			# We can optimise when we know all items are to be selected
			for id in originalRowsIds
				if status!=false
					if !selectedIds.contains(id)
						@selectItem(id)
				else 
					@deselectItem(id)
		else
			if status!=false
				@selectAllItems()
				for id in originalRowsIds
					#if !selectedIds.contains(id)
						@highlightRow(id)
						@editRow(id)
			else
				@clearSelection()
				@restoreRows(originalRowsIds)

	selectAllItems: ->
		@set('selection', @get('content').filter(-> true))

	clearSelection: ->
		@set('selection', [])

	selectItem: (itemId) ->
		@get('selection').pushObject(@getItemFromModel(itemId))
		@highlightRow(itemId)
		@showEditableCell(itemId)  ## 4.5

	deselectItem: (itemId) ->
		@removeItemFromSelection(itemId)
		@restoreRow(itemId)

	removeItemFromSelection: (id)->
		@set('selection', @get('selection').filter((item, index)->
				item.get('id') != parseInt(id)
			)
		)

	getItemFromModel: (id, contentArray)->  ## 2
		intValue = parseInt(id)
		@get('content').find((item)->
			item.get('id') == intValue
		)

	# A group was row was selected from the grid
	didSelectGroup: (itemId, status, e)->
		@selectRemoteGroup(itemId)

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
		tableDom = @getTableDom()
		#@renderColumnChooser(tableDom)
		@renderMaximizeButton()
		@_super()

	getLastColumn: ->
		@$('.ui-th-column').filter(->
			$(this).css('display') != 'none'
		).last()

	columnsDidChange: (colChangedIndex)->
		@_super()
		@adjustHeight()
		@removeLastDragBar()
		@storeColumnDataToCollection()


	replaceOriginalColumnWidthsWithNewOnes: (width, index)->
		totalSpan = 0
		for col in @getColModel()
			totalSpan = totalSpan + col.widthOrg if not col.hidden
		fullWidth = @$().outerWidth()
		newSpan = (totalSpan*width)/fullWidth
		widthOrg = @getColModel()[index+1].widthOrg
		@getColModel()[index+1].widthOrg = newSpan

		prevCol = @findPreviousVisibleColumn(index+1)
		if prevCol?
			@getColModel()[prevCol].widthOrg = @getColModel()[prevCol].widthOrg - (newSpan - widthOrg) 

	findPreviousVisibleColumn: (index) ->
		colModel = @getColModel()
		for pos in [index-1..1]
			return pos if not colModel[pos].hidden
		null

	removeLastDragBar: ->
		@$('.ui-th-column .ui-jqgrid-resize').show()
		@getLastColumn().find('.ui-jqgrid-resize').hide()

	# After any changes to the dimensions of the grid, re-calculate for display
	adjustHeight: ->
		if @get('fixedHeader')
			top = @$('.ui-jqgrid-htable').height() # + @$('.grid-header').height() + 6
			@$('.ui-jqgrid-bdiv').css('top', top)
			@$('.ui-jqgrid-bdiv').css('height', 'auto') if Tent.Browsers.isIE()
			@$('.ui-jqgrid-view').css('height', '100%') if not Tent.Browsers.isIE()
		else
			@$('.ui-jqgrid-bdiv').css('height', 'auto') if Tent.Browsers.isIE()

	renderMaximizeButton: ->
		widget = @
		if @get('showMaximizeButton')
			@$(".grid-header").append('<a class="maximize"><span class="ui-icon ui-icon-arrow-4-diag"></span> </a>')
			
			@$('a.maximize').click(() ->
				widget.toggleFullScreen(@)
			)


	toggleFullScreen: (a)->
		widget = @

		if @get('fullScreen')
			@restoreSize()
		else
			@maximize()

	maximize: () ->
		widget = @
		@set('currentTop', @$().offset().top - $(window).scrollTop())
		@set('currentLeft', @$().offset().left)
		@set('currentWidth', @$().outerWidth())
		@set('currentHeight', @$().outerHeight())
		@set('currentRight', $(window).width() - (@$().offset().left + @$().outerWidth()))
		@set('currentBottom', $(window).height() - (@$().offset().top + @$().outerHeight()))

		newWidth = $(window).width() - 60
		newHeight = $(window).height() - 120

		@$().css('top', @get('currentTop') + 'px')
		@$().css('left', @get('currentLeft') + 'px')
		@$().css('height', @get('currentHeight') + 'px')
		@$().css('width', @get('currentWidth') + 'px')
		@$().css('z-index', '2000')
		@$().css('position', 'fixed')
		@$().addClass('dialog')
		if not @get('resizeGridSteps')
			@hideGrid()

		$('body').append('<div id="jqgrid-backdrop" class=""></div>')
		$('#jqgrid-backdrop').animate(
			{
				opacity: '0.6'
			},
			200,
			=>
				@$().animate({
						width: newWidth + 'px', 
						height: if $(window).height() - 60 - @get('currentHeight') > 60 then 'auto' else newHeight + 'px', 
						top: '60px', 
						left: '30px', 
						right: '30px', 
						bottom: '60px'
					},
					{
						duration: @get('resizeSpeed'),
						complete: =>
							$('span', widget).removeClass('ui-icon-arrow-4-diag')
							$('span', widget).addClass('ui-icon-arrow-1-se')
							@set('fullScreen', true)
							@resizeToContainer()
							if not @get('resizeGridSteps')
								@showGrid()
						,
						step: =>
							@resizeToContainer()
					}
				)
		)

		@set('resizeEscapeHandler', @get('generateResizeEscapeHandler')(@))
		$('body').bind('keyup click', @get('resizeEscapeHandler'))	

	restoreSize: ->
		$('body').unbind('keyup click', @get('resizeEscapeHandler'))
		if not @get('resizeGridSteps')
			@hideGrid()
		
		@$().animate({
				width: @get('currentWidth') + 'px',
				height: @get('currentHeight') + 'px',
				top: @get('currentTop') + 'px', 
				left: @get('currentLeft') + 'px', 
				right: @get('currentRight') + 'px', 
				bottom: @get('currentBottom') + 'px'
			}, 
			{
				duration: @get('resizeSpeed'),
				complete: =>
					@$('.maximize > span').removeClass('ui-icon-arrow-1-se')
					@$('.maximize > span').addClass('ui-icon-arrow-4-diag')
					@set('fullScreen', false)
					@resizeToContainer() 
					@$().removeClass('dialog')
					if not @get('resizeGridSteps')
						@showGrid()
					@removeBackdrop()
				,
				step: =>
					@resizeToContainer()
			} 
		)

	removeBackdrop: ->
		$('#jqgrid-backdrop').animate(
			{
				opacity: '0.0'
			},
			900,
			=>
				$('#jqgrid-backdrop').remove()
				@$().css('position', 'static')
		)

	generateResizeEscapeHandler: (widget)->
		return (e)->
			if e.keyCode==27 or ($(e.target).attr('id') == 'jqgrid-backdrop')
				widget.toggleFullScreen()
				return

	resizeToContainer: ->
		if @$()?
			@getTableDom().setGridWidth(@$().width(), true)
			# Removed for performance reasons
			# @columnsDidChange()

	hideGrid: ->
		#@getTableDom().jqGrid('clearGridData')
		@$(".gridpager").hide()
		@$(".grid-table").hide()

	
	showGrid: ->
		#@gridDataDidChange()
		@$(".gridpager").show()
		@$(".grid-table").show()

	getTitleForColumn: (colName)->
		for column in @get('columns')
			return Tent.I18n.loc(column.title) if column.name==colName


	# Adapter to get column names from current datastore columndescriptor version  
	colNames: (->
		names = []
		for column in @get('columnModel')
			t = Tent.I18n.loc(column.title)
			if @get('columnInfo.titles')?
				for name, title of @get('columnInfo.titles')
        			t = title if column.name == name
			names.pushObject(t)
		names
	).property('columns')

	# Adapter to get column descriptors from current datastore columndescriptor version 
	columnModel: (->
		columns = Ember.A()
		if @get('columns')?
			for column in @get('columns')
				item = Ember.Object.create
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
					hidden: if column.hidden? then column.hidden else false
					hideable: column.hideable
					hidedlg: true if column.hideable == false
					sortable: column.sortable
					groupable: column.groupable
					resizable: true
					title: Tent.I18n.loc column.title
				columns.pushObject(item)
		columns
	).property('columns')
 
	# Adapter to get grid data from current datastore in a format compatible with jqGrid 
	gridData: (->
		grid = []

		if @get('content')?
			models = @get('content').toArray()
			if @isShowingValidGroups()
				for model in models
					grid.push(model)
			else
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
	 @getTableDom()[0].p.viewrecords = false
    #remove previous grid data
		@getTableDom().jqGrid('clearGridData')
		###
		* As soon as the required data is loaded set viewrecords attribute of jqGrid to true, and let it 
		* calculate whether there are any records or not using the reccount attribute
		###
		if @get('content.isLoaded')
			@getTableDom()[0].p.viewrecords = true
		data = 
			rows: @get('gridData')
			total: @get('pagingInfo.totalPages') if @get('pagingInfo')? 
			records: @get('pagingInfo.totalRows') if @get('pagingInfo')?
			page: @get('pagingInfo').page if @get('pagingInfo')? 
			remoteGrouping: @isShowingValidGroups()
		@resetGrouping()
		if @isShowingValidGroups()
			data.columnName = @get('groupingInfo.columnName')
			data.columnType = @get('groupingInfo.columnType')
			data.groupType = @get('groupingInfo.type')
			data.columnTitle = @getColumnTitle(data.columnName)
			grid = @getTableDom()[0]
			@updatePagingForGroups(grid, data)
			grid?.addGroupingData(data)
		else
			@getTableDom()[0]?.addJSONData(data)
			@updateGrid()
	).observes('content', 'content.isLoaded', 'content.@each', 'pagingInfo')

	isShowingValidGroups: ->
		@get('showingGroups') and @get('groupingInfo.columnName')?

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

	selectionDidChange: (->
		#@updateGrid(true)
	).observes('selection.@each')

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
			@highlightRows()
			@showEditableCells()
		@validate() if doValidation
		$.publish("/grid/rendered")

	highlightRows: ()->
		table = @getTableDom()
		if table?
			grid = table.get(0)
			###for id in table.jqGrid('getDataIDs')
				if @get('multiSelect')
					if (@isRowSelectedMultiSelect(id, grid))
						table.jqGrid('setSelection', id, false)
				else
					if (@isRowSelectedSingleSelect(id, grid))
						table.jqGrid('setSelection', id, false)
				#@$('#'+id).removeClass("ui-state-highlight").attr({"aria-selected":"false", "tabindex" : "-1"})
			###
			for item in @get('selectedIds')
				@highlightRow(item)
			@setSelectAllCheckbox(grid)

	isRowSelectedMultiSelect: (id, grid)->
		# Is the row registered as selected within jqGrid
		grid.p.selarrrow.contains(id)

	isRowSelectedSingleSelect: (id, grid)->
		# Is the row registered as selected within jqGrid
		grid.p.selrow == id
	
	highlightRow: (id)->
		table = @getTableDom()
		if table?
			if @get('multiSelect')
				if not @isRowSelectedMultiSelect(id, table.get(0))
					table.jqGrid('setSelection', id, false)
			else
				if not @isRowSelectedSingleSelect(id, table.get(0))
					table.jqGrid('setSelection', id, false)
			#@$('#'+id).addClass("ui-state-highlight").attr({"aria-selected":"true", "tabindex" : "0"});

	unHighlightAllRows: (->
		if (@get("clearAction") &&  @getTableDom()?)
			@set('selection',[])
			@set "clearAction", false
			@gridDataDidChange()
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

