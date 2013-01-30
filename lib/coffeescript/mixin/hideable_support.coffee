
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
				@hide()

	hide: ->
		if @get('hideable')
			@$('').addClass('hidden')
			@set('hidden', true)
			$.publish("/ui/refresh", ['resize'])

	show: ->
		if @get('hideable')
			@$('').removeClass('hidden')
			@set('hidden', false)
			$.publish("/ui/refresh", ['resize'])