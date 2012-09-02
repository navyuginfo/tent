Tent.Data.Filter = Ember.Mixin.create
	init: ->
		@_super()
		@REQUEST_TYPE.FILTER = 'filtering'

	filter: (columnFilters) ->
		@set('columnFilters', columnFilters)
		@update(@REQUEST_TYPE.FILTER)

	getFilteringInfo: ->
		@get('columnFilters')