setup = ->
teardown = ->

module 'Tent.Application.MainMenuController', setup, teardown

test 'applyEntitlements', ->
	controller = Tent.Application.MainMenuController.create()
	controller.isEntitled = (operation)->
		if operation=='invalid'
			return false
		true

	controller.set('content', [
		Ember.Object.create
			title: 'menu.upload.main'
			operations: ['invalid']
			icon: ''
			items: [
				Ember.Object.create title:'menu.upload.history', action: 'showInvoiceFiles', icon: 'icon-time'
				Ember.Object.create title:'menu.upload.newUpload', action: 'showNewUpload', icon: 'icon-upload'
			]	
	])

	controller.applyEntitlements()
	equal controller.get('content')[0].entitled, false, 'No entitlements'

	controller.get('content')[0].set('operations', ['sell'])
	controller.applyEntitlements()
	equal controller.get('content')[0].entitled, true, 'Group is entitled'

	controller.set('content', [
		Ember.Object.create
			title: 'menu.upload.main'
			operations: ['sell']
			icon: ''
			items: [
				Ember.Object.create {title:'menu.upload.history', action: 'showInvoiceFiles', icon: 'icon-time', operations: ['invalid']}
				Ember.Object.create {title:'menu.upload.newUpload', action: 'showNewUpload', icon: 'icon-upload', operations: ['invalid']}
			]
	])

	controller.applyEntitlements()
	equal controller.get('content')[0].entitled, false, 'Not entitled since no child items are entitled'

	
	controller.set('content', [
		Ember.Object.create
			title: 'menu.upload.main'
			operations: ['sell']
			icon: ''
			items: [
				Ember.Object.create {title:'menu.upload.history', action: 'showInvoiceFiles', icon: 'icon-time', operations: ['invalid']}
				Ember.Object.create {title:'menu.upload.newUpload', action: 'showNewUpload', icon: 'icon-upload', operations: ['sell2']}
			]
	])

	controller.applyEntitlements()
	equal controller.get('content')[0].entitled, true, 'Entitled since at least one child item is entitled'

	controller.set('content', [
		Ember.Object.create
			title: 'menu.upload.main'
			icon: ''
			items: [
				Ember.Object.create {title:'menu.upload.newUpload', action: 'showNewUpload', icon: 'icon-upload', operations: ['sell2']}
			]
	])

	controller.applyEntitlements()
	equal controller.get('content')[0].entitled, true, 'No operations for the group'

	controller.set('content', [
		Ember.Object.create
			title: 'menu.upload.main'
			icon: ''
			items: [
				Ember.Object.create {title:'menu.upload.newUpload', action: 'showNewUpload', icon: 'icon-upload'}
			]
	])

	controller.applyEntitlements()
	equal controller.get('content')[0].entitled, true, 'No operations at all'
