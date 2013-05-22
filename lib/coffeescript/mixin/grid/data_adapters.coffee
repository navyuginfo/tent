
Tent.Grid.Adapters = Ember.Mixin.create
	
	columns: (->
		@get('collection.columnsDescriptor')
	).property('collection.columnsDescriptor')

	# Adapter to get column names from columnModel
	colNames: (->
		names = []
		for column in @get('columnModel')
			t = Tent.I18n.loc(column.title)
			if @get('columnInfo.titles')?
				for name, title of @get('columnInfo.titles')
        			t = title if column.name == name
			names.pushObject(t)
		names
	).property('columns')

	# Adapter to get column descriptors from current datastore columndescriptor version 
	columnModel: (->
		columns = Ember.A() 
		if @get('columns')?
			for column in @get('columns')
				item = Ember.Object.create
					name: column.name
					index: column.name
					align: column.align
					editable: column.editable
					formatter: column.formatter
					formatoptions: column.formatoptions
					edittype: Tent.JqGrid.editTypes[column.formatter] or 'text'
					editoptions: column.editoptions or Tent.JqGrid.editOptions[column.formatter]
					editrules: column.editrules or Tent.JqGrid.editRules[column.formatter]
					width: @calculateColumnWidth(column)
					position: "right"
					hidden: if column.hidden? then column.hidden else false
					hideable: column.hideable
					hidedlg: true if column.hideable == false
					sortable: column.sortable
					groupable: column.groupable
					resizable: true
					title: Tent.I18n.loc column.title
				columns.pushObject(item)
		columns
	).property('columns')

	calculateColumnWidth: (column)->
		if @get('horizontalScrolling')
			@get('fixedColumnWidth') or Tent.I18n.loc(column.title)?.length * 10 or 80
		else
			column.width or 80

	columnNames: (->
		columnNames = []
		for column in @get('columnModel')
			columnNames.pushObject(column.name)
		columnNames
 	).property('columnModel', 'columnModel.@each')
	
	# Any rows which are identified as presentationType='summary' should be attached to the 
	# bottom of the grid as fixed rows
	fixedRows: (->
		allModel=[]
		data = @get('content')?.filterProperty('presentationType','summary')
		if data?
			data.forEach (item)=>
				allModel.push(item?.getProperties(@get('columnNames')))
		allModel	
	).property('content','content.isLoaded')

	fixedRowsCount: (->
		@get('fixedRows.length')
	).property('fixedRows')
	# Adapter to get grid data from current datastore in a format compatible with jqGrid 
	gridData: (->
		grid = []

		if @get('content')?
			models = @get('content').toArray()
			if @isShowingValidGroups()
				for model in models
					grid.push(model)
			else
				for model in models
					item = {"id" : model.get('id')}
					if @get('selectedIds').contains(model.get('id'))
						item.sel = true
					cell = []
					for column in @get('columnModel')
						#item[column.name] = model.get(column.name)
						cell.push(model.get(column.name))
					item.cell = cell
					if model.get("presentationType") is "summary" then grid else grid.push(item)
		return grid
	).property('content','content.isLoaded', 'content.@each')

	gridDataDidChange: (->
	 @getTableDom()[0].p.viewrecords = false
    #remove previous grid data
		@getTableDom().jqGrid('clearGridData')
		###
		* As soon as the required data is loaded set viewrecords attribute of jqGrid to true, and let it 
		* calculate whether there are any records or not using the reccount attribute
		###
		if @get('content.isLoaded')
			@getTableDom()[0].p.viewrecords = true
		data = 
			rows: @get('gridData')
			total: @get('pagingInfo.totalPages') if @get('pagingInfo')? 
			records: @get('pagingInfo.totalRows') if @get('pagingInfo')?
			page: @get('pagingInfo').page if @get('pagingInfo')?
			userdata: @get('fixedRows')
			remoteGrouping: @isShowingValidGroups()
			columns: @get('columnModel')
		@resetGrouping()
		if @isShowingValidGroups()
			data.columnName = @get('groupingInfo.columnName')
			data.columnType = @get('groupingInfo.columnType')
			data.groupType = @get('groupingInfo.type')
			data.columnTitle = @getColumnTitle(data.columnName)
			grid = @getTableDom()[0]
			@updatePagingForGroups(grid, data)
			grid?.addGroupingData(data)
		else
			@getTableDom()[0]?.addJSONData(data)
			@updateGrid()
	).observes('content', 'content.isLoaded', 'content.@each', 'pagingInfo')