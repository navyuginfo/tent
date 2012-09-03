require './pager'
require './sorter'
require './filter'

Tent.Data.Collection = Ember.ArrayController.extend Tent.Data.Pager, Tent.Data.Sorter, Tent.Data.Filter,
	content: null
	dataType: null
	data: []
	serverPaging: false
	liveStreaming: false
	store: null
	REQUEST_TYPE: {'ALL': 'all'}

	columnsDescriptor: (->
		@get('store').getColumnsForType(@get('dataType'))
	).property().cacheable()

	init: ->
		@_super()
		@update(@REQUEST_TYPE.ALL)

	update: (requestType)->
		if @get('dataType')? && @get('store')? 
			query = $.extend(
				{}, 
				{type: requestType}, 
				{paging: @getPagingInfo()},
				{sorting: @getSortingInfo()},
				{filtering: @getFilteringInfo()}
			)
			# Add support for asynch calls later
			response = @get('store').findQuery(eval(@get('dataType')), query)
			@set('data', response.data)
			@updatePagingInfo(response.pagingInfo)
