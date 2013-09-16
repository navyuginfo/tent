###*
* @class Tent.Data.Filter
* Adds filtering support
###

Tent.Data.Filter = Ember.Mixin.create
	filteringInfo:
		selectedFilter: 'default'
		availableFilters: [
			{
				name: "default"
				label: Tent.I18n.loc 'tent.filter.noFilter'
				description: ""
				values: {
					
				}
			}
		]

	init: ->
		@_super()
		@REQUEST_TYPE.FILTER = 'filtering'

		###@set('filteringInfo', 
			selectedFilter: 'task2'
			availableFilters: [
				{
					name: "task1"
					label: "Task 1"
					description: "Select the first task"
					values: {
						id: {field:"id", op: "equal", data: "5"}
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
					values: {
						id: {field:"id",op: "equal", data: "5"}
						title: {field:"title",op: "equal", data: "Task 2"}
					}
				},
				{
					name: "task3"
					label: "Task 3"
					description: "Select all tasks 50-59"
					values: {
						id: {field:"id",op: "equal", data: "5"}
					}
				}
			])
		###

	selectedFilter: ( ->
		@getSelectedFilter()
	).property('filteringInfo', 'filteringInfo.selectedFilter')
	
	getSelectedFilter: ->
		if @get('filteringInfo')? and @get('filteringInfo.selectedFilter')? 
			for filter in @get('filteringInfo.availableFilters')
				if filter.name == @get('filteringInfo.selectedFilter')
					return filter

	getSelectedFilterName: ->
		f = @getSelectedFilter()
		name: f.name
		label: f.label

	setSelectedFilter: (name) ->
		@set('filteringInfo.selectedFilter', name)

	filterNames: (->
		@get('filteringInfo.availableFilters').map((item)->
			name: item.name
			label: item.label
		)
	).property('filteringInfo.availableFilters', 'filteringInfo.availableFilters.@each')

	updateCurrentFilter: (currentFilter)->
		replacedExisting = false
		if @get('filteringInfo')?
			filters = @get('filteringInfo.availableFilters').map((item)->
				if item.name == currentFilter.name 
					if item.label == currentFilter.label
						replacedExisting = true
						Ember.copy(currentFilter,true)
					else
						currentFilter.name = currentFilter.label.split(" ").join('')
						item
				else 
					item
			)

			@get('filteringInfo.availableFilters').clear()
			@get('filteringInfo.availableFilters').pushObjects(filters)


			#@set('filteringInfo.availableFilters', filters)

			if not replacedExisting
				@addNewFilter(currentFilter)

	doFilter: (selectedFilter) ->  # Careful not to overload Array.filter()
		if selectedFilter?
			@setSelectedFilter(selectedFilter.name)
			@updateCurrentFilter(selectedFilter)
		@update(@REQUEST_TYPE.FILTER)

	# Called by UI button to trigger filtering
	filterTrigger: ->
		@doFilter()

	getFilteringInfo: ->
		@getSelectedFilter()

	saveFilter: (filterDef) -> 
		# TODO : check that filter is not duplicated
		# TODO : store filter in datastore
		@updateCurrentFilter(filterDef)
		@saveUIState()
		#@get('availableFilters').notifyPropertyChange('content')

	addNewFilter: (filter)->
		filter.name = filter.name or filter.label.split(" ").join('')
		@set('filteringInfo.selectedFilter', filter.name)
		@get('filteringInfo.availableFilters').push(Ember.copy(filter,true))

	restoreFilters: ->
    uiState = @get('defaultPersonalization')
    if uiState.filtering?
      filteringInfo = @get('filteringInfo')
      filter = filteringInfo.availableFilters.findProperty('name', filteringInfo.selectedFilter)
      for column in @get('columnsDescriptor')
        columnFilter = filter.values[column.name]
        Em.set(columnFilter, 'data',"")
        Em.set(columnFilter, 'op',"")
        columnFilter