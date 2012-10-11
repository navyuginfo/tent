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
			{id: "id", name: "id", title: "_hID", field: "id", sortable: true, hideable: false},
			{id: "title", name: "title", title: "_hTitle", field: "title", sortable: true, hideable: false},
			{id: "amount", name: "amount", title: "_hAmount", field: "amount", editable: true, hideable: false, sortable: true, formatter: "amount", align: 'right' },
			{id: "duration", name: "duration", title: "_hDuration",field: "duration", sortable: true, align: 'right', formatter: 'selectEdit', editoptions:{value: {1:'One',2:'Two',3:'Three',4:'Four',5:'Five',6:'Six',7:'Seven',8:'Eight'}}},
			{id: "%", name: "percentcomplete", title: "_hPercentComplete",field: "percentcomplete"},
			{id: "effortdriven", name: "effortdriven", title: "_hEffortDriven", field: "effortdriven"},
			{id: "start", name: "start", title: "_hStart",field: "start", formatter: "date"},
			{id: "finish", name: "finish", title: "_hFinish",field: "finish", hideable: true}
			{id: "completed", name: "completed", title: "_hCompleted",field: "completed", hideable: true, formatter: 'checkboxEdit', align: 'center', editable: false}
		]

	queryFixtures: (modelData, query) ->
		data = []
		filteredData = @doFilter(modelData, query.filtering)
		sortedData = @doSort(filteredData, query.sorting)
		query.paging.totalRows = filteredData.length
		pagedData = @getPage(sortedData, query.paging)
		return @addCombinedData(pagedData, query.paging)

	getPage: (modelData, paging) ->
		if !paging?
			return modelData

		start = (paging.pageNum-1) * paging.pageSize
		if (start > modelData.length) 
			start = 0
			paging.pageNum = 1
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
