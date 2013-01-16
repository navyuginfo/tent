#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
 * @class Tent.FormattingSupport 
 * Allows the 'value' property of the view to be bound to a controller while
 * displaying the 'formattedValue' in the DOM
 * The format() and unFormat() methods, which should be overridedn by your view class, 
 * define the data transformation between the value and formatted value
 * Note that all validation will be executed against the 'value' property  
###

Tent.FormattingSupport = Ember.Mixin.create
	init: ->
		@_super()
		@set('formattedValue', @format(@get('value')))

	valueDidChange: (->
		@set("formattedValue", @format(@get('value')))
		@set('isValid', @validate())
	).observes('value')

	format: (value)->
		value

	unFormat: (value) ->
		value

	