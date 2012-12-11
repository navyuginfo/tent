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
	* @property {Date} earliestDate The earliest date allowed in the system. e.g. the 'All Dates Before'
	* range will use this as the first date in the range 
	###
	earliestDate: null

	###*
	* @property {Date} latestDate The latest date allowed in the system. e.g. the 'All Dates After'
	* range will use this as the last date in the range 
	###
	latestDate: null

	###*
	* @property {Boolean} closeOnSelect will close the rangepicker when a full range is selected
	###
	closeOnSelect: false

	###*
	* @property {Boolean} arrows will add date range advancing arrows to input.
	###
	arrows: false

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
			rangeSplitter: @get('rangeSplitter') if @get('rangeSplitter')?
			dateFormat: @get('dateFormat')
			earliestDate: @get('earliestDate') if @get('earliestDate')?
			latestDate: @get('latestDate') if @get('latestDate')?
			closeOnSelect: @get('closeOnSelect')
			arrows: @get('arrows')
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

		 
