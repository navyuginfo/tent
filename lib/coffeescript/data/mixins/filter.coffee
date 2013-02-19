###*
* @class Tent.Data.Filter
* Adds filtering support
###

Tent.Data.Filter = Ember.Mixin.create
	filteringInfo: {}

	init: ->
		@_super()
		@REQUEST_TYPE.FILTER = 'filtering'

		@set('filteringInfo', 
			selectedFilter: 'task1'
			availableFilters: [
				{
					name: "task1"
					label: "Task 1"
					description: "Select the first task"
					values: {
						id: {field:"id", op: "equal", data: "5"}, 
						title: {field:"title",op: "equal", data: "Task 1"}
						duration: {field:"duration",op: "equal", data: "5"}
						#percentcomplete: {field:"percentcomplete",op: "equal", data: "41"}
						effortdriven: {field:"effortdriven",op: "equal", data: "-1"}
						start: {field:"start",op: "equal", data: ""}
						finish: {field:"finish",op: "equal", data: ""}
						completed: {field:"completed",op: "equal", data: true}
					}
				},
				{
					name: "task2"
					label: "Task 2"
					description: "Select all tasks 50-59"
					values: {id: {field:"id",op: "equal", data: "5"}}
				}
			])

	selectedFilter: ( ->
		@getSelectedFilter()
	).property('filteringInfo', 'filteringInfo.selectedFilter')
	
	getSelectedFilter: ->
		if @get('filteringInfo')? and @get('filteringInfo.selectedFilter')?
			for filter in @get('filteringInfo.availableFilters')
				if filter.name == @get('filteringInfo.selectedFilter')
					return filter

	setSelectedFilter: (name) ->
		@set('filteringInfo.selectedFilter', name)

	updateCurrentFilter: (currentFilter)->
		replacedExisting = false
		if @get('filteringInfo')?
			filters = @get('filteringInfo.availableFilters').map((item)->
				if item.name == currentFilter.name 
					if item.label == currentFilter.label
						replacedExisting = true
						currentFilter
					else
						currentFilter.name = currentFilter.label.split(" ").join('')
						item
				else 
					item
			)
			@set('filteringInfo.availableFilters', filters)

			if not replacedExisting
				@addNewFilter(currentFilter)

	filter: (selectedFilter) -> 
		#if selectedFilter?
		@setSelectedFilter(selectedFilter.name)
		@updateCurrentFilter(selectedFilter)
		@update(@REQUEST_TYPE.FILTER)

	# Called by UI button to trigger filtering
	filterTrigger: ->
		@filter()

	getFilteringInfo: ->
		@getSelectedFilter()

	saveFilter: (filterDef) -> 
		# TODO : check that filter is not duplicated
		# TODO : store filter in datastore
		@updateCurrentFilter(filterDef)
		#@get('availableFilters').notifyPropertyChange('content')

	addNewFilter: (filter)->
		@get('filteringInfo.availableFilters').push(filter)

	 