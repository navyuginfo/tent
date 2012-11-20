###*
* @class Tent.Data.SearchSupport
* Adds full text search support
###
Tent.Data.SearchSupport = Ember.Mixin.create
	
	init: ->
		@_super()
		@REQUEST_TYPE.SEARCH = 'searching'

	###*
	* @method search Perform a full-text search
	* @param {String} searchText the text to use for the search
	###
	search: (searchText)->
		@set('searchingInfo', searchText)
		console.log 'Adding full text search  [' + searchText + ']'
		@update(@REQUEST_TYPE.SEARCH)

	getSearchingInfo: ->
		@get('searchingInfo')