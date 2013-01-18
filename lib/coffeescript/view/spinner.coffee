
###*
* @class Tent.Spinner
* @extends Tent.TextField
* Usage
*       {{view Tent.Spinner label="" 
					valueBinding="" 
					minBinding="" 
					maxBinding=""
         }}
  value can be entered maually in the spinner. 
  To put restrictions on that use custom validations: minValue and maxValue
			  {{view Tent.Spinner label="" 
						valueBinding="" minBinding="" 
						maxBinding="" 
						validations="minValue"
			      validationOptions="{minValue:{min:2}}"}}
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
		@.$('input').spinner({'min':@get('min')}) if @get('min')
		@.$('input').spinner({'max':@get('max')}) if @get('max')
	).observes('min','max')

	stop: (event,ui)->
		@set 'value', @.$('input').spinner('value')