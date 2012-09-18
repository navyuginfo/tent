require('coffeescript/models/task_model')

Pad.DataStore = Ember.Object.extend
	fixtures: Pad.Models.TaskModel.FIXTURES

	findAll: (dataType) ->
		@addPagingData(@fixtures)

	findQuery: (modelType, query) ->
		#@queryFixtures(@fixtures, query)
		modelData = Pad.store.findAll(modelType).toArray()
		@queryFixtures(modelData, query)

	addCombinedData: (modelData, paging)->
			pagingInfo: paging
			modelData: modelData
	
	getColumnsForType: ->
		[
			{id: "id", name: "_hID", field: "id", sortable: true},
			{id: "title", name: "_hTitle", field: "title", sortable: true},
			{id: "duration", name: "_hDuration", field: "duration.test", sortable: true},
			{id: "%", name: "_hPercentComplete", field: "percentComplete"},
			{id: "start", name: "_hStart", field: "start", formatter: Tent.Formatters.Date},
			{id: "finish", name: "_hFinish", field: "finish"},
			{id: "effort-driven", name: "_hEffortDriven", field: "effortDriven"}
		]

	queryFixtures: (modelData, query) ->
		data = []
		###switch query.type
			when 'paging'
				# do paging optimizations here
			when 'sorting'
				# do sorting optimizations here
			when 'filtering'

			else
		###
		filteredData = @doFilter(modelData, query.filtering)
		sortedData = @doSort(filteredData, query.sorting)
		query.paging.totalRows = filteredData.length
		pagedData = @getPage(sortedData, query.paging)
		return @addCombinedData(pagedData, query.paging)

	getPage: (modelData, paging) ->
		if !paging?
			return modelData

		start = (paging.pageNum) * paging.pageSize
		if (start > modelData.length) 
			start = 0
			paging.pageNum = 0
		end = start + paging.pageSize - 1
		if (end > modelData.length) then end = modelData.length 
		return modelData[start..end]

	doSort: (modelData, sorting) ->
		if !sorting?
			return modelData

		that = this
		modelData.sort((dataRow1, dataRow2) =>
			for item,i in sorting.fields
				field = sorting.fields[i].field
				asc = sorting.fields[i].sortAsc
				return that.compare(dataRow1, dataRow2, field, asc)
			return 0
		)

	compare: (dataRow1, dataRow2, field, asc)->
		sign = if asc then 1 else -1
		value1 = dataRow1.get(field)
		value2 = dataRow2.get(field)
		if value1 == value2 
			result = 0
		else 
			if value1 > value2 
				result = 1 * sign
			else 
				result = -1 * sign
		if result != 0
			return result

	doFilter: (modelData, filters) ->
		if !filters?
			return modelData

		filteredFixtures = []
		for item in modelData
			passed = true
			for columnId of filters
				if columnId != undefined and filters[columnId]?
					if item.get(columnId) instanceof Date
						if filters[columnId].getTime() != item.get(columnId).getTime()
							passed = false	
					else
						re = new RegExp("^" + filters[columnId],"i")
						if !re.test(item.get(columnId))
							passed = false
			if passed then filteredFixtures.push(item)
		return filteredFixtures
