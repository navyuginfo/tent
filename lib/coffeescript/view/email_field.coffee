#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
* @class Tent.EmailField
* @extends Tent.TextField
* A text field which allows an email address to be entered. An error message will be displayed if the user enters
* a badly-formed email.
*  
* Usage
*       {{view Tent.EmailField 
			label="" 
			valueBinding="" 
         }}
###

require '../mixin/field_support'
require '../template/text_field'

Tent.EmailTextField = Tent.TextField.extend
	validate: ->
		didOtherValidationPass = @_super()
		value = @get('formattedValue')
		pattern = /^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$/i;
		isValidEmail = (@isValueEmpty(value) or pattern.test(value))
		@addValidationError(Tent.messages.EMAIL_FORMAT_ERROR) unless isValidEmail
		@validateWarnings() if didOtherValidationPass and isValidEmail
		didOtherValidationPass && isValidEmail

	validateWarnings: ->
		@_super()

	isValueEmpty: (value) ->
		not (value? && value != '')

	# If implementing change(), make sure to call @_super
