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
	
	calc: (elem) ->
		#id = $(elem).attr('id')
		#rowId = id.slice(0, id.indexOf('_'))
		#$(elem).val($(this).getCell(rowId,3))

	getColumnsForType: ->
		[

			{id: "id", name: "id", type:"number", title: "_hID", field: "id", width:5, sortable: true, hidden: true, formatter: "action", formatoptions: {action: "showInvoiceDetails"}, hideable: true, groupable: false},
			{id: "title", name: "title", type:"string", title: "_hTitle", field: "title", width:5, sortable: true, hideable: false},
			# {id: "duration", name: "duration", type:"number", title: "_hDuration",field: "duration", width:10, sortable: true, align: 'right', formatter: 'selectEdit', editoptions:{value: {1:'One',2:'Two',3:'Three',4:'Four',5:'Five',6:'Six',7:'Seven',8:'Eight'}}},
			{id: "duration", name: "duration", type:"string", title: "_hDuration",field: "duration", width:10, sortable: true, groupable:true, align: 'right'},
			{id: "%", name: "percentcomplete", type:"number", title: "_hPercentComplete",field: "percentcomplete", width:10, sortable:true},
			{id: "effortdriven", name: "effortdriven", type:"number", title: "_hEffortDriven", field: "effortdriven", groupable:true, width:10, sortable:true},
			{id: "start", name: "start", type:"date", title: "_hStart", field: "start", groupable:true, width:10, formatter: "date", sortable:true},
			{id: "finish", name: "finish", type:"date", title: "_hFinish",field: "finish", groupable:true, width:10, hideable: true, formatter: "date", sortable:true}
			{id: "completed", name: "completed", type:"boolean", title: "_hCompleted",field: "completed", width:30, hideable: true, align: 'center', editable: false, sortable:true}
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
		filterFields = filters.values
		filteredFixtures = []
		for item in modelData
			passed = true
			for columnId of filterFields
				if columnId != undefined and filterFields[columnId]?
					if item.get(columnId) instanceof Date
						if filterFields[columnId].data.getTime() != item.get(columnId).getTime()
							passed = false	
					else
						re = new RegExp("^" + filterFields[columnId].data,"i")
						if !re.test(item.get(columnId))
							passed = false
			if passed then filteredFixtures.push(item)
		return filteredFixtures
