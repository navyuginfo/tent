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
		@validateWarnings() if didOtherValidationPass and isValidNumber
		didOtherValidationPass && isValidNumber

	validateWarnings: ->
		@_super()
	isValueEmpty: (value) ->
		not (value? && value != '')

	#Format for display
	format: (value)->
		Tent.Formatting.number.format(value)

	# Format for binding
	unFormat: (value)->
		Tent.Formatting.number.unformat(value)

	# Operators for use within a grid filter
	operators: [
		Ember.Object.create({label: "tent.filter.equal", operator: "equal"}),
		Ember.Object.create({label: "tent.filter.nEqual", operator: "nequal"})
		Ember.Object.create({label: "tent.filter.lThan", operator: "lthan"})
		Ember.Object.create({label: "tent.filter.lThanEq", operator: "lthaneq"})
		Ember.Object.create({label: "tent.filter.gThan", operator: "gthan"})
		Ember.Object.create({label: "tent.filter.gThanEq", operator: "gthaneq"})
		Ember.Object.create({label: "tent.filter.range", operator: "range"})
	]

	###*
	* @property {Array} rangeValue The value containing the range array if a range operator is selected while filtering
	* If no range operator is selected, this property will just return the normal value.
	*
	###
	rangeValue: (->
		if @get('isRangeOperator') and @get('value2')?
			[@get('value'), @get('value2')]
		else
			@get('value')
	).property('value', 'value2', 'isRangeOperator')

