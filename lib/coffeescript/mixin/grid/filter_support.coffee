Tent.Grid.FilterSupport = Ember.Mixin.create
	showFilter: false
	filterCoversGrid: false

	###*
	* @property {Boolean} maximizeGridOnFilter maximize the grid when the filter panel is displayed
	###
	maximizeGridOnFilter: false

	toggleFilter: ->
		@set('showFilter', !@get('showFilter'))
		@resizeToContainer()

		if @get('maximizeGridOnFilter')
			if @get('showFilter')
				@maximize()
			else 
				@restoreSize()

