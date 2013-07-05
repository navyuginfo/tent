Tent.Grid.HorizontalScrollSupport = Ember.Mixin.create
	###*
	* @property {Boolean} horizontalScrolling Allow the grid content to scroll horizontally.
	* This property defines whether the grid content will be forced to fit within the area assiged to the grid (false), 
	* or whether the columns will disregard the grid width. The actual column widths will be the greater of the column 
	* title width and the column content
	###
	horizontalScrolling: false

	###*
	 * @property {Boolean} ShowAutofitButton Show or hide the autofit button on the grid header panel.
	 *
	 * The autofit button will allow the grid to toggle between two modes
	 * 
	 * - **Autofit**: All columns are resized to fit within the grid viewing area
	 * - **Non-Autofit**: All columns assume their natural width (using no wrapping) and a horizontal scrollbar is
	 * displayed if necessary
	###
	showAutofitButton: true

	###*
	 * @property {Boolean} autofitIfSpaceAvailable If autofit is turned off, and there is free space in the grid, expand the
	 * columns to fit the free space.
	###
	autofitIfSpaceAvailable: false

	isHorizontalScrolling: false

	gridDidRender: ->
		@set('isHorizontalScrolling', false)
		@modifyGridForAutofit()

	toggleActive: (component)->
		component = component or @$('.horizontal-scroll-button')
		if @get('horizontalScrolling')
			component.removeClass('active')
		else 
			component.addClass('active')

	horizontalScrollingDidChange: (()->
		@modifyGridForAutofit()
	).observes('horizontalScrolling')

	modifyGridForAutofit: ()->
		if @get('horizontalScrolling') 
			if not @get('isHorizontalScrolling') # optimization. Don't update if not necessary
				@addHorizontalScroll()
		else
			if @get('isHorizontalScrolling')
				@removeHorizontalScroll()

	addHorizontalScroll: ->
		@set('isHorizontalScrolling', true)
		@getTableDom().get(0).p.forceFit = false
		@getTableDom().get(0).p.shrinkToFit = false

		@moveHeaderAboveViewDiv()
		@updateGrid()
		@adjustHeight()

	removeHorizontalScroll: ->
		@set('isHorizontalScrolling', false)
		@getTableDom().get(0).p.forceFit = true
		@getTableDom().get(0).p.shrinkToFit = true

		@revertHeaderIntoViewDiv()
		@updateGrid()
		@adjustHeight()

	moveHeaderAboveViewDiv: ->
		hdiv = $('.ui-jqgrid-hdiv', @$())
		bdiv = $('.ui-jqgrid-bdiv', @$())
		view = $('.ui-jqgrid-view', @$())
		sdiv = $('.ui-jqgrid-sdiv', @$())
		hdiv.detach()
		view.before(hdiv)
		if sdiv.length > 0
			sdiv.detach()
			view.after(sdiv)

		if @get('footerRow')
			sdiv.scroll((event)=>
				@trackFooterScrollPosition(hdiv, bdiv, sdiv)
			)
			@trackFooterScrollPosition(hdiv, bdiv, sdiv)
		else
			view.scroll((event)=>
				@trackContentScrollPosition(hdiv, view)
			)
			@trackContentScrollPosition(hdiv, view)

	trackFooterScrollPosition: (hdiv, bdiv, sdiv)->
		hdiv.css("margin-left", "-" + sdiv.scrollLeft() + 'px')
		bdiv.css("margin-left", "-" + sdiv.scrollLeft() + 'px')

	trackContentScrollPosition: (hdiv, view)->
		hdiv.css("margin-left", "-" + view.scrollLeft() + 'px')


	revertHeaderIntoViewDiv: ->
		hdiv = $('.ui-jqgrid-hdiv', @$())
		view = $('.ui-jqgrid-view', @$())
		bdiv = $('.ui-jqgrid-bdiv', @$())
		sdiv = $('.ui-jqgrid-sdiv', @$())
		hdiv.detach()
		bdiv.before(hdiv)
		hdiv.css("margin-left", "0px")
		bdiv.css("margin-left", "0px")
		view.unbind('scroll')
		sdiv.unbind('scroll')
		if sdiv.length > 0
			sdiv.detach()
			bdiv.after(sdiv)


	# When horizontalScrolling is applied, we want the cell content to determine the width of
	# the column. The cells should not wrap in this case 
	setHeaderWidths: ->
		# No column width personalization supported here
		if @get('horizontalScrolling')
			firstRowOfGrid = @$('.jqgfirstrow td')
			jqGridCols = @getTableDom()[0].p.colModel
			totalWidth = 0
			# Set the width of each column to the greater of header width or cell width.
			@$('.ui-jqgrid-htable th').each((index, col)=>
				finalWidth = @calculateColumnWidth(index, col, firstRowOfGrid)
				if not jqGridCols[index].hidden
					totalWidth = totalWidth + parseInt(finalWidth)
					@changeColumnWidth(index, col, finalWidth, firstRowOfGrid, jqGridCols)
					@changeFooterWidth(index, finalWidth)
			)
			if @get('footerRow')
          		@getTableDom()[0].grid.sDiv.style.width = "auto"

			if @get('autofitIfSpaceAvailable')
				@ensureColumnsExpandToAvailableSpace(firstRowOfGrid, jqGridCols)
			else
				@resizeTableToColumnsWidth(totalWidth)

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
			col.style.width.split('px')[0]
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
			if doesColumnHaveMinWidth(index, firstRowOfGrid)
				widthBasedOnContent = firstRowOfGrid.eq(index).css('min-width').split('px')[0]
			else
				widthBasedOnContent = firstRowOfGrid.eq(index).outerWidth()
			widthBasedOnContent

	doesColumnHaveMinWidth: (index, firstRowOfGrid) ->
		minWidth = firstRowOfGrid.eq(index).css('min-width')
		minWidth != '0px' && !isNaN(minWidth) 

	changeFooterWidth: (index, finalWidth)->
		if @get('footerRow')
			# review for performance
			footers = @getTableDom()[0].grid.footers;
			footers[index].style.width = finalWidth + 'px';

	resizeTableToColumnsWidth: (totalWidth) ->
		@$('.ui-jqgrid-htable').width(totalWidth)
		@$('.ui-jqgrid-btable').width(totalWidth)
		@$('.ui-jqgrid-ftable').width(totalWidth)

	ensureColumnsExpandToAvailableSpace: (firstRowOfGrid, jqGridCols)->
		# Expand to fit the grid area if necessary
		totalGridWidth = @$('.ui-jqgrid').width()
		totalColumnsWidth = @$('.ui-jqgrid-btable').width()
		if (totalColumnsWidth > 0) and (totalGridWidth > totalColumnsWidth)
			if @get('horizontalScrolling') and not @get('temporaryAutoFit') 
				# The easiest way to normalize the columns is is to revert to shrinkToFit.
				Ember.run.next this, =>
					@set('temporaryAutoFit', true) 
					@set('horizontalScrolling', false)
				Ember.run.next this, =>
					@set('horizontalScrolling', true)
					@set('temporaryAutoFit', false)

