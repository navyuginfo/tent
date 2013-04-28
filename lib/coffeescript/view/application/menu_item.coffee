Tent.Application = Tent.Application or Em.Namespace.create()

require '../../template/application/menu_item'

Tent.Application.MenuItemView = Ember.View.extend
	isEntitled: ->
		true
	templateName: 'application/menu_item'
	collapsed: false
	title: (->
		Tent.I18n.loc @get('content.title')
	).property()
	isEnabled: true

	isDisabled: (->
		not @get('content.isEnabled')
	).property('isEnabled')

	menuClicked: (e)->
		action = $(e.target).attr('data-action') or $(e.target).parents('[data-action]').attr('data-action')
		@get('controller').menuClicked(action)

