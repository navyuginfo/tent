###*
* @class Tent.Data.Sorter
* Adds sorting support
###
Tent.Data.Sorter = Ember.Mixin.create
	columnFilters: {}
	
	init: ->
		@_super()
		@REQUEST_TYPE.SORT = 'sorting'

	###*
	* @method sort Sort the collection according to the sort fields provided
	* @param {Object} sortFields An object defining the fields and sort order
	###
	sort: (sortFields) ->
		@set('sortFields', sortFields)
		@update(@REQUEST_TYPE.SORT)

	getSortingInfo: ->
		@get('sortFields')