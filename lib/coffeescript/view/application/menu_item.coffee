Tent.Application = Tent.Application or Em.Namespace.create()

require '../../template/application/menu_item'

Tent.Application.MenuItemView = Ember.View.extend
	tagName: 'li'
	classNames: ['menu-item']
	layoutName: 'application/menu_item'
	collapsed: false
	isSelected: false
	isEntitled: true
	isEnabled: true

	init: ->
		@_super()
		@processEntitlements()

	hasAction: (->
		@get('action')?
	).property('action')

	menuClicked: (e)->
		if @get('hasAction') and @get('isEnabled')
			@get('controller').menuClicked(@)

	applyHighlight: (->
		if @get('isSelected')
			link = @$('a:first')
			link.addClass('active-menu') if link.is('.menu-link')
		else
			@$('a:first').removeClass('active-menu')
	).observes('isSelected')

	processEntitlements: ->
		if not @get('operations')? then return true

		operationsArr = @get('operations').removeWhitespace().split(',')
		entitlement = false
		for operation in operationsArr
			entitlement = entitlement or @evaluatePolicy(operation)
		@set('isEntitled', entitlement)
		
	evaluatePolicy: (operation)->
		if operation?
			return Endeavour.policy(operation)
		true

	isDisabled: (->
		not @get('isEnabled')
	).property('isEnabled')


