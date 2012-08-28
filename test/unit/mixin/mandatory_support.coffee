

module 'Tent.MandatorySupport'

test 'Is Value Empty',->
	Mixin = Ember.Object.extend Tent.MandatorySupport
	mixin = Mixin.create()

	ok mixin.isValueEmpty("") ,'Empty string'
	ok mixin.isValueEmpty(null) ,'null'
	ok mixin.isValueEmpty([]) ,'Empty array'
	ok not mixin.isValueEmpty([1,2,3]) ,'non-empty array'

test 'Test for validate', ->
	MixedParent = Ember.Object.extend Tent.ValidationSupport, Tent.MandatorySupport
	mixin = MixedParent.create()

	mixin.set('valueForMandatoryValidation', 'somevalue')
	ok mixin.validate(), 'Should pass basic validation'

	mixin.set('valueForMandatoryValidation', '')
	ok mixin.validate(), 'Should pass basic validation without isMandatory set'

	mixin.set('isMandatory', true)
	ok not mixin.validate(), 'Should fail now with isMandatory set'
	equal mixin.get('validationErrors').length, 1, 'Should be one error message'

	mixin.set('valueForMandatoryValidation', [])
	ok not mixin.validate(), 'Should fail with empty array'
	equal mixin.get('validationErrors').length, 1, 'Should be one error message'


###
	validate: ->
		isValid = @_super()
		value = @get('valueForMandatoryValidation')
		isValid = isValid && ((not @isMandatory) or (not @isValueEmpty(value)))
		@addValidationError(Tent.messages.MANDATORY_ERROR) unless isValid
		isValid
###


