setup = ->
teardown = ->  
    
module 'Tent.CollectionPanelContentContainerView', setup, teardown

test '...', ->
	item1 = Ember.Object.create
		title: "Object1"

	view = Tent.CollectionPanelContentContainerView.create
		item: item1
		contentViewType: "Tent.CollectionPanelContentView"

	ok not view.get('isSelected'), 'Should not be selected'

	view.addToSelection()
	ok view.get('isSelected'), 'Should be selected'
	view.removeFromSelection()
	ok not view.get('isSelected'), 'Should be de-selected again'