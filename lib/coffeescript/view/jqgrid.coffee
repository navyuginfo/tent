require '../template/jqgrid'

###*
* @class Tent.JqGrid
* @extends Ember.View
*
* ##Usage
*		{{view Tent.JqGrid
                  label="Tasks"
                  collectionBinding="Pad.tasksCollection"
                  selectionBinding="Pad.selectedTasks"
                  paged=true
                  pageSize=6           
                  multiSelect=true             
              }}
*
*
###

Tent.JqGrid = Ember.View.extend
	templateName: 'jqgrid'
	collection: null
	paged: true
	pageSize: 12
	pagingData: 
		page: 1 
	sortingData: {}
	selectedIds: []
	contentBinding: 'collection.modelData'
	columnsBinding: 'collection.columnsDescriptor'
	totalRowsBinding: 'collection.totalRows'
	totalPagesBinding: 'collection.totalPages'

	init: ->
		@_super()
		if not @get('collection')?
			throw new Error("Collection must be provided for Tent.JqGrid")
		if @get('paged')
			@get('collection').set('pageSize', @get('pageSize'))

	didInsertElement: ->
		@set('tableId', @get('elementId') + '_jqgrid')
		@$('.grid-table').attr('id', @get('tableId'))
		@$('.gridpager').attr('id', @get('elementId') + '_pager')
		widget = @
		@$('#' + @get('tableId')).jqGrid({
			datatype: (postdata) ->
				#	_search: false,	nd: 1349351912240, page: 1, rows: 12, sidx: "", sord: "asc"
				if postdata.sidx!="" and (postdata.sidx != widget.get('sortingData').field or postdata.sord != widget.get('sortingData').asc)
					widget.get('collection').sort(
						fields: [
							sortAsc: postdata.sord=="asc"
							field: postdata.sidx
						])
				else 
					widget.get('pagingData').page = postdata.page
					widget.get('collection').goToPage(postdata.page)

				widget.get('sortingData').field = postdata.sidx
				widget.get('sortingData').asc = postdata.sord
				
			height: 250,
			colNames: @get('colNames'),
			colModel: @get('colModel'),
			multiselect: @get('multiSelect'),
			caption: "Testing jsGrid",
			autowidth: true,
			sortable: true, #columns can be dragged
			forceFit: true, #column widths adapt when one is resized
			rowNum: @get('pageSize') if @get('paged'),
			gridview:true,
			pager: '#' + @get('elementId') + '_pager' if @get('paged'),
			onSelectRow: (itemId, status, e) ->
				widget.didSelectRow(itemId, status, e)
			,
			onSelectAll: (rowIds, status) ->
				widget.didSelectAll(rowIds, status)
			,
			loadComplete: () ->
				widget.highlightRows(@)
		})
		@get('collection').goToPage(1)

	highlightRows: (grid)->
		for item in @get('selectedIds')
			$(grid).jqGrid('setSelection', item, false)

		if @allRowsAreSelected(grid)
			grid.setHeadCheckBox(true)
		else
			grid.setHeadCheckBox(false)

	allRowsAreSelected: (grid) ->
		# Check for state of selectAll checkbox
		selectedIds = @get('selectedIds')
		allSelected = true
		for id in $(grid).jqGrid('getDataIDs')
			if !selectedIds.contains(id)
				allSelected = false
		allSelected

	didSelectRow: (itemId, status, e)->
		if !@get('multiSelect')
			@get('selectedIds').clear()
			@get('selection').clear()
			@get('selectedIds').pushObject(itemId)
			@get('selection').pushObject(@getItemFromModel(itemId))
		else 
			if status #status indicates whether the row is being selected or unselected
				@get('selectedIds').pushObject(itemId)
				@get('selection').pushObject(@getItemFromModel(itemId))
			else 
				@get('selectedIds').removeObject(itemId)
				@get('selection').removeObject(@getItemFromModel(itemId))

	didSelectAll: (rowIds, status) ->
		for id in rowIds
			if status
				@get('selectedIds').pushObject(id) if !@get('selectedIds').contains(id)
				modelItem = @getItemFromModel(id)
				@get('selection').pushObject(modelItem) if !@get('selection').contains(modelItem)
			else 
				@get('selectedIds').removeObject(id)
				@get('selection').removeObject(@getItemFromModel(id))


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
		@highlightRows(@$('#' + @get('tableId')).get(0))
	).observes('content')

 


		