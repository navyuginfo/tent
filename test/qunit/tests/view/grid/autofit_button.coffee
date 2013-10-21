view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->

teardown = ->

module 'Tent.Grid.Autofitbutton', setup, teardown


test 'Test hscrolling attribute', ->
	grid = Ember.Object.create
		horizontalScrolling: true
		showAutofitButton: true

	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.Grid.AutofitButton gridBinding="view.grid"}}'
		grid: grid
	
	appendView()

	autoFit = Ember.View.views[view.$('.button').attr('id')]

	button = view.$('.horizontal-scroll-button')
	equal button.length, 1, 'Anchor should be displayed'
	#equal hContainer.get('horizontalScrolling'), false, 'start with scrolling false'
	equal button.hasClass('active'), false, 'active'
	equal button.attr('title'), 'Auto-Fit', 'Check that the title is set'

	Ember.run ->
		autoFit.click()
		
	equal grid.get('horizontalScrolling'), false, 'scrolling is now false'
	equal button.hasClass('active'), true, 'activated'

	Ember.run ->
		autoFit.click()

	equal grid.get('horizontalScrolling'), true, 'scrolling is now true'
	equal button.hasClass('active'), false, 'de-activated'