 
Pad.PagingAdapter = DS.FixtureAdapter.extend
	queryFixtures: (fixtures, query) ->
		switch query.type
			when 'paging'
				start = query.pageNum * query.pageSize
				end = start + query.pageSize - 1
				if (end > fixtures.length) then end = fixtures.length 
				return fixtures[start..end]
			else
		   		return fixtures
  	
Pad.pagingAdapter = Pad.PagingAdapter.create();