Tent.Grid.FilterSupport = Ember.Mixin.create
	showFilter: false
	isPinned: false

	###*
	* @property {Boolean} maximizeGridOnFilter maximize the grid when the filter panel is displayed
	###
	maximizeGridOnFilter: false

	toggleFilter: ->
		@toggleProperty('showFilter')
		@resizeToContainer()

		if @get('maximizeGridOnFilter')
			if @get('showFilter')
				@maximize()
			else 
				@restoreSize()

