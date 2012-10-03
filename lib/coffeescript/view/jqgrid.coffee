

Tent.JqGrid = Ember.View.extend
	tagName: 'table'
	collection: null
	contentBinding: 'collection.modelData'
	columnsBinding: 'collection.columnsDescriptor'

	init: ->
		@_super()
		if not @get('collection')?
			throw new Error("Collection must be provided for Tent.JqGrid")

	didInsertElement: ->
		@$().jqGrid({
			datatype: "local",
			height: 250,
			colNames: @get('colNames'),
			colModel: @get('colModel'),
			multiselect: true,
			caption: "Testing jsGrid"
		})
		@$().jqGrid('addRowData','id', @get('gridData'));

	# Adapter to get column names from current datastore columndescriptor version  
	colNames: (->
		names = []
		for column in @get('columns')
			names.pushObject(column.name)
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

	




		