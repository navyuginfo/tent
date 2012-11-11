view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->
	o = Ember.Object.extend Tent.ValidationSupport
	@v = o.create()
	@TemplateTests = Ember.Namespace.create()
	Ember.run ->
		@dispatcher = Ember.EventDispatcher.create()
		@dispatcher.setup()

teardown = ->
	o = null
	@v = null
	if view
		Ember.run -> view.destroy()
		view = null
	@TemplateTests = undefined
	@dispatcher.destroy()

module 'Tent.ValidationSupport', setup, teardown

test 'basic functionality', ->

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
	 
	updated = false
	v.updateErrorPanel = ->
		updated = true

	v.addValidationError('new error')
	ok updated, 'updateErrorPanel should have been called'

test 'Classnames', ->
	v.classNames = []
	equal v.classNames.contains('error'), false, 'No error to start with'
	v.addValidationError('new error')
	equal v.classNames.contains('error'), true, 'Error added'
	v.flushValidationErrors()
	equal v.classNames.contains('error'), false, 'Error removed'

test 'Custom Validations', ->
	v.set('validations', 'email')
	v.set('formattedValue','billy@bob.com')
	ok v.validate(), 'valid email format'
	v.set('formattedValue','billybob.com')
	ok not v.validate(), 'Invalid email format'
	equal v.get('validationErrors').length, 1, 'One error message'
	v.set('formattedValue','')
	ok v.validate(), "Doesn't try to evaluate empty string"
	v.set('validations', 'nulll')

	raises(-> 
			v.validate()
		,'Should have thrown exception: validator doesnt exist')

	v.set('validations', '')	
	ok v.validate(), "Doesn't try to evaluate empty string validator"

test 'Custom validations with options: formatted value', ->
	v.set('validations', 'datebetween')
	v.set('formattedValue','10/10/2012')
	v.set('validationOptions', {'datebetween':{startDate:'8/8/2012',endDate:'12/12/2012'}})
	ok v.validate(), 'validate datebetween'
	equal v.get('validationErrors').length, 0, 'No error messages'
	v.set('validationOptions', {'datebetween':{startDate:'11/11/2012',endDate:'12/12/2012'}})
	ok not v.validate(), 'validate datebetween should fail'
	equal v.get('validationErrors').length, 1, 'One error message'
	equal v.get('validationErrors')[0], "Date should be between 11/11/2012 and 12/12/2012", 'error message text'
	v.set('validationOptions')
	ok not v.validate(), 'no options provided'
	v.set('validationOptions', {'datebetween':{endDate:'12/12/2012'}})
	ok not v.validate(), 'No startDate provided'

test 'Custom validations with Text View', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.TextField 
			valueBinding="val" 
			validations="email" 
		}}'
		val: 'n@dd.com'
		label: 'FooBar'

	appendView()
	textView = Ember.View.views[view.$('.tent-text-field').attr('id')]

	ok textView.validate(), 'validating text view'
	textView.set('value', 'nnnnn')
	ok not textView.validate(), 'validating text view'


test 'Custom Validations with Text view and options', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.TextField 
			validations="datebetween"
			validationOptions="{datebetween:{startDate:\'8/8/2012\', endDate:\'12/12/2012\'}}" 
		}}'

	appendView()
	textView = Ember.View.views[view.$('.tent-text-field').attr('id')]

	textView.set('formattedValue', '10/10/2012')
	ok textView.validate(), 'Options should succeed'
	textView.set('formattedValue', '1/1/2012')
	ok not textView.validate(), 'Options should not succeed'

test 'Warnings', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.TextField 
		}}'

	appendView()
	textView = Ember.View.views[view.$('.tent-text-field').attr('id')]
	textView.set('warnings','blah')
	raises(-> 
			textView.validate()
		,'Should have thrown exception: warning validator doesnt exist')

	v.set('warnings', '')	
	equal textView.get('validationWarnings').length, 0, 'empty string'

	textView.set('warnings','email')
	textView.set('formattedValue', 'not_an_email')
	textView.validate()
	equal textView.get('validationWarnings').length, 1, '1 warning added'
	textView.set('formattedValue', 'aa@bb.com')
	textView.validate()
	equal textView.get('validationWarnings').length, 0, 'no more warnings'

	textView.set('processWarnings', false)
	textView.set('formattedValue', 'not_an_email')
	textView.validate()
	equal textView.get('validationWarnings').length, 0, 'stopped processing warnings'
	textView.set('processWarnings', true)
	textView.validate()
	equal textView.get('validationWarnings').length, 1, 'processing again'



###
#test 'Custom validations with options: value', ->

test 'Custom validations with error message', ->

test 'Custom validations with options', ->




