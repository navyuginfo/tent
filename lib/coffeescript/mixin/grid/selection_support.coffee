Tent.Grid = Tent.Grid or Ember.Namespace.create()

###*
* @class Tent.Grid.SelectionSupport
* Provides support for selecting items in a grid
###

Tent.Grid.SelectionSupport = Ember.Mixin.create
  didSelectRow: (itemId, status, e)->
    if not @get('multiSelect')
      @selectItemSingleSelect(itemId)
    else
      @selectItemMultiSelect(itemId, status)

    @get('afterSelectRow').call(@get('controller'), @getItemFromModel(itemId), status) if @get('afterSelectRow')? and @get('controller')?

  selectItemSingleSelect: (itemId) ->
    @clearSelection()
    @selectItem(itemId)

  ###*
  * @method  clearSelection Removes all items from the selection array and resets the grid
  ###
  clearSelection: ->
    @set('selection', [])
  	@get('afterDeselectAll').call(@get('controller'), @get('selection')) if @get('afterDeselectAll')? and @get('controller')?

  selectItem: (itemId) ->
    selectedItem = @getItemFromModel(itemId)
    selection = @get('selection')
    selection.pushObject(selectedItem) if (selectedItem? and not selection.contains(selectedItem))



  ####### Multiple Selection ########

  selectItemMultiSelect: (itemId, status) ->
    if status!=false #status indicates whether the row is being selected or unselected
      @selectItem(itemId)
    else
      @deselectItem(itemId)

  deselectItem: (itemId) ->
    @removeItemFromSelection(itemId)

  removeItemFromSelection: (id)->
    @set('selection', @get('selection').filter((item, index)->
          item.get('id') != parseInt(id)
      )
    )
  	@get('afterDeselectRow').call(@get('controller'), @getItemFromModel(itemId), status) if @get('afterDeselectRow')? and @get('controller')?

  ######## Select All ########
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

    @get('afterSelectAll').call(@get('controller'), @get('selection')) if @get('afterSelectAll')? and @get('controller')?

  selectAllItems: ->
    @set('selection', @get('content').filter(-> true))

  selectionDidChange: (->
    @updateGrid()
  ).observes('selection.@each')
