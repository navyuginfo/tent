setup = ->
teardown = ->

module 'Tent.Grid.HorizontalScrollSupport', setup, teardown

test 'Test showAutofitButtonProp', ->
	View = Ember.View.extend Tent.Grid.HorizontalScrollSupport
	view = View.create
		showAutofitButton: true
		showCardView: false
	
	ok view.get('showAutofitButtonProp'), 'true to start'
	view.set('showCardView', true)
	ok not view.get('showAutofitButtonProp'), 'Should be false when card view is on.'
	
	view.set('showAutofitButton', false)
	view.set('showCardView', false)
	ok not view.get('showAutofitButtonProp'), 'Should be false when showAutoFitButton is false.'