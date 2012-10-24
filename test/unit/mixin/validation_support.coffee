
setup = ->
teardown = ->

module 'Tent.ValidationSupport', setup, teardown

test 'basic functionality', ->
	o = Ember.Object.extend Tent.ValidationSupport
	v = o.create()

	v.validate()
	equal v.get('isValid'), true, 'reset validation to true'
	equal v.get('validationErrors').length, 0, 'No validation errors'

	v.addValidationError('new error')
	equal v.get('isValid'), false, 'set validation to false'
	equal v.get('validationErrors').length, 1, '1 error'
	equal v.get('hasErrors'), true, 'hasErrors is true'


	v.flushValidationErrors()
	equal v.get('validationErrors').length, 0, '0 errors'
	equal v.get('hasErrors'), false, 'hasErrors is false'

test 'Update error panel', ->
	o = Ember.Object.extend Tent.ValidationSupport
	v = o.create()

	updated = false
	v.updateErrorPanel = ->
		updated = true

	v.addValidationError('new error')
	ok updated, 'updateErrorPanel should have been called'

test 'Classnames', ->
	o = Ember.Object.extend Tent.ValidationSupport
	v = o.create()
	v.classNames = []
	equal v.classNames.contains('error'), false, 'No error to start with'
	v.addValidationError('new error')
	equal v.classNames.contains('error'), true, 'Error added'
	v.flushValidationErrors()
	equal v.classNames.contains('error'), false, 'Error removed'
	

