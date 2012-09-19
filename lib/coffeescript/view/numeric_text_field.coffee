#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../template/text_field'

Tent.NumericTextField = Tent.TextField.extend
	validate: ->
		didOtherValidationPass = @_super()
		value = @get('formattedValue')
		isValidNumber = @isValueEmpty(value) or Tent.Formatting.number.isValidNumber(value)
		@addValidationError(Tent.messages.NUMERIC_ERROR) unless isValidNumber
		didOtherValidationPass && isValidNumber

	isValueEmpty: (value) ->
		not (value? && value != '')

	#Format for display
	format: (value)->
		Tent.Formatting.number.format(value)

	# Format for binding
	unFormat: (value)->
		Tent.Formatting.number.unformat(value)