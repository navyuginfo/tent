#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../mixin/field_support'
require '../mixin/formatting_support'
require '../mixin/tooltip_support'
require '../mixin/aria_support'
require '../mixin/html5_support'
require '../template/text_field'

Tent.TextField = Ember.View.extend Tent.FieldSupport, Tent.FormattingSupport, Tent.TooltipSupport,
	templateName: 'text_field'
	classNames: ['tent-text-field', 'control-group']

	valueForMandatoryValidation: (->
		@get('value')
	).property('value')
	
	change: ->
    	@_super()
    	@set('isValid', @validate())

Tent.TextFieldInput = Ember.TextField.extend Tent.AriaSupport, Tent.Html5Support
	