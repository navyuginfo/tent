Tent.Grid.FilterSupport = Ember.Mixin.create
	showFilter: false

	###*
	* @property {Boolean} maximizeGridOnFilter maximize the grid when the filter panel is displayed
	###
	maximizeGridOnFilter: false

	toggleFilter: ->
		@set('showFilter', !@get('showFilter'))

		if @get('maximizeGridOnFilter')
			if @get('showFilter')
				@maximize()
			else 
				@restoreSize()

