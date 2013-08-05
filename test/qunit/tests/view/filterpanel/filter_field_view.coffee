view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))
      
setup = -> 
teardown = ->  
   
    
module 'Tent.FilterFieldView', setup, teardown


test 'typeIsSelected property', ->
	view = Tent.FilterFieldView.create
		content: {}
	ok not view.get('typeIsSelected')
	
	view.set('content', {field: 'title'})
	ok view.get('typeIsSelected')
