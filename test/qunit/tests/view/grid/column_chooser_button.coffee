view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->

teardown = ->

module 'Tent.Grid.ColumnChooserButton', setup, teardown

test 'Test that', ->
	grid = Ember.Object.create
		horizontalScrolling: true
		bindToggleVisibility: ->
		showCol: ->
		hideCol: ->
		content: Ember.Object.create
			filteredColumns: {
				filtered: ['col4']
			}
		columnModel: [
			Ember.Object.create({name: 'col1', hidden: false, checked: true, title: 'title1'})
			Ember.Object.create({name: 'col2', hidden: false, checked: true, title: 'title2'})
			Ember.Object.create({name: 'col3', hidden: true, checked: false, title: 'title3'})
			Ember.Object.create({name: 'col3', hidden: true, checked: false, title: 'title3', hideable: false})
			Ember.Object.create({name: 'col4', hidden: false, checked: false, title:'title4', hideable: true})
		]

	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.Grid.ColumnChooserButton gridBinding="view.grid"}}'
		grid: grid
	
	appendView()

	equal view.$('[type="checkbox"]').length, 3, '3 checkboxes'
	equal view.$('[data-column="col1"]').length, 1, 'check that name1 was bound correctly'
	equal view.$('[data-column="col2"]').length, 1, 'check that name2 was bound correctly'
	equal view.$('span.title').eq(0).text(), 'title1', 'check that title1 was bound correctly'

