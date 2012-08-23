Tent.GridSortingSupport = Ember.Mixin.create
	init: ->
		@_super()
		
	attachSortingBehavior: (->
		@get('grid').onSort.subscribe((e, args) =>
			@sortCallback e,args
		)
	).observes 'grid'
	
	sortCallback: (e, args) ->
		if @remoteSorting
			# Sorting is to be done on the server
			# Pass control to the controller, which will update the grid 
			# with the sorted data items
			if args.multiColumnSort
				@get('controller').sortMultiColumn(args.sortCols)
			else
				@get('controller').sortSingleColumn(args.sortCol, args.sortAsc)
		else
			@clientSort(args)

	clientSort: (args) ->	 
		cols = args.sortCols
		data = @get('grid').getData().getItems()
		if args.multiColumnSort
			@sortDataMultiColumn(data, cols)
		else
			@sortDataSingleColumn(data, args)
		
		@get('grid').invalidate()
		@setDataViewItems(data)
		@get('grid').render()

	sortDataSingleColumn: (data, args) ->
		that = @
		data.sort((dataRow1, dataRow2) =>
			field = args.sortCol.field
			asc = args.sortAsc
			that.compare(dataRow1, dataRow2, field, asc)
		)
	
	sortDataMultiColumn: (data, cols)->
		that = @
		data.sort((dataRow1, dataRow2) ->
			for item,i in cols
				field = cols[i].sortCol.field
				asc = cols[i].sortAsc
				return that.compare(dataRow1, dataRow2, field, asc)
			return 0
		)

	compare: (dataRow1, dataRow2, field, asc)->
		sign = if asc then 1 else -1
		value1 = dataRow1[field]
		value2 = dataRow2[field]
		if value1 == value2 
			result = 0
		else 
			if value1 > value2 
				result = 1 * sign
			else 
				result = -1 * sign
		if result != 0
			return result