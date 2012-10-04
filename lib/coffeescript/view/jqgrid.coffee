require '../template/jqgrid'

Tent.JqGrid = Ember.View.extend
	templateName: 'jqgrid'
	collection: null
	pageSize: 12
	remotePaging: false
	pagingData: 
		records: 27
		total: 3
		page: 1 
	selectedIds: []
	contentBinding: 'collection.modelData'
	columnsBinding: 'collection.columnsDescriptor'
	totalRowsBinding: 'collection.totalRows'
	totalPagesBinding: 'collection.totalPages'

	init: ->
		@_super()
		if not @get('collection')?
			throw new Error("Collection must be provided for Tent.JqGrid")
		@get('collection').set('pageSize', @get('pageSize'))

	didInsertElement: ->
		@set('tableId', @get('elementId') + '_jqgrid')
		@$('.grid-table').attr('id', @get('tableId'))
		@$('.gridpager').attr('id', @get('elementId') + '_pager')
		widget = @
		@$('#' + @get('tableId')).jqGrid({
			#datatype: "json",
			datatype: (postdata) ->
				#	_search: false,	nd: 1349351912240, page: 1, rows: 12, sidx: "", sord: "asc"
				widget.get('pagingData').page = postdata.page
				widget.get('collection').goToPage(postdata.page)


				#widget.$('#' + widget.get('tableId')).jqGrid('clearGridData')
				#widget.$('#' + widget.get('tableId')).setGridParam({lastpage: 3})
				#widget.$('#' + widget.get('tableId')).jqGrid('addRowData','id',widget.get('gridData'))
				#widget.$('#' + widget.get('tableId')).setGridParam({data: widget.get('gridData')})

			#data: @get('gridData'),
			height: 250,
			colNames: @get('colNames'),
			colModel: @get('colModel'),
			multiselect: @get('multiSelect'),
			caption: "Testing jsGrid",
			autowidth: true,
			sortable: true, #columns can be dragged
			forceFit: true, #column widths adapt when one is resized
			rowNum: 12 if @get('paged'),
			gridview:true,
			pager: '#' + @get('elementId') + '_pager' if @get('paged'),
			onSelectRow: (id, status, e) ->
				if !widget.get('remotePaging')
					p = this.p
					item = p.data[p._index[id]]
					if typeof item.sel == "undefined"
						item.sel = true
					else
						item.sel = !item.sel
					
					widget.didSelectRow(id, p._index[id],  status, e)
				
			,
			loadComplete: () ->
				widget.highlightRows(@)
		})
		@get('collection').goToPage(1)

	highlightRows: (grid)->
		p = grid.p
		data = p.data
		$this = $(grid)
		index = p._index
		for rowid of index
			item = data[index[rowid]]
			if typeof (item.sel) == "boolean" && item.sel
				$this.jqGrid('setSelection', rowid, false)


	didSelectRow: (itemId, rownum, status, e)->
		if status #status indicates whether the row is being selected or unselected
			@get('selectedIds').pushObject(itemId)
			@get('selection').pushObject(@getItemFromModel(itemId))
		else 
			@get('selectedIds').removeObject(itemId)
			@get('selection').removeObject(@getItemFromModel(itemId))
		

	getItemFromModel: (id)->
		for model in @get('content').toArray()
			return model if model.get('id') == parseInt(id)

	# Adapter to get column names from current datastore columndescriptor version  
	colNames: (->
		names = []
		for column in @get('columns')
			names.pushObject(Tent.I18n.loc(column.name))
		names
	).property('columns')

	# Adapter to get column descriptors from current datastore columndescriptor version 
	colModel: (->
		columns = []
		for column in @get('columns')
			item = 
				name: column.field
				index: column.field
				width: 50
				align: column.align
			columns.pushObject(item)
		columns
	).property('columns')
 
	# Adapter to get grid data from current datastore in a format compatible with jqGrid 
	gridData: (->
		models = @get('content').toArray()
		grid = []
		for model in models
			item = {"id" : model.get('id')}
			if @get('selection').contains(model)
				item.sel = true
			cell = []
			for column in @get('colModel')
				#item[column.name] = model.get(column.name)
				cell.push(model.get(column.name))
			item.cell = cell
			grid.push(item)
		return grid
	).property('content')

	gridDataDidChange: (->
		# remove existing grid data
		@$('#' + @get('tableId')).jqGrid('clearGridData')
		data = 
			rows: @get('gridData')
			total: @get('totalPages')
			records: @get('totalRows')
			page: @get('pagingData').page
		#$.extend(data, @get('pagingData'))
			
		@$('#' + @get('tableId'))[0].addJSONData(data)
		#@highlightRows(@$('#' + @get('tableId')).get(0))
	).observes('content')

 


		