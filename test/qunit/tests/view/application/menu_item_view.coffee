view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))
setup = ->
teardown = ->

module 'Tent.Application.MenuItemView', setup, teardown

test 'processEntitlements', ->

	cachedPolicy = Tent.Application.MenuItemView.evaluatePolicy

	Tent.Application.MenuItemView.reopen
		evaluatePolicy: (operation)->
			return ['valid-operation', 'another-valid-operation'].contains(operation)

	menuItem = Tent.Application.MenuItemView.create
		title: "menu.upload.newUpload"
		action: "showNewUpload"
		icon: "icon-cloud-upload"
		route: "/upload_invoice"

	ok menuItem.get('isEntitled'), "Should be entitled by default"
	ok menuItem.get('isEntitled'), "Entitled if no operations are provided"

	menuItem.set('operations', 'valid-operation')
	ok menuItem.get('isEntitled'), "valid"	

	menuItem.set('operations', 'invalid-operation')
	ok not menuItem.get('isEntitled'), "invalid"	

	menuItem.set('operations', 'valid-operation, another-valid-operation')
	ok menuItem.get('isEntitled'), "valid for second operation"

	menuItem.set('operations', 'invalid-operation, another-valid-operation')
	ok menuItem.get('isEntitled'), "valid when there is at least 1 valid operation"

	menuItem.set('operations', '  valid-operation  ,    another-valid-operation    ')
	ok menuItem.get('isEntitled'), "valid with whitespace"


	Tent.Application.MenuItemView.reopen
		evaluatePolicy: cachedPolicy

###test 'applyEntitlements', ->
	controller = Tent.Application.MainMenuController.create()
	controller.set('content', [
		{
			title: 'menu.upload.main'
			operations: ['invalid']
			icon: ''
			items: [
				{title:'menu.upload.history', action: 'showInvoiceFiles', icon: 'icon-time'}
				{title:'menu.upload.newUpload', action: 'showNewUpload', icon: 'icon-upload'}
			]
		}
	])

	controller.isEntitled = (operation)->
		if operation=='invalid'
			return false
		true

	controller.applyEntitlements()
	equal controller.get('content')[0].entitled, false, 'No entitlements'

	controller.set('content', [
		{
			title: 'menu.upload.main'
			operations: ['sell']
			icon: ''
			items: [
				{title:'menu.upload.history', action: 'showInvoiceFiles', icon: 'icon-time'}
				{title:'menu.upload.newUpload', action: 'showNewUpload', icon: 'icon-upload'}
			]
		}
	])

	controller.applyEntitlements()
	equal controller.get('content')[0].entitled, true, 'Group is entitled'


	controller.set('content', [
		{
			title: 'menu.upload.main'
			operations: ['sell']
			icon: ''
			items: [
				{title:'menu.upload.history', action: 'showInvoiceFiles', icon: 'icon-time', operations: ['invalid']}
				{title:'menu.upload.newUpload', action: 'showNewUpload', icon: 'icon-upload', operations: ['invalid']}
			]
		}
	])

	controller.applyEntitlements()
	equal controller.get('content')[0].entitled, false, 'Not entitled since no child items are entitled'

	controller.set('content', [
		{
			title: 'menu.upload.main'
			operations: ['sell']
			icon: ''
			items: [
				{title:'menu.upload.history', action: 'showInvoiceFiles', icon: 'icon-time', operations: ['invalid']}
				{title:'menu.upload.newUpload', action: 'showNewUpload', icon: 'icon-upload', operations: ['sell2']}
			]
		}
	])

	controller.applyEntitlements()
	equal controller.get('content')[0].entitled, true, 'Entitled since at least one child item is entitled'

	controller.set('content', [
		{
			title: 'menu.upload.main'
			icon: ''
			items: [
				{title:'menu.upload.newUpload', action: 'showNewUpload', icon: 'icon-upload', operations: ['sell2']}
			]
		}
	])

	controller.applyEntitlements()
	equal controller.get('content')[0].entitled, true, 'No operations for the group'

	controller.set('content', [
		{
			title: 'menu.upload.main'
			icon: ''
			items: [
				{title:'menu.upload.newUpload', action: 'showNewUpload', icon: 'icon-upload'}
			]
		}
	])

	controller.applyEntitlements()
	equal controller.get('content')[0].entitled, true, 'No operations at all'
###