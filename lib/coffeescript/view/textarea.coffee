require '../template/textarea'
require '../mixin/readonly_support'

Tent.Textarea = Ember.View.extend Tent.FormattingSupport, Tent.FieldSupport, Tent.TooltipSupport,
	templateName: 'textarea'
	classNames: ['tent-textarea', 'control-group']
	valueForMandatoryValidation: (->
		@get('formattedValue')
	).property('formattedValue')

	change: ->
		@_super(arguments)
		@set('isValid', @validate())
		if @get('isValid')
			unformatted = @unFormat(@get('formattedValue'))
			@set('value', unformatted)
			@set('formattedValue', @format(unformatted))

Tent.TextareaInput = Ember.TextArea.extend Tent.AriaSupport, Tent.Html5Support, Tent.ReadonlySupport, Tent.DisabledSupport