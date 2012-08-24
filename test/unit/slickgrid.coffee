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
test 'Tests for Tent.SingleSelectGrid ', ->
	parentView = Ember.Object.create()
		createGrid: ->
			@grid = 
				setSelectionModel: ->
				onSelectedRowsChanged: ->
					subscribe: ->	
			

	singleGrid = Tent.SingleSelectGrid.create
		parent: parentView
###

	