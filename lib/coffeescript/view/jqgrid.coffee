require '../template/jqgrid'

Tent.JqGrid = Ember.View.extend
	templateName: 'jqgrid'
	collection: null
	contentBinding: 'collection.modelData'
	columnsBinding: 'collection.columnsDescriptor'

	init: ->
		@_super()
		if not @get('collection')?
			throw new Error("Collection must be provided for Tent.JqGrid")

	didInsertElement: ->
		tableId = @get('elementId') + '_jqgrid'
		@$('.grid-table').attr('id', tableId)
		@$('.gridpager').attr('id', @get('elementId') + '_pager')
		@$('#' + tableId).jqGrid({
			datatype: "local",
			data: @get('gridData'),
			height: 250,
			colNames: @get('colNames'),
			colModel: @get('colModel'),
			multiselect: @get('multiselect'),
			caption: "Testing jsGrid",
			autowidth: true,
			sortable: true, #columns can be dragged
			forceFit: true, #column widths adapt when one is resized
			rowNum: 12,
			rowList:[5,10,20],
			gridview:true,
			pager: '#' + @get('elementId') + '_pager',
			onSelectRow: $.proxy(@didSelectRow, @)
		})
		#@$('#' + tableId).jqGrid('addRowData','id', @get('gridData'))
		#@$('.grid-table').trigger('reloadGrid')

	didSelectRow: (rowId, status, e)->
		@set('selection', @getItemFromModel(rowId))

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
			for column in @get('colModel')
				item[column.name] = model.get(column.name)
			grid.push(item)
		return grid
	).property('content')

	




		