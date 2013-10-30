
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
	uiType: 'datepicker'
	uiOptions: ['dateFormat', 'changeMonth', 'changeYear', 
		'minDate', 'maxDate', 'showButtonPanel', 'showOtherMonths',
		'selectOtherMonths', 'showWeek', 'firstDay', 'numberOfMonths', 
		'showOn', 'buttonImage', 'buttonImageOnly', 'showAnim', 'disabled'
	]
	classNames: ['tent-date-field']
	
	placeholder: (->
		@get('options').dateFormat
	).property('options.dateFormat')

	valueForMandatoryValidation: (->
		@get('formattedValue')
	).property('formattedValue')

	tooltipT: (->
		toolTip = Tent.I18n.loc(@get('tooltip'))
		if Tent.Browsers.isIE()
			toolTip + ' - ' + @get('placeholder')
		else
			toolTip
	).property('tooltip', 'placeholder')

	defaultOptions: 
		dateFormat: Tent.Formatting.date.getFormat()
		changeMonth: true
		changeYear: true
		showOn: "button"
		buttonImage: "stylesheet/images/calendar.gif"
		buttonImageOnly: true

	optionDidChange: (->
		#@set('options', @_gatherOptions())
		if @get('disabled') or @get('isReadOnly') or @get('readOnly')
			@$().datepicker('disable')
		else
			@$().datepicker('enable')
	).observes('disabled', 'readOnly', 'isReadOnly')

	init: ->
		@_super()
	
	didInsertElement: ->
		@_super(arguments)
		@.$('input').datepicker(@get('options'))

	validate: ->
		isValid = @_super()
		isValidDate = true
		try
			isValidDate = (@get("formattedValue")=="") or $.datepicker.parseDate(@get('options').dateFormat, @get("formattedValue"))
		catch e
			isValidDate = false
		@addValidationError(Tent.messages.DATE_FORMAT_ERROR) unless isValidDate
		@validateWarnings() if isValid and isValidDate
		isValid && isValidDate

	validateWarnings: ->
		@_super()

	#Format for display
	format: (value)->
		Tent.Formatting.date.format(value, @get('dateFormat'))

	# Format for binding
	unFormat: (value)->
		try 
			Tent.Formatting.date.unformat(value, @get('dateFormat'))
		catch error
			return null

	# Focusing out of a date field will auto-fill the current date to avoid multiple validation errors
	focusOut: ->
		field = @$('input').val()
		if !field or field == ''
      			today = @format(new Date())
      			@.$('input').val(today)
      			@set('formattedValue', today)
		@validateField()

	change: ->
	    @validateField()

		 
