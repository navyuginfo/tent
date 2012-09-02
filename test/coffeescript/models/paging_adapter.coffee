 
Pad.PagingAdapter = DS.FixtureAdapter.extend
	queryFixtures: (fixtures, query) ->
		switch query.type
			when 'paging'
				return @getPage(fixtures, query.paging)
			when 'sorting'
				#query =
					#type: 'sorting'
					#fields: 
					#	field: col.field
					#	sortAsc: ascending 
				@doSort(fixtures, query.sorting)
				# When sorting over multiple pages, we return the first page
				return @getPage(fixtures, query.paging)
			when 'filtering'
				return @getPage(@doFilter(fixtures, query.filtering), query.paging)
			else
		   		return fixtures

	getPage: (fixtures, paging) ->
		start = (paging.pageNum - 1) * paging.pageSize
		end = start + paging.pageSize - 1
		if (end > fixtures.length) then end = fixtures.length 
		return fixtures[start..end]

	doSort: (fixtures, sorting) ->
		that = this
		fixtures.sort((dataRow1, dataRow2) =>
			for item,i in sorting.fields
				field = sorting.fields[i].field
				asc = sorting.fields[i].sortAsc
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

	doFilter: (fixtures, filters) ->
		filteredFixtures = []
		for item in fixtures
			for columnId of filters
				if columnId != undefined && filters[columnId] != ""
					re = new RegExp("^" + filters[columnId],"i")
					if re.test(item[columnId])
						filteredFixtures.push(item)
		return filteredFixtures
  	
Pad.pagingAdapter = Pad.PagingAdapter.create();