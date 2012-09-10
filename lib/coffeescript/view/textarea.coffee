require '../template/textarea'

Tent.Textarea = Ember.View.extend Tent.FieldSupport, Tent.TooltipSupport,
	templateName: 'textarea'
	classNames: ['tent-select', 'control-group']
	valueForMandatoryValidation: (->
		@get('formattedValue')
	).property('formattedValue')