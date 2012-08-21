#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../template/text_field'

Tent.NumericTextField = Tent.TextField.extend
	validate: ->
		isValid = @_super()
		value = @get('value')
		isValidNumber = isValid && @isValidNumber(value)
		@addValidationError(Tent.messages.NUMERIC_ERROR) unless isValidNumber
		isValidNumber

	isValidNumber: (value)->
		(value != '') && !(isNaN(value) || isNaN(parseFloat(value))) 

	#Format for display
	format: (value)->
		# Convert from a number to a string
		if (typeof value == 'number') or value == ''
			value.toString(10)
		else
			value

	# Format for binding
	unFormat: (value)->
		# Convert from a string to a number
		if @isValidNumber(value)
			val = parseFloat(value)
		else if value==""
			return null
		else 
			value
