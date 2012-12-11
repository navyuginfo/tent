###*
* @class Tent.DateRangeField
* @extends Tent.TextField
* Usage
*       {{view Tent.DateRangeField label="" 
			valueBinding="" 
			showOtherMonths=true  
			dateFormat=""
         }}
###

require '../template/text_field'
require '../mixin/jquery_ui'

Tent.DateRangeField = Tent.TextField.extend
	classNames: ['tent-date-range-field']
	presetRanges: []
	rangeSplitter: '-'

	init: ->		 
		@_super()
	
	didInsertElement: ->
		@_super(arguments)
		widget = @
		@.$('input').daterangepicker({
			onChange: ->
				widget.change()
		})

	getValue: ->
		@.$('input').val()

	change: ->
		#@_super(arguments)
		@set("formattedValue", @format(@getValue()))
		@set('isValid', @validate())
		if @get('isValid')
			unformatted = @unFormat(@get('formattedValue'))
			@set('value', unformatted)
			@set('formattedValue', @format(unformatted))

	#Format for display
	format: (value)->
		value
		#Tent.Formatting.date.format(value, @get('dateFormat'))

	# Format for binding
	unFormat: (value)->
		value
		###startString = value.split(@get('rangeSplitter'))[0]
		endString = value.split(@get('rangeSplitter'))[1]
		@set('startDate', Tent.Formatting.date.unformat(value, @get('dateFormat'))
		try 
			Tent.Formatting.date.unformat(value, @get('dateFormat'))
		catch error
			return null
		###
