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
		columnModel: [
			{name: 'col1', hidden: false, checked: true, title: 'title1'}
			{name: 'col2', hidden: false, checked: true, title: 'title2'}
			{name: 'col3', hidden: true, checked: false, title: 'title3'}
			{name: 'col3', hidden: true, checked: false, title: 'title3', hideable: false}
		]

	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.Grid.ColumnChooserButton gridBinding="view.grid"}}'
		grid: grid
	
	appendView()

	equal view.$('[type="checkbox"]').length, 3, '3 checkboxes'
	equal view.$('[data-column="col1"]').length, 1, 'check that name1 was bound correctly'
	equal view.$('[data-column="col2"]').length, 1, 'check that name2 was bound correctly'
	equal view.$('span.title').eq(0).text(), 'title1', 'check that title1 was bound correctly'

