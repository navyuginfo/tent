require '../../template/grid/column_chooser_button'

Tent.Grid.ColumnChooserButton = Ember.View.extend Tent.ToggleVisibility,
	classNames: ['tent-column-chooser-button']
	templateName: 'grid/column_chooser_button'
	#title: Tent.I18n.loc("tent.jqGrid.horizontalScroll")
	grid: null

	model: (->
		annotatedModel = @get('grid.columnModel').map((item)->
			item.checked = !item.hidden
			item
		)
		annotatedModel.filter((item)->
			item.hideable != false
		)
	).property('grid.columnModel', 'grid.columnModel.@each')

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