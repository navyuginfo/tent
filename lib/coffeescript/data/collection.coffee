
require './mixins/pager'
require './mixins/sorter'
require './mixins/columninfo'
require './mixins/filter'
require './mixins/grouper'
require './mixins/search_support'
require './mixins/export_support'
require './mixins/customizable'

###*
* @class Tent.Data.Collection
* An object used to wrap an array of objects, with a facade for paging, sorting and filtering, 
###
Tent.Data.Collection = Ember.ArrayController.extend Tent.Data.Pager, Tent.Data.Sorter, Tent.Data.ColumnInfo, Tent.Data.Filter, Tent.Data.ExportSupport, Tent.Data.Customizable, Tent.Data.SearchSupport, Tent.Data.ExportSupport, Tent.Data.Grouper,
	content: null
	dataType: null
	data: []
	serverPaging: false
	liveStreaming: false
	store: null
	personalizable: true

	isLoadable: false #Does the collection have a 'isLoaded' state
	REQUEST_TYPE: {'ALL': 'all'}

	# This is currently returning a plain array of the stripped down model (only displayed columns are included)
	dataChanged: (->
		@set('content', @get('gridData'))
	).observes('modelData')

	# Convert Ember model to deep Object
	gridData: (->
		grid = []
		for model in @get('modelData')
			item = {"id" : model.get('id')}
			for column in @get('columnsDescriptor')
				item[column.field] = model.get(column.field) if column.field
			grid.push(item)
		return grid
	).property('modelData')

	columnsDescriptor: (->
		debugger;
		@get('store').getColumnsForType(@get('dataType'))
	).property('dataType')

	init: ->
		@_super()
		#@update(@REQUEST_TYPE.ALL)

	update: (requestType)->
		debugger;
		if @get('dataType')? && @get('store')?
			query = $.extend(
				{}, 
				{type: requestType}, 
				{paging: @get('pagingInfo')},
				{sorting: @getSortingInfo()},
				{filtering: @getFilteringInfo()}
				{grouping: @getGroupingInfo()}
				{searching: @getSearchingInfo()}
			)
			debugger;
			# Add support for asynch calls later	
			response = @get('store').findQuery(eval(@get('dataType')), query)
			@set('modelData', response.modelData)
			@updatePagingInfo(response.pagingInfo)
