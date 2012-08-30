Tent.Data.Sorter = Ember.Mixin.create
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