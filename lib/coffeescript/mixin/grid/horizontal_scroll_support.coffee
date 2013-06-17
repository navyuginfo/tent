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
			widget.gridDataDidChange()
			widget.updateGrid()
			widget.adjustHeight()
		)