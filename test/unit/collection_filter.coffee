
setup = ->
	@collection = Ember.ArrayController.create
		paged: true		 
		goToPage: ->
		sort: ->
		getURL: ->
		columnsDescriptor: [
			{id: "id", name: "id", title: "_hID", field: "id", sortable: true},
			{id: "title", name: "title", title: "_hTitle", field: "title", sortable: true}
		]
		filteringInfo: 
			selectedFilter: 'task1'
			availableFilters: [
				{
					name: "task1"
					label: "Task 1"
					description: "Select the first task"
					values: {
						id: {field:"id", op: "equal", data: "5"}, 
						title: {field:"title",op: "equal", data: "Task 1"}
					}					
				},
				{
					name: "task2"
					label: "Task 2"
					description: "Select all tasks 50-59"
					values: {
						id: {field:"id",op: "equal", data: "6"}
					}
				}
			]

teardown = ->
	@collection = null


module 'Tent.CollectionFilter', setup, teardown

test 'Create filter', ->
	filter = Tent.CollectionFilter.create()
	equal filter.get('currentFilter').name, "", 'name'
	equal filter.get('currentFilter').label, "", 'label'
	equal filter.get('currentFilter').description, "", 'description'
	ok filter.get('currentFilter').values, 'values'

	filter.set('collection', collection)
	filter.init()
	equal filter.get('currentFilter').name, "task1", 'name'
	equal filter.get('currentFilter').label, "Task 1", 'label'
	equal filter.get('currentFilter').description, "Select the first task", 'description'
	equal filter.get('currentFilter').values.id.field, "id", 'id'
	equal filter.get('currentFilter').values.id.data, "5", 'data for id'
	equal filter.get('currentFilter').values.title.field, "title", 'title'
	equal filter.get('currentFilter').values.title.data, "Task 1", 'data for title'


test 'Clear filter', ->
	filter = Tent.CollectionFilter.create
		collection: collection
	
	equal filter.get('currentFilter').name, "task1", 'name'
	
	filter.clearFilter()
	equal filter.get('currentFilter').name, "", 'name'
	equal filter.get('currentFilter').label, "", 'label'
	equal filter.get('currentFilter').description, "", 'description'
	for value in filter.get('currentFilter').values
		throw new Error('Should be no values')

	



