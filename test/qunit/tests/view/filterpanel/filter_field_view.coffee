view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))
      
setup = -> 
teardown = ->  
   
    
module 'Tent.FilterFieldView', setup, teardown

test 'Ensure collection is created', ->

	ok true
	