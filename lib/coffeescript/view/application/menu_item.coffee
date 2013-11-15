Tent.Application = Tent.Application or Em.Namespace.create()

require '../../template/application/menu_item'

Tent.Application.MenuItemView = Ember.View.extend
	tagName: 'li'
	classNames: ['menu-item']
	layoutName: 'application/menu_item'
	collapsed: false
	isEnabled: true
	anyChildEntitled: true

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
		@get('anyChildEntitled') and @evaluateEntitlements()
	).property('operations','anyChildEntitled')

	evaluateEntitlements: ->
		return true unless @get('operations')
		ops = @get('operations').removeWhitespace().split(',')
		ops.filter((operation) =>
			@evaluatePolicy(operation)
		).length > 0

	# If I am a nested menu item, ensure that my parent calls checkChildEntitlements().
	# This is called after the menu tree is rendered
	checkParentEntitlements: ->
		@get('parentView').checkChildEntitlements() if @get('parentView').checkChildEntitlements?

	# If all of my child menu items are not entitled, then neither am I
	checkChildEntitlements: ->
		if @get('childViews').filterProperty('isEntitled', true).length == 0
			@set('anyChildEntitled', false)

	evaluatePolicy: (operation)->
		return Endeavour.policy(operation)
		
	isDisabled: Ember.computed.not("isEnabled")

