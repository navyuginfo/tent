#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../mixin/field_support'
require '../mixin/formatting_support'
require '../template/text_field'

Tent.TextField = Ember.View.extend Tent.FieldSupport, Tent.FormattingSupport,
	templateName: 'text_field'
	classNames: ['tent-text-field', 'control-group']
	
	change: ->
		alert("TextField: " + @get('value'))