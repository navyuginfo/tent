
Tent.HideableSupport = Ember.Mixin.create
	classNameBindings: ['hideable']
	###*
	* @property {Boolean} hideable A boolean which determines whether the header is hideable.
	###
	hideable: false

	###*
	* @property {Boolean} hidden A boolean which determines whether the header is initially hidden
	###
	hidden: false

	didInsertElement: ->
		@_super()
		if @get('hideable')
			if @get('hidden')
				@hide(true)

	###*
	* @method hide
	* @param {Boolean} force execute the function even if the component is already hidden
	###
	hide: (force=false) ->
		if @get('hideable') and (force or not @get('hidden'))
			@$('').addClass('hidden')
			@set('hidden', true)
			$.publish("/ui/refresh", ['resize'])

	###*
	* @method show
	* @param {Boolean} force execute the function even if the component is already shown
	###
	show: (force=false)->
		if @get('hideable') and (force or @get('hidden'))
			@$('').removeClass('hidden')
			@set('hidden', true) # Do this to trigger a change event in case it is already showing
			@set('hidden', false)
			$.publish("/ui/refresh", ['resize'])