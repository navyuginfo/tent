require '../../template/grid/autofit_button'

Tent.Grid.AutofitButton = Ember.View.extend
	classNames: ['tent-autofit-button']
	templateName: 'grid/autofit_button'
	title: Tent.I18n.loc("tent.jqGrid.horizontalScroll")
	grid: null

	active: (->
		return !@get('grid.horizontalScrolling')
	).property('grid.horizontalScrolling')

	click: ->
		@get('grid').set('horizontalScrolling', !@get('grid').get('horizontalScrolling'))