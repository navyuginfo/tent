require './mixins/pager'
require './mixins/sorter'
require './mixins/filter'

Tent.Data.Collection = Ember.ArrayController.extend Tent.Data.Pager, Tent.Data.Sorter, Tent.Data.Filter,
	content: null
	dataType: null
	data: []
	serverPaging: false
	liveStreaming: false
	store: null
	REQUEST_TYPE: {'ALL': 'all'}

	# This is currently returning a plain array of the stripped down model (only displayed columns are included)
	dataChanged: (->
		@set('content', @get('gridData'))
	).observes('modelData')

	# Convert Ember model to deep Object
	# maybe move this into the SlickGrid
	gridData: (->
		grid = []
		for model in @get('modelData')
			item = {"id" : model.get('id')}
			for column in @get('columnsDescriptor')
				item[column.field] = model.get(column.field)
			grid.push(item)
		return grid
	).property('modelData')

	columnsDescriptor: (->
		@get('store').getColumnsForType(@get('dataType'))
	).property('dataType').cacheable()

	availableFilters: (->
		[
			{
				name: "task1"
				label: "Task 1"
				description: "..."
				values: {id: "51", title: "Task 1"}
			},
			{
				name: "task2"
				label: "Task 2"
				description: "..."
				values: {id: "52", title: "Task 2"}
			}
		]

	).property()

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
			@set('modelData', response.modelData)
			@updatePagingInfo(response.pagingInfo)
