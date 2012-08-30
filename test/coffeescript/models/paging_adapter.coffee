 
Pad.PagingAdapter = DS.FixtureAdapter.extend
	queryFixtures: (fixtures, query) ->
		switch query.type
			when 'paging'
				return @getPage(fixtures, query)
			when 'sorting'
				#query =
					#type: 'sorting'
					#field: col.field
					#sortAsc: ascending
				if query.multiColumn
					@sortMultiColumn(fixtures, query)
				else
					@sortSingleColumn(fixtures, query)
				# When sorting over multiple pages, we return the first page
				return @getPage(fixtures, query)
			else
		   		return fixtures

	getPage: (fixtures, query) ->
		start = (query.paging.pageNum - 1) * query.paging.pageSize
		end = start + query.paging.pageSize - 1
		if (end > fixtures.length) then end = fixtures.length 
		return fixtures[start..end]

	sortMultiColumn: (fixtures, query) ->
		that = this
		fixtures.sort((dataRow1, dataRow2) =>
			for item,i in query.fields
				field = query.fields[i].field
				asc = query.fields[i].sortAsc
				return that.compare(dataRow1, dataRow2, field, asc)
			return 0
		)

	sortSingleColumn: (fixtures, query) ->
		that = this
		fixtures.sort((dataRow1, dataRow2) =>
			field = query.field
			asc = query.sortAsc
			that.compare(dataRow1, dataRow2, field, asc)
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
  	
Pad.pagingAdapter = Pad.PagingAdapter.create();