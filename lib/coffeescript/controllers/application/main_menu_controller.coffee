Tent.Application = Tent.Application or Em.Namespace.create

Tent.Application.MainMenuController = Ember.Controller.extend
	content: []
	init: ->
		@_super()
		@applyEntitlements()

	applyEntitlements: (->
		menuController = @
		@get('content').forEach((menuGroup)->
			parentEntitled = false
			for item in menuGroup.items
				hasAnyEntitlements = menuController.processItemEntitlements(item)
				if hasAnyEntitlements then parentEntitled = true
			menuGroup.set('entitled', menuController.processItemEntitlements(menuGroup) and parentEntitled)
		)
	).observes('content.@each')

	processItemEntitlements: (item) ->
		item.set('entitled', true)
		if not item.get('operations')? then return true

		hasEntitlement = false
		if Object.prototype.toString.call(item.get('operations')) is '[object Array]'
			entitlement = false
			for operation in item.get('operations')
				entitlement = entitlement or @isEntitled(operation)
			if entitlement then hasEntitlement = entitlement
			item.set('entitled', entitlement)
		return hasEntitlement

	isEntitled: (operation)->
		if operation?
			return Endeavour.policy(operation)
		true

	menuClicked: (action)->
		@get('target').send(action)
