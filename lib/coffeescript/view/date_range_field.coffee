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
	classNameBindings: ['allowFuzzyDates']
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

	# This control will display a range UI, so there is no need for the template to handle that.
	hasOwnRangeDisplay: true

	operators: null # We don't need operators with a date range

	###*
	* @property {Boolean} allowFuzzyDates The date input will accept free-form text and will attempt to parse that into
	* a valid date
	###
	allowFuzzyDates: false

	###*
	* @property {String} fuzzyValue This will store the fuzzy date if one is entered by the user.
	###
	fuzzyValue: null

	useFuzzyDates: false

	init: ->		 
		@_super()
	
	didInsertElement: ->
		@_super(arguments)
		widget = @
		
		@set('plugin', @$('input').daterangepicker({
				appendTo: "##{@get('elementId')}"
				presetRanges: @get('presetRanges') if @get('presetRanges')?
				presets: @get('presets') if @get('presets')?
				rangeSplitter: @get('rangeSplitter') if @get('rangeSplitter')?
				dateFormat: @get('dateFormat')
				earliestDate: @get('earliestDate') if @get('earliestDate')?
				latestDate: @get('latestDate') if @get('latestDate')?
				closeOnSelect: @get('closeOnSelect')
				arrows: @get('arrows')
				allowFuzzyDates: @get('allowFuzzyDates')
				datepickerOptions: {
					dateFormat : @get('dateFormat')
				}
				onChange: ->
					widget.change()
			})
		)
		@initializeWithStartAndEndDates()
		@listenForFuzzyCheckboxChanges()
		@listenForFuzzyDropdownChanges()
		@handleReadonly()
		@handleDisabled()
		@set('filterOp', Tent.Constants.get('OPERATOR_RANGE'))

	willDestroyElement: ->
		if not this.isDestroyed
			@$('input').remove()

	###*
	* @method getValue Return the current value of the input field
	* @return {String}
	###
	getValue: ->
		@$('.ui-rangepicker-input').val() if @$('.ui-rangepicker-input')?

	###*
	* @method setValue Set the value of the input field
	* @param {String} value
	###
	setValue: (value)->
		@$('.ui-rangepicker-input').val(value)

	initializeWithStartAndEndDates: ->
		if not @get('value')? and not @get('fuzzyValue')?
			if @get('startDate')?
				start = Tent.Formatting.date.format(@get('startDate'), @get('dateFormat'))
			if @get('endDate')?
				end = Tent.Formatting.date.format(@get('endDate'), @get('dateFormat'))
			@setValue(start + @get('rangeSplitter') + " " + end)

		if @get('fuzzyValue')?
			dateRange = @getDateFromFuzzyValue(@get('fuzzyValue'))
			@set('value', dateRange)
			@set('dateValue', dateRange)
			@setFuzzyCheck(true)
			originalFuzzyValue = @get('fuzzyValue')
			@set('useFuzzyDates', true)
			@set('fuzzyValueTemp', originalFuzzyValue)
			@set('formattedValue', @get('fuzzyValueTemp'))
		else
			@setFuzzyCheck(false)

	setFuzzyCheck: (isChecked)->
		@$('.useFuzzy').prop('checked', isChecked)

	getDateFromFuzzyValue: (fuzzy)->
		# get presets
		# find the one that applies
		# evaluate start and end date and copy to value

		ranges = @get('plugin.options.presetRanges')

		presetArr = ranges.filter (item) =>
			item.text.replace(/\ /g, "") == fuzzy

		if presetArr.length > 0
			preset = presetArr[0]
			start = if typeof preset.dateStart == 'string' then Date.parse(preset.dateStart) else preset.dateStart()
			formattedStart = Tent.Formatting.date.format(start, @get('dateFormat'))
			end = if typeof preset.dateEnd == 'string' then Date.parse(preset.dateEnd) else preset.dateEnd()
			formattedEnd = Tent.Formatting.date.format(end, @get('dateFormat'))
			(formattedStart + @get('rangeSplitter') + " " + formattedEnd)
		else
			# If not a fuzzy value, just return the original value, which may be a valid date range
			fuzzy

	placeholder: (->
		@get('dateFormat') + @get('rangeSplitter') + " " + @get('dateFormat')
	).property('dateFormat')

	change: (e)->
		if e? and not $(e.originalTarget).is('.useFuzzy')
			return
		@set('dateValue', @getValue())
		@set("formattedValue", @format(@getValue()))
		@set('isValid', @validate())
		if @get('isValid')
			unformatted = @unFormat(@get('formattedValue'))
			@set('formattedValue', @format(unformatted))
			@set('value', @convertSingleDateToDateRange(unformatted))
 
	listenForFuzzyDropdownChanges: ->
		@$('.ui-daterangepickercontain li').click (e) =>
			@setFuzzyValueFromSelectedPreset(e)

	setFuzzyValueFromSelectedPreset: (e) ->
		if @get('allowFuzzyDates')
			li = $(e.currentTarget)
			if @presetIsFuzzy(li)
				@enableCheckbox()
				classes = li.attr('class').split(' ')
				presetArr = classes.find((item)->
					if item.split('ui-daterangepicker-').length > 1 then true else false
				)
				fValue = presetArr.split('ui-daterangepicker-')[1]
				@set('fuzzyValueTemp', fValue)
			else
				@disableCheckbox()
				@setCheckValue(false)
				@set('useFuzzyDates', false)
		else
			@set('fuzzyValue', null)

	presetIsFuzzy: (li)->
		li.attr('class').indexOf('preset_') == -1

	listenForFuzzyCheckboxChanges: ->
		_this = this;
		@$('.useFuzzy').click (e) =>
			@checkWasClicked()

	setCheckValue: (value) ->
		@$('.useFuzzy').prop('checked', value)

	enableCheckbox: ->
		@$('.useFuzzy').prop('disabled', false)

	disableCheckbox: ->
		@$('.useFuzzy').prop('disabled', true)

	checkWasClicked: ->
		#Using toggleProperty causes issues with rendering of the checkbox for some reason
		if @get('useFuzzyDates')
			@set('useFuzzyDates', false)
		else
			@set('useFuzzyDates', true)

	fuzzyValueDidChange: (->
		if @get('allowFuzzyDates') and @get('useFuzzyDates')
			@set('fuzzyValue', @get('fuzzyValueTemp'))
			@set('formattedValue', @get('fuzzyValueTemp'))
		else
			@set('fuzzyValue', null)
			@set('formattedValue', @getDateFromFuzzyValue(@get('dateValue')))
	).observes('fuzzyValueTemp','useFuzzyDates')

	focusOut: ->
		# override the default behavior for textfields, since we do not want to validate
		# for just interacting with the dropdown.

	convertSingleDateToDateRange: (date)->
		if (date.indexOf(",") == -1)
			date += ",#{date}"
		date

	validate: ->
		isValid = @_super()
		isValidStartDate = isValidEndDate = true
		if @get('formattedValue')? and @get('formattedValue') != "" and @getValue()?
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
			@$('.ui-rangepicker-input').bind('click', @get('readOnlyHandler'))
			@$('.ui-daterangepicker-prev, .ui-daterangepicker-next').css("visibility", "hidden")
		else 
			@$('.ui-rangepicker-input, .ui-daterangepicker-prev, .ui-daterangepicker-next').unbind('click', @get('readOnlyHandler'))
			@$('.ui-daterangepicker-prev, .ui-daterangepicker-next').css("visibility", "visible")
	).observes('readOnly')

	handleDisabled: (->
		if @$()?
			if @get('disabled')? && @get('disabled')
				@.$('.ui-daterangepicker-prev, .ui-daterangepicker-next').css("visibility", "hidden")
			else 
				@.$('.ui-daterangepicker-prev, .ui-daterangepicker-next').css("visibility", "visible")
	).observes('disabled')

		 
