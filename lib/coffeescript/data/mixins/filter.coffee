Tent.Data.Filter = Ember.Mixin.create
	init: ->
		@_super()
		@REQUEST_TYPE.FILTER = 'filtering'
		@set('filters', 
			[
				{
					name: "task1"
					label: "Task 1"
					description: "Select the first task"
					values: {id: {field:"id", op: "equal", data: "51"}, title: {field:"title",op: "equal", data: "Task 1"}}
				},
				{
					name: "task2"
					label: "Task 2"
					description: "Select all tasks 50-59"
					values: {id: {field:"id",op: "equal", data: "5"}}
				}
			])

	availableFilters: (->
		return @get('filters')
	).property('filters', 'filters.@each')

	filter: (selectedFilter) ->
		#if selectedFilter?
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
		@get('filters').pushObject(filterDef)
		#@get('availableFilters').notifyPropertyChange('content')


	 