view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->

teardown = ->

module 'Tent.DateRangeField', setup, teardown

test 'Test format and unFormat', ->
	view = Ember.View.create
    	template: Ember.Handlebars.compile '{{view Tent.DateRangeField required=true}}'
  	
  	appendView()
	ok true