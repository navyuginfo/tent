Tent.Application = Tent.Application or Em.Namespace.create

Tent.Application.MainMenuController = Ember.Controller.extend
	content: []
	init: ->
		@applyEntitlements()

	applyEntitlements: ->
		for menuGroup in @get('content')
			parentEntitled = false
			for item in menuGroup.items
				if @isEntitled(item.operation)
					item.entitled = true
					parentEntitled = true

			menuGroup.entitled = true if @isEntitled(menuGroup.operation) and parentEntitled

	isEntitled: (operation)->
		if operation?
			return Endeavour.policy(operation)
		true

	menuClicked: (action)->
		@get('target').send(action)
