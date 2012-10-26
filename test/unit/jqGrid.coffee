

setup = ->
teardown = ->

module 'Tent.JqGrid', setup, teardown

test 'Collection required', ->
	mockCollection = Ember.Object.create()

	raises ->
			Tent.JqGrid.create()
		,
		'Should throw an exception'

	grid = Tent.JqGrid.create
		collection: mockCollection

	equal grid.get('selectedIds').length, 0, 'No selectedIds'

test 'Initial Selection should be populated', ->
	mockCollection = Ember.Object.create()
	selection = [Ember.Object.create(id: 51,title: 't1'),Ember.Object.create(id: 52,title: 't2')]

	grid = Tent.JqGrid.create
		collection: mockCollection
		selection: selection

	equal grid.get('selectedIds').length, 2, 'Should be 2 selected IDs'

test 'Retrieve column model', ->
	mockCollection = Ember.Object.create
		columnsDescriptor: [
			{id: "id", name: "id", title: "_hID", field: "id", sortable: true},
			{id: "title", name: "title", title: "_hTitle", field: "title", sortable: true},
			{id: "amount", name: "amount", title: "_hAmount", field: "amount", sortable: true, formatter: "amount",  align: 'right'},
		]
		toArray: ->
			[
				Ember.Object.create(id: 51,title: 't1', amount: 23.4)
				Ember.Object.create(id: 52,title: 't2', amount: 24.4)
				Ember.Object.create(id: 53,title: 't3', amount: 25.4)
				Ember.Object.create(id: 54,title: 't4', amount: 26.4)
			]

	grid = Tent.JqGrid.create
		collection: mockCollection

	colModel = grid.get('columnModel')
	equal colModel.length, 3, 'Should be 3 columns'
	equal colModel[0].name, "id", 'name field'
	equal colModel[0].index, "id", 'index field'
	equal colModel[2].align, "right", 'align field'
	equal colModel[2].formatter, "amount", 'formatter field'

	gridData = grid.get('gridData')
	equal gridData.length, 4, 'Row data: 4 items'
	equal gridData[0].id, 51, 'Row data: ID field of row'
	equal gridData[0].cell[0], 51, 'Row data: Id is added to the cell'
	equal gridData[0].cell[1], 't1', 'Row data: Title is added to the cell'
	equal gridData[0].cell[2], 23.4, 'Row data: Amount is added to the cell'

 
	
