###*
* @class Tent.Data.Filter
* Adds filtering support
###

Tent.Data.Filter = Ember.Mixin.create
	init: ->
		@_super()
		@REQUEST_TYPE.FILTER = 'filtering'

		###@set('filters', 
			[
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
		###
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
		@set('filters', []) if not @get('filters')
		@get('filters').pushObject(filterDef)
		#@get('availableFilters').notifyPropertyChange('content')


	 