 
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
				that = this
				fixtures.sort((dataRow1, dataRow2) =>
					field = query.field
					asc = query.sortAsc
					that.compare(dataRow1, dataRow2, field, asc)
				)
				# When sorting over multiple pages, we return the first page
				return @getPage(fixtures, query)
			else
		   		return fixtures

	getPage: (fixtures, query) ->
		start = query.pageNum * query.pageSize
		end = start + query.pageSize - 1
		if (end > fixtures.length) then end = fixtures.length 
		return fixtures[start..end]

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