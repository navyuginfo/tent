view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->
	@application = Ember.Namespace.create()
teardown = ->
	@application = null
	if view
		Ember.run -> view.destroy()
		view = null

module "Handlebars : formatDate", setup, teardown

test 'Default formatting', ->
	application.date = new Date()
	view = Ember.View.create
    	template: Ember.Handlebars.compile '{{formatDate application.date}}' 
	
	appendView()
	
	equal view.$().text(), Tent.Formatting.date.format(application.date), 'format date'

test 'Test with user-specified date format', ->
	application.date = new Date()
	view = Ember.View.create
    	template: Ember.Handlebars.compile '{{formatDate application.date format="yy/mm/dd"}}' 
	
	appendView()
	
	equal view.$().text(), Tent.Formatting.date.format(application.date, "yy/mm/dd"), 'format date with provided format'