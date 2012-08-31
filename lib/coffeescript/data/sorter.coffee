Tent.Data.Sorter = Ember.Mixin.create
	init: ->
		@_super()
		@REQUEST_TYPE.SORT = 'sorting'


	sort: (args) ->
		@set('sortFields', args)
		@update(@REQUEST_TYPE.SORT)

	getSortingInfo: ->
		@get('sortFields')