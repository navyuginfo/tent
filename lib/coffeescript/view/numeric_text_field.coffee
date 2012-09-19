#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
* @class Tent.NumericTextField
* @extends Tent.TextField
* Usage
*       {{view Tent.NumericTextField label="" 
			valueBinding="" 
			dateFormat=""
         }}
###

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