Tent.Grid.HorizontalScrollSupport = Ember.Mixin.create
	###*
	* @property {Boolean} horizontalScrolling Allow the grid content to scroll horizontally.
	* This property defines whether the grid content will be forced to fit within the area assiged to the grid (false), 
	* or whether the columns will disregard the grid width. The actual column widths will depend on the value provided for {@link #fixedColumnWidth}
	###
	horizontalScrolling: false

	###*
	* @property {Number} fixedColumnWidth Specify a single width to give to all columns	
	* If {@link #horizontalScrolling} is set to true, then if this property is specified, 
	* all of the columns will be given the specified width. If {@link #horizontalScrolling} is set to false, 
	* this property is ignored, and the column widths will be estimated from the column title widths.
	###
	fixedColumnWidth: null

	addNavigationBar: ->
		@_super()
		@renderHorizontalScrollButton()

	renderHorizontalScrollButton: ->
		widget = @
		@$(".header-buttons").append('<a class="horizontal-scroll-button jqgrid-title-button"><i class="icon-resize-horizontal"></i> </a>')
		@$('.horizontal-scroll-button').attr('title', Tent.I18n.loc("tent.jqGrid.horizontalScroll"))
		@$('.horizontal-scroll-button').click(() ->
			widget.set('horizontalScrolling', !widget.get('horizontalScrolling'))
			if widget.get('horizontalScrolling')
				$(this).addClass('active')
			else 
				$(this).removeClass('active')
		)

	horizontalScrollingDidChange: (->
		if @get('horizontalScrolling')
			@getTableDom().get(0).p.forceFit = false
			@getTableDom().get(0).p.shrinkToFit = false
		else 
			@getTableDom().get(0).p.forceFit = true
			@getTableDom().get(0).p.shrinkToFit = true

		@gridDataDidChange()
		@updateGrid()
		@adjustHeight()
	).observes('horizontalScrolling')

	# When horizontalScrolling is applied, we want the cell content to determine the width of
	# the column. The cells should not wrap in this case 
	setHeaderWidths: ->
		# No column width personalization supported here
		if @get('horizontalScrolling')
			firstRowOfGrid = @$('.jqgfirstrow td')
			jqGridCols = @getTableDom()[0].p.colModel

			# Set the width of each column to the greater of header width or cell width.
			@$('.ui-jqgrid-htable th').each((index, col)=>
				finalWidth = @calculateColumnWidth(index, col, firstRowOfGrid)
				@changeColumnWidth(index, col, finalWidth, firstRowOfGrid, jqGridCols)
			)
			@ensureColumnsExpandToAvailableSpace(firstRowOfGrid, jqGridCols)
			

	calculateColumnWidth: (index, col, firstRowOfGrid) ->
		widthBasedOnHeader = @calculateHeaderColumnWidth(index, col)
		widthBasedOnContent = @calculateWidthBasedOnContent(index, firstRowOfGrid)

		if widthBasedOnContent > widthBasedOnHeader
			widthBasedOnContent
		else 
			widthBasedOnHeader

	changeColumnWidth: (index, col, finalWidth, firstRowOfGrid, jqGridCols)->
		firstRowOfGrid.eq(index).css('width', finalWidth).css('min-width', finalWidth)
		$(col).css('width', finalWidth)
		jqGridCols[index].width = finalWidth

	calculateHeaderColumnWidth: (index, col)->
		if (@get('multiSelect') and index==0)
			$(col).width()
		else
			column = @get('columnModel')[index - (if @get('multiSelect') then 1 else 0)]
			if column?
				column.title.length * 10
			else
				80

	calculateWidthBasedOnContent: (index, firstRowOfGrid)->
		if @get('groupingInfo.columnName')?
			widthBasedOnContent = firstRowOfGrid.eq(index).width()
		else 
			widthBasedOnContent = firstRowOfGrid.eq(index).outerWidth()

	ensureColumnsExpandToAvailableSpace: (firstRowOfGrid, jqGridCols)->
		# Expand to fit the grid area if necessary
		totalGridWidth = @$('.ui-jqgrid').width()
		totalColumnsWidth = @$('.ui-jqgrid-bdiv').width()
		if (totalColumnsWidth > 0) and (totalGridWidth > totalColumnsWidth)
			if @get('horizontalScrolling')
				# The easiest way to normalize the columns is is to revert to shrinkToFit.
				Ember.run.later =>
					@set('horizontalScrolling', false)
					Ember.run.later =>
						@set('horizontalScrolling', true)

			###
			remaining = totalGridWidth - totalColumnsWidth
			lastVisibleIndex = jqGridCols.length - 1
			visibleColumns = firstRowOfGrid.filter((index, col)->
				if $(this).css('display') != 'none'
					lastVisibleIndex = index
					true
				else
					false 
			)
			lastColumn = visibleColumns.last()
			finalWidth = lastColumn.width() + remaining

			lastColumn.css('width', finalWidth).css('min-width', finalWidth)
			@$('.ui-jqgrid-htable th').eq(lastVisibleIndex).css('width', finalWidth).css('min-width', finalWidth)
			jqGridCols[lastVisibleIndex].width = finalWidth
			###

