setup = ->
teardown = ->

module 'Tent.Application.MainMenuController', setup, teardown

test 'selection', ->
	item = Ember.Object.create
		action: 'testAction'
	actionWasExecuted = false
	
	controller = Tent.Application.MainMenuController.create
		target: 
			send: ->
				actionWasExecuted = true

	ok not actionWasExecuted
	controller.menuClicked(item)
	equal controller.get('selectedItem'), item, 'Item was stored'
	ok actionWasExecuted

test 'menuTransition', ->
	item = Ember.Object.create
		action: 'testAction'
	
	controller = Tent.Application.MainMenuController.create()

	controller.menuTransition('testAction1')
	equal controller.get('selectedAction'), 'testAction1', 'Action was stored'
	 