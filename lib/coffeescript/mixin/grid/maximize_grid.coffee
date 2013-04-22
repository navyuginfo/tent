###*
* @class Tent.Grid.Maximize
* Adds maximize/restore support to a grid
###

Tent.Grid.Maximize = Ember.Mixin.create
	###*
	* @property {Boolean} showMaximizeButton Display a button at the top of the grid which presents
	* a dialog to maximize the grid view.
	###
	showMaximizeButton: true

	resizeGridSteps: true
	resizeSpeed: 700

	addNavigationBar: ->
		@renderMaximizeButton()

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
		@$().css('z-index', '2050')
		@$().css('position', 'fixed')
		@$().addClass('dialog')
		if not @get('resizeGridSteps')
			@hideGrid()

		@$('.jqgrid-backdrop').show()
		$('.jqgrid-backdrop').animate(
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
					@$().css('height', '')
					@$().css('width', '')
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
		@$('.jqgrid-backdrop').animate(
			{
				opacity: '0.0'
			},
			900,
			=>
				@$('.jqgrid-backdrop').hide()
				@$().css('position', 'static')
		)

	generateResizeEscapeHandler: (widget)->
		return (e)->
			if e.keyCode==27 or ($(e.target).attr('id') == 'jqgrid-backdrop')
				widget.toggleFullScreen()
				return

