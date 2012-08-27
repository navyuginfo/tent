require '../template/text_field'
require '../mixin/jquery_ui'
require "vendor/scripts/jquery-ui-1.8.16.custom.min"

Tent.DateField = Tent.TextField.extend Tent.JQWidget,
	uiType: 'datepicker'
	uiOptions: ['dateFormat', 'changeMonth', 'changeYear', 
		'minDate', 'maxDate', 'showButtonPanel', 'showOtherMonths',
		'selectOtherMonths', 'showWeek', 'firstDay', 'numberOfMonths', 
		'showOn', 'buttonImage', 'showAnim'
	]
	classNames: ['tent-date-field']

	defaultOptions: 
		dateFormat: "mm/dd/yy"
		changeMonth: true
		changeYear: true
		showOn: "both"
		buttonImage: "images/calendar.gif"
		buttonImageOnly: true

	init: ->		 
		@_super()
	
	didInsertElement: ->
		@_super()
		@.$('input').datepicker(@get('options'))
	
	#gatherOptions: ->
	#	@set('options', $.extend({}, @get('defaultOptions'), @get('options')))

	validate: ->
		isValid = @_super()
		isValidDate = true
		try
			@unFormat(@get('formattedValue'))
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

		 