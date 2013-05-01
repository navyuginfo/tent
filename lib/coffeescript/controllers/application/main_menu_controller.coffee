Tent.Application = Tent.Application or Em.Namespace.create

Tent.Application.MainMenuController = Ember.Controller.extend
	content: []
	init: ->
		@applyEntitlements()

	applyEntitlements: ->
		for menuGroup in @get('content')
		  parentEntitled = true
		  for item in menuGroup.items
		    item.entitled = true
		    if Object.prototype.toString.call(item.operations) is '[object Array]'
		      entitlement = false
		      for operation in item.operations
		        entitlement = entitlement or @isEntitled(operation)
		      if entitlement then parentEntitled = entitlement
		      item.entitled = entitlement
		        
			 
			 menuGroup.entitled = true if @isEntitled(menuGroup.operation) and parentEntitled

	isEntitled: (operation)->
		if operation?
			return Endeavour.policy(operation)
		true

	menuClicked: (action)->
		@get('target').send(action)
