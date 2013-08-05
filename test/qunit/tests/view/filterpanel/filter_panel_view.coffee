view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))
      
setup = -> 
teardown = ->  
   
    
module 'Tent.FilterPanelView', setup, teardown

test 'Ensure collection is created', ->
	view = Tent.FilterPanelView.create()
	view.init()
	ok view.get('controller'), 'controller exists'

test 'Add / Remove Filter Field', ->
	controller = Tent.FilterPanelController.create()
	controller.addFilterField()
	equal controller.get('content').length, 1, 'Should be one entry' 
	controller.addFilterField()
	equal controller.get('content').length, 2, 'Should be 2 entries' 
	controller.removeFilterField(controller.get('content')[0])
	equal controller.get('content').length, 1, 'Should be 1 entry again' 
	controller.removeFilterField(controller.get('content')[0])
	equal controller.get('content').length, 0, 'Should be 0 entry again' 


	