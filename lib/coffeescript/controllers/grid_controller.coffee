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

	sort: (args, pagingInfo) ->
		if args.multiColumnSort
			query = @getMultiColumnQuery(args, pagingInfo)
		else
			query = @getSingleColumnQuery(args, pagingInfo)

		query = $.extend(query, pagingInfo, {multiColumn:args.multiColumnSort})
		result = @store.findQuery(@modelType, query)
		@set('content', result)

	getMultiColumnQuery: (args, pagingInfo) ->
		cols = args.sortCols
		query = @generateQueryFromCols(cols)
	
	getSingleColumnQuery: (args, pagingInfo) ->
		col = args.sortCol
		ascending = args.sortAsc
		query = @generateQueryFromCol(col, ascending)	

	generateQueryFromCols: (cols) ->
		fields = []
		for col in cols
			fields.push
				sortAsc: col.sortAsc
				field: col.sortCol.field

		query = 
			type: 'sorting'
			fields: fields

		return query
		
	generateQueryFromCol: (col, ascending) ->
		query =
			type: 'sorting'
			field: col.field
			sortAsc: ascending