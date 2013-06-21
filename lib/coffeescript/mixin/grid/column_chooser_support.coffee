###*
* @class Tent.Grid.ColumnChooserSupport
* Adds a column choooser to a grid
###

Tent.Grid.ColumnChooserSupport = Ember.Mixin.create
	###*
	* @property {Boolean} showColumnChooser Display a button at the top of the grid which presents
	* a dialog to show/hide columns. Any columns which have a property **'hideable:false'** will not be shown
	* in this dialog
	###
	showColumnChooser: true
	
	addNavigationBar: ->
		@_super()

	showCol: (column) ->
		@getTableDom().jqGrid("showCol",column);
		@refreshGrid()

	hideCol: (column) ->
		@getTableDom().jqGrid("hideCol",column);
		@refreshGrid()

	refreshGrid: ->
		@columnsDidChange()
		@storeColumnDataToCollection()
		@resizeToContainer()
