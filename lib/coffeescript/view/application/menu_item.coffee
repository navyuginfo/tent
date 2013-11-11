Tent.Application = Tent.Application or Em.Namespace.create()

require '../../template/application/menu_item'

Tent.Application.MenuItemView = Ember.View.extend
	tagName: 'li'
	classNames: ['menu-item']
	layoutName: 'application/menu_item'
	collapsed: false
	isEnabled: true

	init: ->
		@_super()

	hasAction: Ember.computed.bool('action') 

	menuClicked: (e)->
		if @get('hasAction') and @get('isEnabled')
			@get('controller').menuClicked(@)

	isSelected: (->
		@get('controller.selectedItem') == this
	).property('controller.selectedItem')

	applyHighlight: (->
		@get('isSelected') && @get('hasAction')
	).property('isSelected')

	isEntitled: (->
		return true unless @get('operations')
		ops = @get('operations').removeWhitespace().split(',')
		ops.filter((operation) =>
			@evaluatePolicy(operation)
		).length > 0
	).property('operations')

	evaluatePolicy: (operation)->
		return Endeavour.policy(operation)
		
	isDisabled: Ember.computed.not("isEnabled")

