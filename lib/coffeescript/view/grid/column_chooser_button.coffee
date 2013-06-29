require '../../template/grid/column_chooser_button'
require '../../mixin/toggle_visibility'


Tent.Grid.ColumnChooserButton = Ember.View.extend Tent.ToggleVisibility,
	classNames: ['tent-column-chooser-button']
	templateName: 'grid/column_chooser_button'
	#title: Tent.I18n.loc("tent.jqGrid.horizontalScroll")
	grid: null

	model: (->
		filteredColumns = @get('grid.content.filteredColumns.filtered') || []
		annotatedModel = @get('grid.columnModel').map((item)->
			item.set('checked', !item.hidden)
			item
		)
		annotatedModel.filter((item)->
			unfiltered = if filteredColumns.length then !filteredColumns.contains(item.name) else true
			unfiltered and item.hideable != false
		)
	).property('grid.columnModel', 'grid.columnModel.@each', 'grid.content.isLoaded')

	didInsertElement: ->
		grid = @get('grid')
		@bindToggleVisibility(@$(".column-chooser .open-dropdown"), @.$(".column-chooser .dropdown-menu"))

		@$('.column-chooser').on('click', 'input', (e) -> 
			column = $(this).attr('data-column')
			if $(this).is(':checked')
				grid.showCol(column)
			else
				grid.hideCol(column)
		)