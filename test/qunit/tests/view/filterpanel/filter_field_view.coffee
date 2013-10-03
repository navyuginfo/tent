view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))
      
setup = -> 
teardown = ->  
   
    
module 'Tent.FilterFieldView', setup, teardown


test 'typeIsSelected property', ->
	view = Tent.FilterFieldView.create
		content: {}
	ok not view.get('typeIsSelected')
	
	view.set('content', {field: 'title'})
	ok view.get('typeIsSelected')


test 'toggleLock', ->
	view = Tent.FilterFieldController.create
		content: Ember.Object.create
			locked:false

	view.set('usageContext', 'report')
	ok not view.get('content.locked'), 'locked is false to start'
	view.toggleLock()
	ok view.get('content.locked'), 'locked should toggle to true for a report'
	view.toggleLock()
	ok not view.get('content.locked'), 'locked should toggle back to false for a report'

	view.set('usageContext', 'view')
	ok not view.get('content.locked'), 'locked is false to start'
	view.toggleLock()
	ok not view.get('content.locked'), 'locked should not toggle for a view'
	
	view.set('usageContext', null)
	ok not view.get('content.locked'), 'locked is false to start'
	view.toggleLock()
	ok not view.get('content.locked'), 'locked should not toggle for an undefined usageContext'

test 'isDisabled', ->
	view = Tent.FilterFieldController.create
		content: Ember.Object.create
			locked:true

	view.set('usageContext', 'report')
	ok not view.get('isDisabled'), 'field should not be disabled if it is locked and in report mode'
	view.set('usageContext', 'view')
	ok view.get('isDisabled'), 'field should be disabled if it is locked and in view mode'
	view.set('usageContext', null)
	ok view.get('isDisabled'), 'field should be disabled if it is locked and no usageContext provided'

test 'showLockIcon', ->
	view = Tent.FilterFieldView.create
		createController: ->
			Ember.Object.create({locked: false})

	view.set('usageContext', 'view')
	ok not view.get('showLockIcon'), 'Dont show lock when in view mode and not locked'
	view.set('controller.locked', true)
	ok view.get('showLockIcon'), 'Show lock when in view mode and locked'
	view.set('usageContext', null)
	ok view.get('showLockIcon'), 'Show lock when locked and no context specified'
	view.set('controller.locked', false)
	ok not view.get('showLockIcon'), 'Dont show lock when not locked and no context specified'
	view.set('usageContext', 'report')
	ok view.get('showLockIcon'), 'Show lock when in report mode'

test 'lockIsSelected', ->
	view = Tent.FilterFieldView.create
		createController: ->
			Ember.Object.create({locked: false, lockIsEnabled: true})

	ok not view.get('lockIsSelected'), 'Not selected when unlocked'
	view.set('controller.locked', true)
	ok view.get('lockIsSelected'), 'Selected when locked'

	view.set('controller.lockIsEnabled', false)
	ok not view.get('lockIsSelected'), 'Not selected when disabled'
	view.set('controller.locked', false)
	ok not view.get('lockIsSelected'), 'Not selected when unlocked and disabled'

	
test 'showTrashIcon', ->
	view = Tent.FilterFieldView.create
		createController: ->
			Ember.Object.create({locked: false})

	view.set('usageContext', 'view')
	ok not view.get('showTrashIcon'), 'Dont show trash when in view mode'
	view.set('usageContext', 'report')
	ok view.get('showTrashIcon'), 'Show trash when in report mode'
	view.set('usageContext', null)
	ok not view.get('showTrashIcon'), 'Dont show trash when in undefined mode'



