view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->
	@application = Ember.Namespace.create()
teardown = ->
	@application = null
	if view
		Ember.run -> view.destroy()
		view = null

module "Handlebars : formatAmount", setup, teardown

test 'go', ->
	application.amount = 123456
	view = Ember.View.create
    	template: Ember.Handlebars.compile '{{formatAmount application.amount}}' 
	
	appendView()
	
	equal view.$().text(), Tent.Formatting.amount.format(application.amount), 'format amount'
