
###*
* @class Tent.Spinner
* @extends Tent.TextField
* Usage
*       {{view Tent.Spinner label="" 
			valueBinding="" minBinding=""
         }}
###

require '../template/text_field'
require '../mixin/jquery_ui'

Tent.Spinner = Tent.NumericTextField.extend Tent.JQWidget, 
	uiType: 'spinner'
	uiEvents: ['stop']
	uiOptions: ['max','min','icons','culture','disabled','incremental','numberFormat','step','page']
	classNames: ['tent-spinner']
	
	defaultOptions: 
		min: 0
		stop: @stop

	init: ->
		@_super()
	
	didInsertElement: ->
		@_super(arguments)
		@.$('input').spinner(@get('options'))

	#add other options in this as and when required
	optionsDidChange: (->
		if @get('min')
			@.$('input').spinner({'min':@get('min')})
	).observes('min')

	validate: ->
		isValid = @_super()
		isValidValue = true
		# try
		# 	isValidValue = !(@get('options').min > @get('value') )
		# catch e
		# 	isValidValue = false
		# @addValidationError(Tent.messages.MIN_VALUE_ERROR) unless isValidValue
		isValid && isValidValue

	stop: (event,ui)->
		@set 'value', @.$('input').spinner('value')