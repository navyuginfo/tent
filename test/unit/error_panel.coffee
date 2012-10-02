
Ember.LOG_BINDINGS = true

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

startup = ->
teardown = ->
	if view
      Ember.run -> view.destroy()
      view = null

module 'Tent.ErrorPanel', startup, teardown

test 'f', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.ErrorPanel labelBinding="label" }}'
		label: 'FooBar'

	appendView()
	equal view.$('.tent-error-panel').length, 1 , 'div exists'
	
	errorPanel = Ember.View.views[$('.tent-error-panel').attr('id')]
	Ember.set('Tent.errorPanel', errorPanel) 
	
	Widget = Ember.View.extend Tent.ValidationSupport
	widget = Widget.create()
	widget.flushValidationErrors()
	widget.addValidationError("first error")
	equal errorPanel.getErrorsForView(widget).length, 1, 'Should be 1 error'
	equal errorPanel.getErrorsForView(widget)[0], "first error", 'Correct errors content'
	
	errorPanel.clear()
	widget.addValidationError("second")
	console.log(errorPanel.getErrorsForView(widget))
	widget.addValidationError("third")
	equal errorPanel.getErrorsForView(widget).length, 3, 'Should be 3 errors'