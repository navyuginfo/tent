view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->
	@application = Ember.Namespace.create()
teardown = ->
	@application = null
	if view
		Ember.run -> view.destroy()
		view = null

module "Handlebars : formatNumber", setup, teardown

test 'Default formatting', ->
	application.number = 12345678.6656
	view = Ember.View.create
    	template: Ember.Handlebars.compile '{{formatNumber application.number}}' 
	
	appendView()
	
	equal view.$().text(), Tent.Formatting.number.format(application.number), 'format date'