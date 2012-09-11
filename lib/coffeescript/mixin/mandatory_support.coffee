#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../util/computed'
 
Tent.MandatorySupport = Ember.Mixin.create
	required: false
	requiredAsBoolean: Tent.computed.boolCoerceGently 'required'

	validate: ->
		isValid = @_super()
		value = @get('valueForMandatoryValidation')
		isValid = isValid && ((not @get('required') and not @get('isMandatory')) or (not @isValueEmpty(value)))
		@addValidationError(Tent.messages.REQUIRED_ERROR) unless isValid
		isValid

	isValueEmpty: (value) ->
		not (value? && value != '' && (if value.length? then value.length > 0 else true))







