
###*
* @class Tent.Spinner
* @extends Tent.TextField
* Usage
*       {{view Tent.Spinner label="" 
			valueBinding="" 
         }}
###

require '../template/text_field'
require '../mixin/jquery_ui'

Tent.Spinner = Tent.TextField.extend Tent.JQWidget, 
	uiType: 'spinner'
	uiOptions: ['max','min','icons','culture','disabled','incremental','numberFormat','step','page']
	classNames: ['tent-spinner']
	
	defaultOptions: 
		min: 0

	init: ->
		@_super()
	
	didInsertElement: ->
		@_super(arguments)
		@.$('input').spinner(@get('options'))
		 