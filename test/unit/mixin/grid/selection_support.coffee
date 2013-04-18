setup = ->
	@selection = Ember.A()
	@content = Ember.A([
		Ember.Object.create {id: 1, name:'dog'}
		Ember.Object.create {id: 2, name:'cat'}
		Ember.Object.create {id: 3, name:'mouse'}
		Ember.Object.create {id: 4, name:'bat'}
		Ember.Object.create {id: 5, name:'rhino'}
		Ember.Object.create {id: 6, name:'horse'}
			
	])

	grid = Tent.JqGrid.create()

	Grid = Ember.View.extend Tent.Grid.SelectionSupport,
		selection: null
		getItemFromModel: grid.getItemFromModel
		updateGrid: ->

	@view = Grid.create
		content: content
		selection: selection
	 

teardown = ->
	@selection = null
	@view = null

module 'Tent.Grid.SelectionSupport', setup, teardown

test 'Test clearSelection', ->
	selection.pushObject({name:'dog'})
	equal view.get('selection').length, 1, 'Pushed dog'

	view.clearSelection()
	equal view.get('selection').length, 0, 'cleared'

test 'Select Item Single Select', ->
	
	equal view.get('content').length, 6, 'Start with 6'
	equal view.get('selection').length, 0, 'Start with 0 selected'
	
	view.selectItemSingleSelect(1)
	equal view.get('selection').length, 1, 'Selected 1'
	equal view.get('selection')[0].get('name'), 'dog', 'Selected dog'
	view.selectItemSingleSelect(2)
	equal view.get('selection').length, 1, 'Still only 1 selected'
	equal view.get('selection')[0].get('name'), 'cat', 'Selected cat'
	view.selectItemSingleSelect(10)
	equal view.get('selection').length, 0, 'invalid selection'

test 'Select Item Multi-Select', ->
	isSelecting = true
	isDeselecting = false

	equal view.get('content').length, 6, 'Start with 6'
	equal view.get('selection').length, 0, 'Start with 0 selected'

	view.selectItemMultiSelect(1, isSelecting)
	equal view.get('selection').length, 1, 'Selected 1'
	equal view.get('selection')[0].get('name'), 'dog', 'Selected dog'
	view.selectItemMultiSelect(1, isSelecting)
	equal view.get('selection').length, 1, 'Selected 1 again'
	view.selectItemMultiSelect(2, isSelecting)
	equal view.get('selection').length, 2, 'Selected 2'
	view.selectItemMultiSelect(3, isSelecting)
	equal view.get('selection').length, 3, 'Selected 3'
	view.selectItemMultiSelect(20, isSelecting)
	equal view.get('selection').length, 3, 'invalid selection'

	view.selectItemMultiSelect(2, isDeselecting)
	equal view.get('selection').length, 2, 'Deselected 2'
	equal view.get('selection')[0].get('name'), 'dog', 'dog remains'
	equal view.get('selection')[1].get('name'), 'mouse', 'mouse remains'

	view.selectItemMultiSelect(12, isDeselecting)
	equal view.get('selection').length, 2, 'invalid selection'
	
test 'DidSelectAll: non-paged', ->
	isSelecting = true
	isDeselecting = false

	view.set('paged', false)
	equal view.get('selection').length, 0, 'Start with 0 selected'

	view.didSelectAll(null, isSelecting)
	equal view.get('selection').length, 6, 'Selected 6'
	view.didSelectAll(null, isSelecting)
	equal view.get('selection').length, 6, 'Reselected 6'
	view.didSelectAll(null, isDeselecting)
	equal view.get('selection').length, 0, 'Deselected all'

test 'DidSelectAll: paged', ->
	isSelecting = true
	isDeselecting = false

	view.set('paged', true)
	equal view.get('selection').length, 0, 'Start with 0 selected'

	view.didSelectAll([1,2,3], isSelecting)
	equal view.get('selection').length, 3, 'Selected 3'
	view.didSelectAll([1,2,3], isSelecting)
	equal view.get('selection').length, 3, 'Reselected 3'
	view.didSelectAll([4,5,6], isSelecting)
	equal view.get('selection').length, 6, 'Selected 3 more'
	view.didSelectAll([1,2,3], isDeselecting)
	equal view.get('selection').length, 3, 'Deselected 3'
	equal view.get('selection')[0].get('name'), 'bat', 'First item is bat'
	equal view.get('selection')[2].get('name'), 'horse', 'Last item is horse'





