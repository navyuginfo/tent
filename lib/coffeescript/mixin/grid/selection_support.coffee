Tent.Grid = Tent.Grid or Ember.Namespace.create()

###*
* @class Tent.Grid.SelectionSupport
* Provides support for selecting items in a grid
###

Tent.Grid.SelectionSupport = Ember.Mixin.create
	selectItemSingleSelect: (itemId) ->
    	@clearSelection()
    	@selectItem(itemId)

	selectItemMultiSelect: (itemId, status) ->
		if status!=false #status indicates whether the row is being selected or unselected
			@selectItem(itemId)
		else 
			@deselectItem(itemId)

	###*
	* @method  clearSelection Removes all items from the selection array and resets the grid
	###
	clearSelection: ->	
		@set('selection', [])

	selectItem: (itemId) ->
		selectedItem = @getItemFromModel(itemId)
		selection = @get('selection')
		selection.pushObject(selectedItem) if (selectedItem? and not selection.contains(selectedItem))

	deselectItem: (itemId) ->
		@removeItemFromSelection(itemId)

	removeItemFromSelection: (id)->
		@set('selection', @get('selection').filter((item, index)->
				item.get('id') != parseInt(id)
			)
		)

	didSelectAll: (rowIds, status) ->
		selectedIds = @get('selectedIds')
		if @get('paged')
			# We can optimise when we know all items are to be selected
			if status!=false
				allPageItems = []
				selection = @get('selection')
				for id in rowIds
					selectedItem = @getItemFromModel(id)
					allPageItems.push selectedItem if (selectedItem? and not selection.contains(selectedItem))
				selection.pushObjects(allPageItems)
			else 
				allPageItems = []
				for id in rowIds
					allPageItems.push @getItemFromModel(id)
				@get('selection').removeObjects(allPageItems)
		else
			if status!=false
				@selectAllItems()
			else
				@clearSelection()

	selectAllItems: ->
		@set('selection', @get('content').filter(-> true))

	selectionDidChange: (->
		@updateGrid()
	).observes('selection.@each')
