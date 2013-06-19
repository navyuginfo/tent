###*
* @class Tent.DateRangeField
* @extends Tent.TextField
* 
* This widget wraps the Filament Date Range Picker control. The selected value will consist of
* two dates which are bound to the {@link #startDate} and {@link #endDate} properties. 
* The {@link #value} property is also bound with the string value of the range, as seen in the 
* input control ('date1 - date2').
*
* The initial value can be sourced from the value property if provided. If no value is provided,
* then the startDate and endDate properties will be used to initialize the control.
* 
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
require '../mixin/constants'

Tent.DateRangeField = Tent.TextField.extend
	classNames: ['tent-date-range-field']
	###*
	* @property {Array} presetRanges Array of objects to be made into menu range presets. 
	* 
	* Each object requires 3 properties:
	* - text: string, text for menu item
	* - dateStart: date.js string, or function which returns a date object, start of date range
	* - dateEnd: date.js string, or function which returns a date object, end of date range
	###
	presetRanges: null

	###*
	* @property {Array} 
	* Available options are: 
	* - 'specificDate'
	* - 'allDatesBefore'
	* - 'allDatesAfter'
	* - 'dateRange'. 
	*
	* Each can be passed a string for link and label text. (example: presets: {specificDate: 'Pick a date'} )
	###
	presets: null
	
	###*
	* @property {String} rangeSplitter The character to use between two dates in the range
	###
	rangeSplitter: ','

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

	operators: null # We don't need operators with a date range

	init: ->		 
		@_super()
	
	didInsertElement: ->
		@_super(arguments)
		widget = @
		@initializeWithStartAndEndDates()
		@.$('input').daterangepicker({
			presetRanges: @get('presetRanges') if @get('presetRanges')?
			presets: @get('presets') if @get('presets')?
			rangeSplitter: @get('rangeSplitter') if @get('rangeSplitter')?
			dateFormat: @get('dateFormat')
			earliestDate: @get('earliestDate') if @get('earliestDate')?
			latestDate: @get('latestDate') if @get('latestDate')?
			closeOnSelect: @get('closeOnSelect')
			arrows: @get('arrows')
			datepickerOptions: {
				dateFormat : @get('dateFormat')
			}
			onChange: ->
				widget.change()
		})
		@handleReadonly()
		@handleDisabled()
		@set('filterOp', Tent.Constants.get('OPERATOR_RANGE'))

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

	validate: ->
		isValid = @_super()
		isValidStartDate = isValidEndDate = true
		if @get('formattedValue')? and @get('formattedValue')!=""
			startString = @getValue().split(@get('rangeSplitter'))[0]
			if startString?
				try 
					startDate = Tent.Formatting.date.unformat(startString.trim(), @get('dateFormat'))
					@set('startDate', startDate)
				catch e
					isValidStartDate = false
					@set('startDate', null)

			endString = @getValue().split(@get('rangeSplitter'))[1]
			if endString?
			  try
			   endDate = Tent.Formatting.date.unformat(endString.trim(), @get('dateFormat'))
			   @set('endDate', endDate)
			  catch e
			   isValidEndDate = false
			   @set('endDate', null)
			else
			  @set('endDate', @get('startDate'))
			  

		@addValidationError(Tent.messages.DATE_FORMAT_ERROR) unless (isValidStartDate and isValidEndDate)
		@validateWarnings() if (isValid and isValidStartDate and isValidEndDate)
		isValid && isValidStartDate && isValidEndDate

	validateWarnings: ->
		@_super()

	#Format for display
	format: (value)->
		value

	# Format for binding
	unFormat: (value)->
		value

	readOnlyHandler: (e)->
		e.preventDefault()
		e.stopPropagation()
		$('.ui-daterangepicker').hide()
		return false
	
	handleReadonly: (->
		if @get('readOnly')? && @get('readOnly')
			@.$('input').bind('click', @get('readOnlyHandler'))
			@.$('.ui-daterangepicker-prev, .ui-daterangepicker-next').css("visibility", "hidden")
		else 
			@.$('input, .ui-daterangepicker-prev, .ui-daterangepicker-next').unbind('click', @get('readOnlyHandler'))
			@.$('.ui-daterangepicker-prev, .ui-daterangepicker-next').css("visibility", "visible")
	).observes('readOnly')

	handleDisabled: (->
		if @get('disabled')? && @get('disabled')
			@.$('.ui-daterangepicker-prev, .ui-daterangepicker-next').css("visibility", "hidden")
		else 
			@.$('.ui-daterangepicker-prev, .ui-daterangepicker-next').css("visibility", "visible")
	).observes('disabled')

		 
