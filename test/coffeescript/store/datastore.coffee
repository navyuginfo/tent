require('coffeescript/models/task_model')

Pad.DataStore = Ember.Object.extend
	fixtures: Pad.Models.TaskModel.FIXTURES

	findAll: (dataType) ->
		@addPagingData(@fixtures)
	findQuery: (modelType, query) ->
		@queryFixtures(@fixtures, query)

	addPagingData: (list, paging)->
			data: list
			pagingInfo: paging
	
	getColumnsForType: ->
		[
			{id: "id", name: "ID", field: "id", sortable: true},
			{id: "title", name: "Title", field: "title", sortable: true},
			{id: "duration", name: "Duration", field: "duration", sortable: true},
			{id: "%", name: "% Complete", field: "percentComplete"},
			{id: "start", name: "Start", field: "start", formatter: Tent.Formatters.Date},
			{id: "finish", name: "Finish", field: "finish"},
			{id: "effort-driven", name: "Effort Driven", field: "effortDriven"}
		]

	queryFixtures: (fixtures, query) ->
		data = []
		###switch query.type
			when 'paging'
				# do paging optimizations here
			when 'sorting'
				# do sorting optimizations here
			when 'filtering'

			else
		###
		filteredData = @doFilter(fixtures, query.filtering)
		sortedData = @doSort(filteredData, query.sorting)
		query.paging.totalRows = filteredData.length
		pagedData = @getPage(sortedData, query.paging)
		return @addPagingData(pagedData, query.paging)

	getPage: (fixtures, paging) ->
		if !paging?
			return fixtures

		start = (paging.pageNum) * paging.pageSize
		if (start > fixtures.length) 
			start = 0
			paging.pageNum = 0
		end = start + paging.pageSize - 1
		if (end > fixtures.length) then end = fixtures.length 
		return fixtures[start..end]

	doSort: (fixtures, sorting) ->
		if !sorting?
			return fixtures

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
		if !filters?
			return fixtures

		filteredFixtures = []
		for item in fixtures
			passed = true
			for columnId of filters
				if columnId != undefined and filters[columnId]?
					if item[columnId] instanceof String
							re = new RegExp("^" + filters[columnId],"i")
							if !re.test(item[columnId])
								passed = false
					if item[columnId] instanceof Date
							if filters[columnId].getTime() != item[columnId].getTime()
								passed = false	
			if passed then filteredFixtures.push(item)
		return filteredFixtures
