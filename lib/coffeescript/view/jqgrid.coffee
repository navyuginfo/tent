require '../template/jqgrid'

Tent.JqGrid = Ember.View.extend
	templateName: 'jqgrid'
	collection: null
	remotePaging: false
	selectedIds: []
	contentBinding: 'collection.modelData'
	columnsBinding: 'collection.columnsDescriptor'

	init: ->
		@_super()
		if not @get('collection')?
			throw new Error("Collection must be provided for Tent.JqGrid")

	didInsertElement: ->
		@set('tableId', @get('elementId') + '_jqgrid')
		@$('.grid-table').attr('id', @get('tableId'))
		@$('.gridpager').attr('id', @get('elementId') + '_pager')
		widget = @
		@$('#' + @get('tableId')).jqGrid({
			datatype: "local",
			data: @get('gridData'),
			height: 250,
			colNames: @get('colNames'),
			colModel: @get('colModel'),
			multiselect: @get('multiSelect'),
			caption: "Testing jsGrid",
			autowidth: true,
			sortable: true, #columns can be dragged
			forceFit: true, #column widths adapt when one is resized
			rowNum: 12 if @get('paged'),
			rowList:[5,10,20],
			gridview:true,
			pager: '#' + @get('elementId') + '_pager' if @get('paged'),
			onSelectRow: (id, status, e) ->
				p = this.p
				item = p.data[p._index[id]]
				if typeof item.cb == "undefined"
					item.cb = true
				else
					item.cb = !item.cb
				widget.didSelectRow(id, p._index[id],  status, e)
			,
			loadComplete: () ->
				p = this.p
				data = p.data
				$this = $(this)
				index = p._index
				for rowid of index
					item = data[index[rowid]]
					if typeof (item.cb) == "boolean" && item.cb
						$this.jqGrid('setSelection', rowid, false)
			,
			onPaging: $.proxy(@didChangePage, @)
		})

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
			for column in @get('colModel')
				item[column.name] = model.get(column.name)
			grid.push(item)
		return grid
	).property('content')

	gridDataDidChange: (->
		@$('#' + @get('tableId')).jqGrid('addRowData','id',@get('gridData'));
	).observes('content')

	didChangePage: (button)->
		console.log ("did Page with #{button}")

	page: (pagingInfo)->
		@get('collection').goToPage(pagingInfo.pageNum)



		