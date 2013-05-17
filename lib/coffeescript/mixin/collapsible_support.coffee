
Tent.CollapsibleSupport = Ember.Mixin.create
	classNameBindings: ['collapsible']
	###*
	* @property {Boolean} collapsible A boolean which determines whether the header is collapsible.
	* If set to true, then a {@link #title} should be provided so that there is a meaningful header 
	* area when collapsed.
	###
	collapsible: false
	###*
	 * @property {Boolean} collapsed Defines whether the collapsible is collapsed initially.
	###
	collapsed: false
	###*
	 * @property {Boolean} useTransition This property determines whether a CSS transition is used for sliding.
	###
	useTransition: true
	###*
	 * @property {Boolean} horizontalSlide This property determines whether a javascript transition is used for horizontal sliding.
	###
	horizontalSlide: false
	slideDirection: "left"

	onTransitionStep: ->
		$.publish("/ui/horizontalSlide", {source: @$()})
		#$.publish("/ui/refresh", ['resize'])

	onExpandEnd: ->
		@set('collapsed', false)
		@$('').removeClass('collapsed')
		$.publish("/ui/refresh", ['resize'])
	
	onCollapseEnd: ->
		@set('collapsed', true)
		@$('').addClass('collapsed')
		$.publish("/ui/refresh", ['resize'])
		
	didInsertElement: ->
		@_super()
		if @get('collapsible') 
			if @isUsingCSSTransition()
				widget = @
				@$('').bind('webkitTransitionEnd oTransitionEnd transitionend msTransitionEnd', ->
					widget.set('collapsed', widget.$('').hasClass('collapsed'))
					$.publish("/ui/refresh", ['resize'])
				)

	click: (e)->
		target = @getClickArea(e)
		@toggle() if target.length and @get('collapsible')

	toggle: ->
		if @get('horizontalSlide')
			collapsible = @
			if @get('collapsed')
				@expand()
			else
				@collapse()
		else
			@$('').toggleClass('collapsed')
			@triggerListenersImmediately() if not @isUsingCSSTransition()
	
	expand: ->
		if @get('horizontalSlide')
			collapsible = @
			dir = {}
			@$('.drag-bar').css({'visibility':'hidden'})
			dir["" + collapsible.get("slideDirection")] = "0px"

			@$().animate(dir, {
				duration: 400
				step: ->
					collapsible.onTransitionStep()
				complete: ->
					collapsible.onExpandEnd()
			})
		else
			@$('').removeClass('collapsed')
			@triggerListenersImmediately() if not @isUsingCSSTransition()

	collapse: ->
		if @get('horizontalSlide')
			collapsible = @
			collapsible.set('width', collapsible.$().width())
			@$('.drag-bar').css({'visibility':'hidden'})
			dir = {}
			dir["" + collapsible.get("slideDirection")] = "-#{collapsible.get('width')}px"

			@$().animate(dir, {
				duration: 400
				step: ->
					collapsible.onTransitionStep()
				complete: ->
					collapsible.onCollapseEnd()
			})
		else
			@$('').addClass('collapsed')
			@triggerListenersImmediately() if not @isUsingCSSTransition()
		
	triggerListenersImmediately: ->
		@set('collapsed', @$('').hasClass('collapsed'))
		$.publish("/ui/refresh", ['resize'])

	isUsingCSSTransition: ->
		@get('useTransition') and Modernizr.csstransitions

	getClickArea: (e)->
		if $(e.target).hasClass('clickarea')
			return $(e.target)
		else
			return $(e.target).parentsUntil(@$(), '.clickarea').eq(0)
