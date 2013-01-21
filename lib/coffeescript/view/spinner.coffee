
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
  To put restrictions on that use custom validation: valueBetween
			  {{view Tent.Spinner label="" 
						valueBinding="" 
						minBinding="" 
						maxBinding="" 
						validations="valueBetween"
			      validationOptions="{valueBetween:{min:2, max:20}}"}}
  To restrict only one min/max value, give the other as null   
  			eg: validationOptions = "{valueBetween:{min:null, max:20}}"
###

require '../template/text_field'
require '../mixin/jquery_ui'

Tent.Spinner = Tent.NumericTextField.extend Tent.JQWidget, 
	uiType: 'spinner'
	uiEvents: ['change']
	uiOptions: ['max','min','icons','culture','disabled','incremental','numberFormat','step','page']
	classNames: ['tent-spinner']
	
	defaultOptions: 
		min: 0
		change: @change

	init: ->
		@_super()
	
	didInsertElement: ->
		@_super(arguments)
		@.$('input').spinner(@get('options'))

	#add other options in this as and when required
	optionsDidChange: (->
		@.$('input').spinner({'min':@get('min')}) if @get('min')
		@.$('input').spinner({'max':@get('max')}) if @get('max')
		if @get('disabled') or @get('isReadOnly') or @get('readOnly')
			@.$('input').spinner('disable')
		else
			@.$('input').spinner('enable')
	).observes('min','max','disabled', 'readOnly', 'isReadOnly')

	change: (event,ui)->
		@set 'value', @.$('input').spinner('value')