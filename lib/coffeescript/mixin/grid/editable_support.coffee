###*
* @class Tent.Grid.EditableSupport
* Provides support for editable fields in a grid
###

Tent.Grid.EditableSupport = Ember.Mixin.create
	###*
	* @property {Function} onEditRow A callback function which will be called when a row is made editable. 
	* The context of the function is this JqGrid View, and it will accept the following parameters:
	* 
	* -rowId: the id of the selected row
	* -grid: the jqGrid
	*  
	###
	onEditRow: null

	###*
	* @property {Function} onRestoreRow A callback function which will be called when editing of a row is cancelled,
	* and the original values restored to the cells. 
	* The context of the function is this JqGrid View, and it will accept the following parameters:
	* 
	* -rowId: the id of the selected row
	* -grid: the jqGrid
	*  
	###
	onRestoreRow: null

	###*
	* @property {Function} onSaveCell A callback function which will be called when an editable cell is saved. (This 
	* usually occurs on change or blur) 
	* The context of the function is this JqGrid View, and it will accept the following parameters:
	* 
	* -rowId: the id of the selected row
	* -grid: the jqGrid
	* -cellName: the name of the edited cell
	* -iCell: the position of the edited cell
	*
	###
	onSaveCell: null

	showEditableCells: ->
		table = @getTableDom()
		if table?
			for id in table.jqGrid('getDataIDs')
				@showEditableCell(id, table)

	showEditableCell: (id, table) ->
		if @get('selectedIds').contains(id)
			@editRow(id, table)
		else
			@restoreRow(id)

	# Make all editable cells editable
	editRow: (rowId, table) ->
		table = table or @getTableDom()
		table.jqGrid('editRow', rowId, false,  @onEditFunc())

	# When a row is deselected, revert to the previous value 
	restoreRow: (rowId, table) ->
		if @isRowCurrentlyEditing(rowId)
			table = table or @getTableDom()
			table.jqGrid('restoreRow', rowId)
			@saveEditedRow(rowId)
			@get('onRestoreRow').call(@, rowId, table) if @get('onRestoreRow')?

	restoreRows: (ids)->
		tableDom = @getTableDom()
		savedRows = tableDom[0].p.savedRow.filter(-> true)
		# For performance
		contentArray = @get('content').toArray()
		onRestoreRow = @get('onRestoreRow')
		for row in savedRows
			rowId = row.id
			tableDom.jqGrid('restoreRow', rowId)
			@cancelEditedRow(rowId, contentArray)
			#@saveEditedRow(rowId)
			onRestoreRow.call(@, rowId, tableDom) if onRestoreRow?

	# Revert to the previous value
	cancelEditedRow: (rowId, contentArray)->
		rowData = @getTableDom().getRowData(rowId)
		model = @getItemFromModel(rowId, contentArray)
		for col in @getColModel()
			if col.editable
				model.set(col.name, rowData[col.name])

	isRowCurrentlyEditing: (rowId)->
		isEditing = false
		savedRow = @getTableDom()[0].p.savedRow
		for row in savedRow
			if row.id == rowId
				isEditing = true
		isEditing

	onEditFunc: (rowId) ->
		widget = @
		(rowId) ->
			widget.get('onEditRow').call(widget, rowId, widget.getTableDom()) if widget.get('onEditRow')?

	saveEditedRow: (rowId, status, options)->
		rowData = @getTableDom().getRowData(rowId)
		modelItem = @getItemFromModel(rowId)
		for col in @getColModel()
			if col.editable
				@saveEditedCell(rowId, col.name, rowData[col.name], null, null, null, modelItem)

	saveEditedCell: (rowId, cellName, value, iRow, iCell, cell, modelItem) ->
		modelItem = modelItem or @getItemFromModel(rowId)

		# Need to unformat/validate the value before saving 
		formatter = @getTableDom().getColProp(cellName).formatter
		#if formatter?
		if $.fn.fmatter[formatter]?
			if cell?
				modelItem.set(cellName, $.fn.fmatter[formatter].unformat(null, {}, cell))
			else
				modelItem.set(cellName, $.fn.fmatter[formatter].unformat(value))
		else 
			modelItem.set(cellName, value)
		#@getTableDom().triggerHandler()

	# Called by a cell widget on blur or change
	saveEditableCell: (element)->
		rowId = $(element).parents('tr:first').attr('id')
		cellpos = $(element).parents('tr').children().index($(element).parents('td'))
		cellName = @getColModel()[cellpos].name
		@saveEditedCell(rowId, cellName, null, null, null, $(element).parent())
		@onSaveCell.call(@, rowId, @getTableDom(), cellName, cellpos) if @onSaveCell?

