#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###
GridController
- content: bind to Model
- modelType: 
- store
- rowSelection holds the object represented by the selected row
###

Tent.Controllers.GridController = Ember.ArrayController.extend
	content: null
	modelType: null
	store: null
	rowSelection: null 

	list: (->
		# The store returns a cache of DS.Model objects, so we need to convert
		# to an ordinary array
		return @getArrayFromRecordArray(@get('content')) if @get('content')
	).property('content')

	rowSelectionDidChange: (->
		#alert('changed rowSelection')
		console.log('#####################')
		for obj in @get('rowSelection')
			console.log(obj.id + "  :  " + obj.title)
	).observes 'rowSelection'

	getArrayFromRecordArray: (recordArray)-> 
		_list = []
		for item in recordArray.toArray()
			if item?
				# TO REMOVE: this is here to show that the sort is being applied
				#json = item.toJSON()
				#json.title += Math.round(Math.random() * 100)
				#_list.push json
				_list.push item.toJSON()
		return _list

	page: (pageInfo)->
		query = $.extend(pageInfo, {type:'paging'})
		@set('content', @store.findQuery(@modelType, query))

	sortMultiColumn: (cols, pagingInfo) ->
		query = @generateQueryFromCols(cols)
		query = $.extend(query, pagingInfo)
		result = @store.findQuery(@modelType, query)
		@set('content', result)
	
	sortSingleColumn: (col, ascending, pagingInfo) ->
		query = @generateQueryFromCol(col, ascending)
		query = $.extend(query, pagingInfo)
		result = @store.findQuery(@modelType, query)
		@set('content', result)

	generateQueryFromCols: (cols) ->
		query = []
		for col in cols
			query.push
				sortDir: if col.sortAsc then 'up' else 'down'
				sortKey: col.sortCol.field
		return query
		
	generateQueryFromCol: (col, ascending) ->
		query =
			type: 'sorting'
			field: col.field
			sortAsc: ascending