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
		if @getTableDom()?
			for id in @getTableDom().jqGrid('getDataIDs')
				@showEditableCell(id)

	showEditableCell: (id) ->
		if @get('selectedIds').contains(id)
			@editRow(id)
		else
			@restoreRow(id)

	# Make all editable cells editable
	editRow: (rowId) ->
		@getTableDom().jqGrid('editRow', rowId, false,  @onEditFunc())

	# When a row is deselected, revert to the previous value 
	restoreRow: (rowId) ->
		if @isRowCurrentlyEditing(rowId)
			@getTableDom().jqGrid('restoreRow', rowId)
			@saveEditedRow(rowId)
			@get('onRestoreRow').call(@, rowId, @getTableDom()) if @get('onRestoreRow')?

	isRowCurrentlyEditing: (rowId)->
		isEditing = false
		for row in @getTableDom()[0].p.savedRow
			if row.id == rowId
				isEditing = true
		isEditing

	onEditFunc: (rowId) ->
		widget = @
		(rowId) ->
			widget.get('onEditRow').call(widget, rowId, widget.getTableDom()) if widget.get('onEditRow')?

	saveEditedRow: (rowId, status, options)->
		rowData = @getTableDom().getRowData(rowId)
		for col in @getColModel()
			if col.editable
				@saveEditedCell(rowId, col.name, rowData[col.name])

	saveEditedCell: (rowId, cellName, value, iRow, iCell, cell) ->
		# Need to unformat/validate the value before saving 
		formatter = @getTableDom().getColProp(cellName).formatter
		#if formatter?
		if $.fn.fmatter[formatter]?
			if cell?
				@getItemFromModel(rowId).set(cellName, $.fn.fmatter[formatter].unformat(null, {}, cell))
			else
				@getItemFromModel(rowId).set(cellName, $.fn.fmatter[formatter].unformat(value))
		else 
			@getItemFromModel(rowId).set(cellName, value)
		#@getTableDom().triggerHandler()

	# Called by a cell widget on blur or change
	saveEditableCell: (element)->
		rowId = $(element).parents('tr:first').attr('id')
		cellpos = $(element).parents('tr').children().index($(element).parents('td'))
		cellName = @getColModel()[cellpos].name
		@saveEditedCell(rowId, cellName, null, null, null, $(element).parent())
		@onSaveCell.call(@, rowId, @getTableDom(), cellName, cellpos) if @onSaveCell?

