#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
* @class Tent.EmailField
* @extends Tent.TextField
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
		didOtherValidationPass && isValidEmail

	isValueEmpty: (value) ->
		not (value? && value != '')

	# If implementing change(), make sure to call @_super
