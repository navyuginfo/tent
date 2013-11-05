view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->

teardown = ->

module 'Tent.JqGridHeaderView', setup, teardown

test 'showAutofitButton property', ->
	grid = Ember.Object.create
		horizontalScrolling: true
		showAutofitButtonProp: true

	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.JqGridHeaderView gridBinding="view.grid"}}'
		grid: grid
	
	appendView()

	button = view.$('.horizontal-scroll-button')
	equal button.length, 1, 'button should be displayed'

test 'showAutofitButton property', ->
	grid = Ember.Object.create
		horizontalScrolling: true
		showAutofitButtonProp: false

	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.JqGridHeaderView gridBinding="view.grid"}}'
		grid: grid
	
	appendView()

	button = view.$('.horizontal-scroll-button')
	equal button.length, 0, 'button should not be displayed'


test 'someExportsAreAllowed : true', ->
	grid = Ember.Object.create
		enabledExports: ['csv', 'xls', 'json']
		
	view = Tent.JqGridHeaderView.create()
	view.set('grid', grid)
	ok view.get('someExportsAreAllowed'), 'default is true'

test 'someExportsAreAllowed : false', ->
	grid = Ember.Object.create
		enabledExports: []
		
	view = Tent.JqGridHeaderView.create()
	view.set('grid', grid)
	equal view.get('someExportsAreAllowed'), false, 'value is false when all items are false'



