require '../template/text_field'
require '../mixin/jquery_ui'
require "vendor/scripts/jquery-ui-1.8.16.custom.min"

Tent.DateField = Tent.TextField.extend Tent.JQWidget, Tent.FormattingSupport,
	uiType: 'datepicker'
	uiOptions: ['changeMonth', 'changeYear', 
		'minDate', 'maxDate', 'showButtonPanel', 'showOtherMonths'
		'selectOtherMonths', 'showWeek', 'firstDay', 'numberOfMonths', 
		'showOn', 'buttonImage', 'showAnim'
	]
	classNames: ['tent-date-field']

	defaultOptions: 
		changeMonth: true
		changeYear: true
		showOn: "both"
		buttonImage: "images/calendar.gif"
		buttonImageOnly: true
	
	didInsertElement: ->
		@_super()
		@.$('input').datepicker(@gatherOptions())
	
	gatherOptions: ->
		$.extend({}, @get('defaultOptions'), @get('options'))