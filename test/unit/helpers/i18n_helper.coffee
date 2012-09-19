view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->
	@application = Ember.Namespace.create()
teardown = ->
	@application = null
	if view
		Ember.run -> view.destroy()
		view = null

module "Handlebars: loc", setup, teardown

test 'Basic translation', ->
	Tent.I18n.loadTranslations({_test_helper: 'testhelper'})
	application.key = "_test_helper"

	view = Ember.View.create
    	template: Ember.Handlebars.compile '{{loc application.key}}' 
	appendView()
	
	equal view.$().text(), 'testhelper', 'translate testhelper'

test 'Translation with arg substitution', ->
	Tent.I18n.loadTranslations({_test_helper: 'My name is %@ %@'})
	application.key = "_test_helper"
	application.firstName = "Penelope"
	application.lastName = "Pitstop"

	view = Ember.View.create
    	template: Ember.Handlebars.compile '{{loc application.key args="application.firstName application.lastName"}}' 
	appendView()
	
	equal view.$().text(), 'My name is Penelope Pitstop', 'arg substitution'

test 'Translation with numbered args', ->
	Tent.I18n.loadTranslations({_test_helper: 'My name is %@2 %@1'})
	application.key = "_test_helper"
	application.firstName = "Penelope"
	application.lastName = "Pitstop"

	view = Ember.View.create
    	template: Ember.Handlebars.compile '{{loc application.key args="application.firstName application.lastName"}}' 
	appendView()
	
	equal view.$().text(), 'My name is Pitstop Penelope', 'numbered arg substitution'