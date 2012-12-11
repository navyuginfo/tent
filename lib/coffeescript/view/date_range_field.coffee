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
	startDate: null
	endDate: null


	init: ->		 
		@_super()
	
	didInsertElement: ->
		@_super(arguments)
		widget = @
		@initializeWithStartAndEndDates()
		@.$('input').daterangepicker({
			onChange: ->
				widget.change()
		})

	getValue: ->
		@.$('input').val()

	setValue: (value)->
		@.$('input').val(value)

	initializeWithStartAndEndDates: ->
		if not @get('value')?
			if @get('startDate')?
				start = Tent.Formatting.date.format(@get('startDate'), @get('dateFormat'))
			if @get('endDate')?
				end = Tent.Formatting.date.format(@get('endDate'), @get('dateFormat'))
			@setValue(start + @get('rangeSplitter') + end)

	change: ->
		#@_super(arguments)
		@set("formattedValue", @format(@getValue()))
		@set('isValid', @validate())
		if @get('isValid')
			unformatted = @unFormat(@get('formattedValue'))
			@set('value', unformatted)
			@set('formattedValue', @format(unformatted))
			@setStartDate()
			@setEndDate()

	setStartDate: ->
		startString = @getValue().split(@get('rangeSplitter'))[0].trim()
		@set('startDate', Tent.Formatting.date.unformat(startString, @get('dateFormat')))

	setEndDate: ->
		endString = @getValue().split(@get('rangeSplitter'))[1].trim()
		@set('endDate', Tent.Formatting.date.unformat(endString, @get('dateFormat')))

	#Format for display
	format: (value)->
		value

	# Format for binding
	unFormat: (value)->
		value
		 
