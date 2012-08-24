
setup = ->
	Grid = Ember.Object.extend Tent.GridSortingSupport
	@grid = Grid.create()
		 
	@data = [
		{id:1, title:"alpha"}
		{id:2, title:"beta"}
		{id:3, title:"gamma"}
		{id:4, title:"delta"}
	]

teardown = ->
	@grid = @data = null

module 'Tent.GridSortingSupport', setup, teardown

test 'Testing client-side sorting - multi column', ->
	cols = [
		sortAsc: false
		sortCol: {
			field: "title"
		}
	]

	grid.sortDataMultiColumn(data, cols)
	equal data[0].title, "gamma", "gamma should be first"
	equal data[3].title, "alpha", "alpha should be last"

	cols[0].sortAsc = true
	grid.sortDataMultiColumn(data, cols)
	equal data[0].title, "alpha", "alpha should be first with sort ascending"
	equal data[3].title, "gamma", "gama should be last with sort ascending"

test 'Testing client-side sorting - single column', ->
	args = 
		sortAsc: false
		sortCol: {
			field: "title"
		}
	
	grid.sortDataSingleColumn(data, args)
	equal data[0].title, "gamma", "gamma should be first"
	equal data[3].title, "alpha", "alpha should be last"

	args.sortAsc = true
	grid.sortDataSingleColumn(data, args)
	equal data[0].title, "alpha", "alpha should be first with sort ascending"
	equal data[3].title, "gamma", "gama should be last with sort ascending"