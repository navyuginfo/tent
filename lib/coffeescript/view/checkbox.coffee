#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../mixin/field_support'
require '../template/checkbox'

Tent.Checkbox = Ember.View.extend Tent.FieldSupport,
	templateName: 'checkbox'
	classNames: ['tent-checkbox', 'control-group']

	change: ->
		@_super(arguments)
		@set('isValid', @validate())

	  # A widget is expected to have a formatted value to apply to validation checks etc
	formattedValue: (->
		return @get('checked')
	).property('checked')