#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require 'tent'
require 'ember-data'
require '~test/mocks/ember_data_mocks'
require('~test/fixtures/list_data_model')

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

Tent.MockCollection = Ember.ArrayController.extend()

Tent.MockDataView = Ember.Object.extend
	init: ->
		@onRowCountChanged = new Slick.Event()
		@onRowsChanged = new Slick.Event()
	triggerOnRowCountChanged: ->
		@onRowCountChanged.notify({previous: 10, current: 20}, null, @)
	triggerOnRowsChanged: ->
		@onRowsChanged.notify({previous: 10, current: 20}, null, @)


setup = ->
	@TemplateTests = Ember.Namespace.create()

	DS.fixtureAdapter.simulateRemoteResponse = false;
	@TemplateTests.store = DS.Store.create({
		revision: 4,
		adapter: DS.fixtureAdapter
	});

	@TemplateTests.testController = Tent.Controllers.GridController.create(
		content: TemplateTests.store.findAll(Tent.Fixtures.ListDataModel)
		store: TemplateTests.store
		modelType: Tent.Fixtures.ListDataModel
		columns: [
			{id: "id", name: "ID", field: "id", sortable: true},
			{id: "title", name: "Title", field: "title", sortable: true},
			{id: "duration", name: "Duration", field: "duration", sortable: true},
			{id: "%", name: "% Complete", field: "percentComplete"},
			{id: "start", name: "Start", field: "start"},
			{id: "finish", name: "Finish", field: "finish"},
			{id: "effort-driven", name: "Effort Driven", field: "effortDriven"}
		]
	)

teardown = ->
	if view
    	Ember.run -> view.destroy()
    	view = null
	@TemplateTests = undefined

module "Tent.SlickGrid", setup, teardown

test 'test collection creation is called', ->
	collectionCreationCalled = false

	Tent.SlickGrid.reopen
		ensureCollectionAvailable: ->
			collectionCreationCalled = true

	grid = Tent.SlickGrid.create
		collection: null
		dataStore: ->
			findQuery: ->
				return true
		dataType: 'Tent.SomeDataType'
		pageSize: 7

	collection = grid.get('collection') 
	ok collectionCreationCalled, 'Controller created by init()'
	ok grid.get('delegate') instanceof Ember.Object, 'Delegate created' 


test 'Providing a collection', ->
	collection = Tent.MockCollection.create()
	grid = Tent.SlickGrid.create
		collection: collection

	ok grid.get('collection') instanceof Tent.MockCollection, 'Collection assigned'

test 'Set selection when rowselection changes', ->
	init = Tent.SlickGrid.init
	Tent.SlickGrid.reopen
		init: ->
			
	model1 = Ember.Object.create({id: 100})
	model2 = Ember.Object.create({id: 200})
	collection = Tent.MockCollection.create
		modelData: [model1, model2]

	grid = Tent.SlickGrid.create
		collection: collection

	grid.set('rowSelection', {id: 200})
	equal grid.get('selection'), model2, 'Model2 was selected (single selection)'

	# Revert back to original init() method
	Tent.SlickGrid.reopen
		init: init

test 'Set selection when rowselection changes (multiselect)', ->
	init = Tent.SlickGrid.init
	Tent.SlickGrid.reopen
		init: ->
			
	model1 = Ember.Object.create({id: 100})
	model2 = Ember.Object.create({id: 200})
	collection = Tent.MockCollection.create
		modelData: [model1, model2]

	grid = Tent.SlickGrid.create
		collection: collection
		multiSelect: true

	grid.set('rowSelection', [{id: 200}, {id:100}])
	equal grid.get('selection')[0], model2, 'Model2 was selected (multi selection)'
	equal grid.get('selection')[1], model1, 'Model1 was selected (multi selection)'

	# Revert back to original init() method
	Tent.SlickGrid.reopen
		init: init

test 'Extend the options', ->
	grid = Tent.SlickGrid.create()
	grid.extendOptions()
	equal grid.get('options').showHeaderRow, false, 'Default showHeaderRow'
	equal grid.get('options').enableCellNavigation, true, 'Default cell navigation'
	equal grid.get('options').enableColumnReorder, true, 'Default column reorder'
	equal grid.get('options').multiColumnSort, true, 'Default multicolumnsort'

test 'Testing creation of data view', ->
	grid = Tent.SlickGrid.create
		pageSize: 12
	grid.set('remotePaging', false) 
	grid.createDataView()
	ok grid.get('dataView') instanceof Object, 'data view was created'
	equal grid.get('dataView').getPagingInfo().pageSize, 12, 'PageSize was set to 12'

test 'Setting dataview items from collection modelData', ->
	collectionContent = [
		{
			id: 6,
			title: 'title 6'
		},
		{
			id: 7,
			title: 'title 7'
		}
	]
	
	collection = Tent.MockCollection.create
		content: collectionContent
	grid = Tent.SlickGrid.create
		collection: collection
	grid.createDataView()
	grid.setDataViewItems()
	dataViewItems = grid.get("dataView").getItems()
	equal dataViewItems.length, 2, 'Should be 2 items in the dataView'
	equal dataViewItems[0].title, 'title 6', 'First title'
	equal dataViewItems[1].title, 'title 7', 'First title'

test 'Listen for selections on dataView', ->
	init = Tent.SlickGrid.init
	Tent.SlickGrid.reopen
		init: ->

	rowCountUpdated = false
	rendered = false
	invalidateRows = false

	grid = {
		updateRowCount: ->
			rowCountUpdated = true
		render: ->
			rendered = true
		invalidateRows: ->
			invalidateRows = true
		invalidate: ->
	}
	slick = Tent.SlickGrid.create
		grid: grid
		dataView: Tent.MockDataView.create()
	slick.listenForSelections()
	ok not rowCountUpdated, 'rowCount was not updated'
	ok not rendered, 'render() was not called'

	dataView = slick.get('dataView')
	dataView.triggerOnRowCountChanged()
	ok rowCountUpdated, 'rowCount was updated'
	ok rendered, 'render() was called'

	dataView.triggerOnRowsChanged()
	ok invalidateRows, 'invalidateRows was updated'

	# Revert back to original init() method
	Tent.SlickGrid.reopen
		init: init


###
Turn off tests until final approach with collections is determined




test 'Test that rendering occurred correctly', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.SlickGrid
				controllerBinding="TemplateTests.testController"
				columnsBinding="TemplateTests.testController.columns"
				paged=false
				id="taskselectionview"
			}}'

	appendView()
	equal view.$('.grid').length, 1, 'Container created with class=grid'
	equal view.$('.slick-header').length, 1, 'Header created'
	equal view.$('.slick-header-column').length, 7, 'There should be 7 columns'
	ok view.$('.slick-row').length > 0, 'There should be at least one visible row'

test 'Tests for client-side paging', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.SlickGrid
				controllerBinding="TemplateTests.testController"
				columnsBinding="TemplateTests.testController.columns"
				paged=true
				pageSize=3
				remotePaging=false
				id="taskselectionview"
			}}'

	appendView()
	equal view.$('.slick-row').length, 3, 'There should be 3 rows per page'

###

	