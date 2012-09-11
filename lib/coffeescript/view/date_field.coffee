require '../template/text_field'
require '../mixin/jquery_ui'
require '../mixin/tooltip_support'

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

	defaultOptions: 
		dateFormat: "mm/dd/yy"
		changeMonth: true
		changeYear: true
		showOn: "button"
		buttonImage: "stylesheet/images/calendar.gif"
		buttonImageOnly: true

	init: ->		 
		@_super()
	
	didInsertElement: ->
		@_super()
		@.$('input').datepicker(@get('options'))

	optionDidChange: (->
		#@set('options', @_gatherOptions())
		if @get('disabled') or @get('isReadOnly') or @get('readOnly')
			@.$('input').datepicker('disable')
		else
			@.$('input').datepicker('enable')
	).observes('disabled', 'readOnly', 'isReadOnly')
	
	change: ->
    	@_super()
    	@set('isValid', @validate())

	validate: ->
		isValid = @_super()
		isValidDate = true
		try
			isValidDate = (@get("formattedValue")=="") or $.datepicker.parseDate(@get('options').dateFormat, @get("formattedValue"))
		catch e
			isValidDate = false
		@addValidationError(Tent.messages.DATE_FORMAT_ERROR) unless isValidDate
		isValid && isValidDate

	#Format for display
	format: (value)->
		$.datepicker.formatDate(@get('options').dateFormat, value)

	# Format for binding
	unFormat: (value)->
		try 
			$.datepicker.parseDate(@get('options').dateFormat, value)
		catch error
			return null

		 