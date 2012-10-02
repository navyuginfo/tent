
Ember.LOG_BINDINGS = true

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

startup = ->
teardown = ->
	if view
		Ember.run -> view.destroy()
		view = null

module 'Tent.MessagePanel', startup, teardown

test 'Basic functionality', ->
	view = Tent.MessagePanel.create()

	message = Tent.Message.create
		type: Tent.Message.ERROR_TYPE
		sourceId: 'id1'
		messages: ['error1', 'error2']

	view.handleNewMessage(null, message)
	equal view.getErrorsForView('id1').length, 2, '2 errors returned'

	message = Tent.Message.create
		type: Tent.Message.INFO_TYPE
		sourceId: 'id1'
		messages: ['info1', 'info2']

	view.handleNewMessage(null, message)
	equal view.getInfosForView('id1').length, 2, '2 infos returned'

	view.clearErrors()
	equal view.getErrorsForView('id1').length, 0, '0 errors returned'

	view.clearInfos()
	equal view.getInfosForView('id1').length, 0, '0 infos returned'

test 'Test auto clearing of errors for source', ->
	view = Tent.MessagePanel.create()

	message = Tent.Message.create
		type: Tent.Message.ERROR_TYPE
		sourceId: 'id1'
		messages: ['error1', 'error2']

	view.handleNewMessage(null, message)
	equal view.getErrorsForView('id1').length, 2, '2 errors returned'

	message = Tent.Message.create
		type: Tent.Message.ERROR_TYPE
		sourceId: 'id1'
		messages: []
	view.handleNewMessage(null, message)
	equal view.getErrorsForView('id1').length, 0, 'Errors should have been cleared'

test 'Exception thrown when no type specified', ->
	view = Tent.MessagePanel.create()
	message = Tent.Message.create()
	raises(-> 
			view.handleNewMessage(null, message)
		,'Exception should be thrown')
	 

test "pub / sub", ->
	view1 = Tent.MessagePanel.create()

	message = Tent.Message.create
		type: Tent.Message.ERROR_TYPE
		sourceId: 'id1'
		messages: ['error1', 'error2']

	$.publish('/message', message)
	equal view1.getErrorsForView('id1').length, 2, '2 errors returned'


test 'Called by ValidationSupport', ->
	view2 = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.MessagePanel labelBinding="label" }}'
		label: 'FooBar'

	appendView()
	equal view2.$('.tent-message-panel').length, 1 , 'div exists'
	
	errorPanel = Ember.View.views[$('.tent-message-panel').attr('id')]

	Widget = Ember.View.extend Tent.ValidationSupport
	widget = Widget.create()
	widget.flushValidationErrors()
	widget.addValidationError("first error")
	equal errorPanel.getErrorsForView(widget.get('elementId')).length, 1, 'Should be 1 error'
	equal errorPanel.getErrorsForView(widget.get('elementId'))[0], "first error", 'Correct errors content'
	
	errorPanel.clearErrors()
	widget.addValidationError("second")
	widget.addValidationError("third")
	equal errorPanel.getErrorsForView(widget.get('elementId')).length, 3, 'Should be 3 errors'

	