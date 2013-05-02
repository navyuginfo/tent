Tent.Application = Tent.Application or Em.Namespace.create

Tent.Application.MainMenuController = Ember.Controller.extend
	content: []
	init: ->
		@applyEntitlements()

	applyEntitlements: ->
		for menuGroup in @get('content')
			parentEntitled = false
			for item in menuGroup.items
				hasAnyEntitlements = @processItemEntitlements(item)
				if hasAnyEntitlements then parentEntitled = true
			menuGroup.entitled =  @processItemEntitlements(menuGroup) and parentEntitled

	processItemEntitlements: (item) ->
		item.entitled = true
		if not item.operations? then return true

		hasEntitlement = false
		if Object.prototype.toString.call(item.operations) is '[object Array]'
			entitlement = false
			for operation in item.operations
				entitlement = entitlement or @isEntitled(operation)
			if entitlement then hasEntitlement = entitlement
			item.entitled = entitlement
		return hasEntitlement

	isEntitled: (operation)->
		if operation?
			return Endeavour.policy(operation)
		true

	menuClicked: (action)->
		@get('target').send(action)
