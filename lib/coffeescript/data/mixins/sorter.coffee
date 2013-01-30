Tent.Data.Sorter = Ember.Mixin.create
	columnFilters: {}
	sortingInfo: {}
	init: ->
		@_super()
		@REQUEST_TYPE.SORT = 'sorting'


	sort: (args) ->
		@set('sortingInfo', args)
		@update(@REQUEST_TYPE.SORT)

	getSortingInfo: ->
		@get('sortingInfo')