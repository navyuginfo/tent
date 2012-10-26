
Tent.CollapsibleSupport = Ember.Mixin.create
	classNameBindings: ['collapsible']
	###*
	* @property {Boolean} collapsible A boolean which determines whether the header is collapsible.
	* If set to true, then a {@link #title} should be provided so that there is a meaningful header 
	* area when collapsed.
	###
	collapsible: false

	collapsed: false

	didInsertElement: ->
		if @get('collapsible') and Modernizr.csstransitions
			widget = @
			@$('').bind('webkitTransitionEnd oTransitionEnd transitionend msTransitionEnd', ->
				widget.set('collapsed', widget.$('').hasClass('collapsed'))
				$.publish("/ui/refresh", ['resize'])
			)

	click: (e)->
		if $(e.target).hasClass('clickarea')
			if @get('collapsible')
				@$('').toggleClass('collapsed')
				if not Modernizr.csstransitions
					@set('collapsed', @$('').hasClass('collapsed'))
					$.publish("/ui/refresh", ['resize'])