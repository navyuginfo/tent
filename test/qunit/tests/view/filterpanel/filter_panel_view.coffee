view = null
filteringCollection = null

appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))
      
setup = -> 
	C = Ember.Object.extend Tent.Data.Filter,
		filteringInfo: 
			selectedFilter: 'task1'
			availableFilters: [
				{
					name: "task1"
					label: "Task 1"
					description: "Select the first task"
					values: [
						{field:"id", op: "equal", data: "5"}
						{field:"title",op: "equal", data: "Task 1"}
						{field:"duration",op: "equal", data: "5"}
						{field:"effortdriven",op: "equal", data: "-1"}
						{field:"start",op: "equal", data: ""}
						{field:"finish",op: "equal", data: ""}
						{field:"completed",op: "equal", data: true}
					]
				}
			]

		selectedFilter: (->
			@get('filteringInfo.availableFilters')[0]
		).property('filteringInfo.availableFilters')

		doFilter: ->

		columnsDescriptor: 
			[
				{id: "id", name: "id", type:"number", title: "_hID", field: "id", width:5, sortable: true, hidden: true, formatter: "action", formatoptions: {action: "showInvoiceDetails"}, hideable: true, groupable: false, filterable:true},
				{id: "title", name: "title", type:"string", title: "_hTitle", field: "title", width:5, sortable: true, hideable: false}
			]

	filteringCollection = C.create()

teardown = ->  
   filteringCollection = null
    
module 'Tent.FilterPanelView', setup, teardown

test 'Ensure collection is created', ->
	view = Tent.FilterPanelView.create()
	view.init()
	ok view.get('controller'), 'controller exists'

test 'Add / Remove Filter Field', ->
	controller = Tent.FilterPanelController.create
		collection: filteringCollection
	controller.addFilterField()

	equal controller.get('content').length, 1, 'Should be one entry' 
	controller.addFilterField()
	equal controller.get('content').length, 2, 'Should be 2 entries' 
	controller.removeFilterField(controller.get('content')[0])
	equal controller.get('content').length, 1, 'Should be 1 entry again' 
	controller.removeFilterField(controller.get('content')[0])
	equal controller.get('content').length, 0, 'Should be 0 entry again' 

test 'get filterable columns', ->
	controller = Tent.FilterPanelController.create
		collection: filteringCollection

	equal filteringCollection.get('filterableColumns').length, 2, 'There should be 2 filterable columns'
	ok true

test 'selectedColumn binding', ->
	controller = Tent.FilterPanelController.create
		collection: filteringCollection
	ok true

test 'apply filter', ->

	sinon.spy(filteringCollection, 'doFilter')
	view = Tent.FilterPanelView.create
		collection: filteringCollection
	view.init()
	view.set('showFilter', true)
	view.set('isPinned', false)
	view.applyFilter()
	ok not view.get('showFilter'), 'Filter should be hidden'
	ok filteringCollection.doFilter.calledOnce, 'Called doFilter'

 
	
###

test 'get stored filter values', ->
	filteringCollection = Ember.Object.create
		filteringInfo: 
			selectedFilter: 'task1'
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

						completed: {field:"completed",op: "equal", data: true
						}
					}
				}
			]

		selectedFilter: (->
			@get('filteringInfo.availableFilters')[0]
		).property('filteringInfo.availableFilters')

	controller = Tent.FilterPanelController.create
		collection: filteringCollection

	equal controller.get('availableFields').length, 7, 'There should be 7 fields'

	ok true

###
	