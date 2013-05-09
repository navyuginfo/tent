
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
	 * @property {Boolean} useTransition This property determines whether a slide effect is used.
	###
	useTransition: false

	didInsertElement: ->
		@_super()
		if @get('collapsible') and @isUsingCSSTransition()
			widget = @
			@$('').bind('webkitTransitionEnd oTransitionEnd transitionend msTransitionEnd', ->
				widget.set('collapsed', widget.$('').hasClass('collapsed'))
				$.publish("/ui/refresh", ['resize'])
			)

	click: (e)->
		target = @getClickArea(e)
		if target.length and @get('collapsible')
			@$('').toggleClass('collapsed')
			if not @isUsingCSSTransition()
				@set('collapsed', @$('').hasClass('collapsed'))
				$.publish("/ui/refresh", ['resize'])

	isUsingCSSTransition: ->
		@get('useTransition') and Modernizr.csstransitions

	getClickArea: (e)->
		if $(e.target).hasClass('clickarea')
			return $(e.target)
		else
			return $(e.target).parentsUntil(@$(), '.clickarea').eq(0)