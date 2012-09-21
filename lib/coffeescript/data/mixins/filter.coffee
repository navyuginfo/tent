Tent.Data.Filter = Ember.Mixin.create
	init: ->
		@_super()
		@REQUEST_TYPE.FILTER = 'filtering'
		@set('availableFilters', Ember.ArrayProxy.create
			content: [
				{
					name: "task1"
					label: "Task 1"
					description: "Select the first task"
					values: {id: "51", title: "Task 1"}
				},
				{
					name: "task2"
					label: "Task 2"
					description: "Select all tasks 50-59"
					values: {id: "5"}
				}
			])

	filter: (selectedFilter) ->
		if selectedFilter?
			@set('selectedFilter', selectedFilter)
		@update(@REQUEST_TYPE.FILTER)

	# Called by UI button to trigger filtering
	filterTrigger: ->
		@filter()

	getFilteringInfo: ->
		@get('selectedFilter')

	saveFilter: (filterDef) -> 
		# TODO : check that filter is not duplicated
		# TODO : store filter in datastore
		@get('availableFilters').get('content').push(filterDef)
		#@get('availableFilters').notifyPropertyChange('content')


	 