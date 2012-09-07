#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../mixin/field_support'
require '../mixin/formatting_support'
require '../mixin/tooltip_support'
require '../template/text_field'

Tent.TextField = Ember.View.extend Tent.FormattingSupport, Tent.FieldSupport, Tent.TooltipSupport,
	templateName: 'text_field'
	classNames: ['tent-text-field', 'control-group']
	valueForMandatoryValidation: (->
		@get('formattedValue')
	).property('formattedValue')
	
	change: ->
		@_super()
		@set('isValid', @validate())
		if @get('isValid')
			unformatted = @unFormat(@get('formattedValue'))
			@set('value', unformatted)
			@set('formattedValue', @format(unformatted))