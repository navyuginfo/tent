
###*
* @class Tent.DateField
* @extends Tent.TextField
* Usage
*       {{view Tent.DateField label="" 
			valueBinding="" 
			showOtherMonths=true  
			dateFormat=""
				 }}
###

require '../template/text_field'
require '../mixin/jquery_ui'

Tent.DateField = Tent.TextField.extend Tent.JQWidget, 
	###*
	* @property {Boolean} allowFuzzyDates The date input will accept free-form text and will attempt to parse that into
	* a valid date
	###
	allowFuzzyDates: false
	###*
	* @property {String} fuzzyDate This will store the fuzzy date if one is entered by the user.
	###
	fuzzyDate: null
	useFontIcon: true
	fontIconClass: 'icon-calendar'
	hasParsedValue: false

	uiType: 'datepicker'
	uiOptions: ['dateFormat', 'changeMonth', 'changeYear', 
		'minDate', 'maxDate', 'showButtonPanel', 'showOtherMonths',
		'selectOtherMonths', 'showWeek', 'firstDay', 'numberOfMonths', 
		'showOn', 'buttonImage', 'buttonImageOnly', 'showAnim', 'disabled', 'constrainInput'
	]
	classNames: ['tent-date-field']
	
	placeholder: (->
		@get('options').dateFormat
	).property('options.dateFormat')

	dateFormatDidChange: (->
		@set('options.dateFormat', @get('dateFormat'))
	).observes('dateFormat')

	valueForMandatoryValidation: (->
		@get('formattedValue')
	).property('formattedValue')

	defaultOptions: 
		dateFormat: Tent.Formatting.date.getFormat()
		changeMonth: true
		changeYear: true
		showOn: "button"
		buttonImage: "stylesheet/images/calendar.gif"
		buttonImageOnly: false

	optionDidChange: (->
		#@set('options', @_gatherOptions())
		if @get('disabled') or @get('isReadOnly') or @get('readOnly')
			@$().datepicker('disable')
		else
			@$().datepicker('enable')
	).observes('disabled', 'readOnly', 'isReadOnly')

	init: ->
		@_super()
		if @get('allowFuzzyDates') and @isFuzzyDate(@get('fuzzyValue'))
			@set('formattedValue', @get('fuzzyValue'))
			@change()
	
	change: ->
		@set('hasParsedValue', false)
		@set('fuzzyValue', null)
		@validateField()

	didInsertElement: ->
		@_super(arguments)
		@set('options.constrainInput', false) if @get('allowFuzzyDates')
		@.$('input').datepicker(@get('options'))
		if @get('useFontIcon')
			@.$('.ui-datepicker-trigger').html('<i class="' + @get('fontIconClass') + '"></i>')

	validate: ->
		isValid = @_super()
		isValidDate = @isDateValid(@get("formattedValue")) or @convertFuzzyDate(@get("formattedValue"))
		@addValidationError(Tent.messages.DATE_FORMAT_ERROR) unless isValidDate
		@validateWarnings() if isValid 
		isValid && isValidDate

	isDateValid: (dateString)->
		valid = true
		try
			$.datepicker.parseDate(@get('options.dateFormat'), dateString)
		catch e
			valid = false
		return valid or (dateString=="")

	convertFuzzyDate: (date)->
		if @get('allowFuzzyDates') and @isFuzzyDate(date)
			@set('formattedValue', @format(@parseFuzzyDate(date)))
			@set('fuzzyValue', date)
			@set('hasParsedValue', true)
			@set('parsedValue', date)
			return true
		else
			@set('hasParsedValue', false)
			return false

	isFuzzyDate: (date) ->
		!!@parseFuzzyDate(date)

	parseFuzzyDate: (date) ->
		Date.parse(date)

	validateWarnings: ->
		@_super()

	#Format for display
	format: (value)->
		Tent.Formatting.date.format(value, @get('options.dateFormat'))

	# Format for binding
	unFormat: (value)->
		try 
			if @isDateValid(value)
				Tent.Formatting.date.unformat(value, @get('options.dateFormat'))
			else
				Tent.Formatting.date.unformat(@parseFuzzyDate(value), @get('options.dateFormat'))
		catch error
			return null

	# Focusing out of a date field will auto-fill the current date to avoid multiple validation errors
	focusOut: ->
		field = @$('input.primary-class').val()
		if !field or field == '' or field == @get('translatedPlaceholder')
			today = @format(new Date())
			@.$('input.primary-class').val(today)
			@set('formattedValue', today)
		@validateField()
		 
