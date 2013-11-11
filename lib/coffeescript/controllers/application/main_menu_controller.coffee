Tent.Application = Tent.Application or Em.Namespace.create


Tent.Application.MainMenuController = Ember.Controller.extend
	selectedItem: null
	selectedAction: null

	menuClicked: (menuItem)->
		@set('selectedItem', menuItem)

	selectedItemDidChange: (->
		@executeAction(@get('selectedItem').get('action'))
	).observes('selectedItem')

	executeAction: (action)->
		@get('target').send(action)

	#This method is defined for the case when some routing action should happen on a button click or 
	# on some other action rather than clicking on menu item (which usually happens)
	# By setting the action, the view will determine which menuitem should be selected
	menuTransition: (action)->
		@set('selectedAction', action)

