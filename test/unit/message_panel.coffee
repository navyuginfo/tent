
#Ember.LOG_BINDINGS = true

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


test 'Removing messages', ->
	view = Tent.MessagePanel.create()

	message = Tent.Message.create
		type: Tent.Message.ERROR_TYPE
		sourceId: 'id1'
		messages: ['error1', 'error2','error3']

	message2 = Tent.Message.create
		type: Tent.Message.ERROR_TYPE
		sourceId: 'id2'
		messages: ['error4', 'error5', 'error6']

	view.handleNewMessage(null, message)
	view.handleNewMessage(null, message2)
	equal view.getErrorsForView('id1').length, 3, '3 errors for id1 returned'
	equal view.get('error').length, 2, '2 errors in total'

	view.removeMessage(Tent.Message.ERROR_TYPE, 'id2')
	equal view.get('error').length, 1, '1 error left'

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


test 'Collapsed property', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.MessagePanel collapsed=false }}'
		label: 'FooBar'

	appendView()
	equal view.$('.tent-message-panel').length, 1 , 'div exists'
	Ember.run ->
		$.publish('/message', {type:'error', messages:['message1']})
	equal view.$('.error-expando.in').length, 1, 'in- attribute added'


test 'Collapsible property', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.MessagePanel collapsible=false }}'
		label: 'FooBar'

	appendView()
	equal view.$('.tent-message-panel').length, 1 , 'div exists'
	Ember.run ->
		$.publish('/message', {type:'error', messages:['message1']})
	equal view.$('.collapse').length, 0, 'not collapsible'


test 'Test for showing dropdown button', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.MessagePanel collapsible=true }}'
		label: 'FooBar'

	appendView()
	equal view.$('.tent-message-panel').length, 1 , 'div exists'
	Ember.run ->
		$.publish('/message', {type:'error', messages:['message1']})
	equal view.$('.dropdown-toggle').length, 0, 'no dropdown button shown'
	Ember.run ->
		$.publish('/message', {type:'error', messages:['message2'], sourceId: 'id1'})
	equal view.$('.dropdown-toggle').length, 1, 'dropdown button shown'
	Ember.run ->
		$.publish('/message', {type:'error', messages:[], sourceId: 'id1'})
	equal view.$('.dropdown-toggle').length, 0, 'dropdown button removed'



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
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.MessagePanel labelBinding="label" }}'
		label: 'FooBar'

	appendView()
	equal view.$('.tent-message-panel').length, 1 , 'div exists'
	
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

test 'hasWarnings', ->
	view = Tent.MessagePanel.create()

	message = Tent.Message.create
		type: Tent.Message.WARNING_TYPE
		sourceId: 'id1'
		messages: ['warning1', 'warning2']

	view.handleNewMessage(null, message)

	ok view.get('hasWarnings'), 'there should be warnings'

	#equal view.getErrorsForView('id1').length, 2, '2 errors returned'



	