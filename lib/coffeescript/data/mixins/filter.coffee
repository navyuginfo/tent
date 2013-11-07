###*
* @class Tent.Data.Filter
* Adds filtering support
###

Tent.Data.Filter = Ember.Mixin.create
	defaultFiltering:
		selectedFilter: 'default'
		availableFilters: [
			{
				name: "default"
				label: Tent.I18n.loc 'tent.filter.noFilter'
				description: ""
				values: []
			}
		]
	
	init: ->
		@applyDefaultFilter()
		@_super()
		@REQUEST_TYPE = @REQUEST_TYPE || {}
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

	ensureFilterAvailable: ->
		if not @get('selectedFilter')?
			@set('filteringInfo',
				selectedFilter: 'default'
				availableFilters: [
					{
						name: "default"
						label: Tent.I18n.loc 'tent.filter.noFilter'
						description: ""
						values: []
					}
				]
			)

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
		@get('filteringInfo.availableFilters').map((item) ->
			name: item.name
			label: item.label
		)
	).property('filteringInfo.availableFilters', 'filteringInfo.availableFilters.@each')

	updateCurrentFilter: (currentFilter) ->
		replacedExisting = false
		if @get('filteringInfo')?
			filters = @get('filteringInfo.availableFilters').map((item) ->
				if item.name == currentFilter.name 
					if item.label == currentFilter.label
						replacedExisting = true
						Ember.Object.create($.extend(true, {}, currentFilter))
					else
						currentFilter.name = currentFilter.label.split(" ").join('')
						item
				else 
					item
			)

			@get('filteringInfo.availableFilters').clear()
			@get('filteringInfo.availableFilters').pushObjects(filters)

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

	# Add a new field to the value array of the currently selected filter, 
	# ready to be populated with a filter field value for the specified column.
	createBlankFilterFieldValue: (columnName) ->
		@ensureFilterAvailable()
		@get('selectedFilter.values').pushObject({field:columnName, op:"", data:""})

	removeFilterFieldValue: (value) ->
		@ensureFilterAvailable()
		if @get('selectedFilter.values').contains(value)
      @get('selectedFilter.values').removeObject(value)
		
	# Return the filter value for the specified column from the currently selected filter.
	getFilterValueForColumn: (columnName) ->
		@get('selectedFilter.values').filter((value) ->
			value.field == columnName
		)

	# Return only columns that are filterable
	filterableColumns: (->
		@get('columnsDescriptor').filter((column) ->
			column.filterable != false
		)
	).property('columnsDescriptor')

	saveFilter: (filterDef) -> 
		# TODO : check that filter is not duplicated
		# TODO : store filter in datastore
		@updateCurrentFilter(filterDef)
		@saveUIState()
		#@get('availableFilters').notifyPropertyChange('content')

	addNewFilter: (filter) ->
		filter.name = filter.name or filter.label.split(" ").join('')
		@set('filteringInfo.selectedFilter', filter.name)
		@get('filteringInfo.availableFilters').push(Ember.copy(filter,true))

	applyDefaultFilter: ->
		@set('filteringInfo', $.extend({}, @get('defaultFiltering')))
