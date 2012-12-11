###*
* @class Tent.DateRangeField
* @extends Tent.TextField
* Usage
*       {{view Tent.DateRangeField label="" 
			valueBinding="" 
			startDateBinding=""
			endDateBinding=""
			showOtherMonths=true  
			dateFormat=""
         }}
###

require '../template/text_field'
require '../mixin/jquery_ui'

Tent.DateRangeField = Tent.TextField.extend
	classNames: ['tent-date-range-field']
	###*
	* @property {Array} presetRanges Array of objects to be made into menu range presets
	###
	presetRanges: []
	###*
	* @property {String} rangeSplitter The character to use between two dates in the range
	###
	rangeSplitter: '-'

	###*
	* @property {Date} startDate The selected start date in the range
	###
	startDate: null

	###*
	* @property {Date} endDate The selected end date in the range
	###
	endDate: null

	###*
	* @property {String} dateFormat The expected format for each date in the range
	###
	dateFormat: Tent.Formatting.date.getFormat()

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

	###*
	* @method getValue Return the current value of the input field
	* @return {String}
	###
	getValue: ->
		@.$('input').val()

	###*
	* @method setValue Set the value of the input field
	* @param {String} value
	###
	setValue: (value)->
		@.$('input').val(value)

	initializeWithStartAndEndDates: ->
		if not @get('value')?
			if @get('startDate')?
				start = Tent.Formatting.date.format(@get('startDate'), @get('dateFormat'))
			if @get('endDate')?
				end = Tent.Formatting.date.format(@get('endDate'), @get('dateFormat'))
			@setValue(start + " " + @get('rangeSplitter') + " " + end)

	placeholder: (->
		@get('dateFormat') + " " + @get('rangeSplitter') + " " + @get('dateFormat')
	).property('dateFormat')

	change: ->
		@set("formattedValue", @format(@getValue()))
		@set('isValid', @validate())
		if @get('isValid')
			unformatted = @unFormat(@get('formattedValue'))
			@set('value', unformatted)
			@set('formattedValue', @format(unformatted))
			@setStartDate()
			@setEndDate()

	setStartDate: ->
		startString = @getValue().split(@get('rangeSplitter'))[0]
		if startString
			@set('startDate', Tent.Formatting.date.unformat(startString.trim(), @get('dateFormat')))

	setEndDate: ->
		endString = @getValue().split(@get('rangeSplitter'))[1]
		if endString?
			@set('endDate', Tent.Formatting.date.unformat(endString.trim(), @get('dateFormat')))

	#Format for display
	format: (value)->
		value

	# Format for binding
	unFormat: (value)->
		value

	handleReadonly: (->
		#if @get('readOnly')

	).observes('readOnly')

		 
