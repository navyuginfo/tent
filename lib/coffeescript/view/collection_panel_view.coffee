require '../template/collection_panel'
require '../template/collection_panel_content'

###*
* @class Tent.CollectionPanelView
* 
* Displays a collection of objects in separate panels laid out in a 2d grid.
* The {@link #contentViewType} property must be populated with a view which will render each panel. This view 
* should be a subclass of Tent.TaskCollectionPanelContentView
* 
* Usage within a template:
*     {{view Tent.CollectionPanelView 
            collectionBinding="Pad.jqRemoteCollection"
            contentViewType="Tent.TaskCollectionPanelContentView"
       }} 
*
###

Tent.CollectionPanelView = Ember.View.extend
  templateName: 'collection_panel'
  classNames: ['collection-panel-container']
  multiSelect: false
  selection: null
  scrollTimeout: 200
  currentPage: 1

  ###*
  * @property {Object} collection The colleciton which contains the items for display.
  ###
  collection: null

  ###*
  * @property {String} contentViewType The name of a view class which will render the contents of each panel.
  * This view will have its 'content' populated with the model for that panel
  ###
  contentViewType: null

  didInsertElement: ->
    @get('collection').update()
    @set('selection', Ember.A()) unless @get('selection')?
    @setupScrolledPaging() if @get('scroll')

  contentDidChange: (->
    if @$()? and @get('collection.modelData.isLoaded')
      Ember.run.next =>
        @positionScrollbar()
  ).observes('collection.modelData', 'collection.modelData.isLoaded', 'isVisible')


  setupScrolledPaging: ->
    @$().unbind('scroll').bind('scroll', =>
      @scrollGrid()
    )

  scrollGrid: ->
    clearTimeout(@get('scrollTimer')) if @get('scrollTimer')?
    @set('scrollTimer', setTimeout( => 
          @scrollCollection()
        , @get('scrollTimeout'))
    )

  scrollCollection: ->
    scroller = @$()
    scrollTop = scroller.get(0).scrollTop
    rowHeight = @getCardHeight()
    cardsPerRow = @cardsPerRow()
    newPageNum = @findPageNumberAtScrollPosition(scrollTop, rowHeight, cardsPerRow);    
    if @get('currentPage') != newPageNum
      @set('currentPage', newPageNum)
      @get('collection').goToPage(newPageNum)
   

  findPageNumberAtScrollPosition: (scrollTop, rowHeight, cardsPerRow) ->
    pageSize = @get('collection.pagingInfo.pageSize')
    cardsAbove = parseInt(scrollTop/@getCardHeight(), 10) * cardsPerRow
    parseInt(cardsAbove / pageSize, 10) + 1

  positionScrollbar: ->
    page = @get('collection.pagingInfo.page')
    pageSize = @get('collection.pagingInfo.pageSize')
    totalCards = @get('collection.pagingInfo.totalRows')
    
    rowHeight = @getCardHeight()
    totalRowsToShow = @rowsInGrid(totalCards)

    paddingHeight = @rowsOfPadding() * rowHeight
    totalHeightForAllRows = totalRowsToShow * rowHeight
    @$(".scroller").css({height : totalHeightForAllRows}).children("div:first").css('height', paddingHeight)

  getCardHeight: ->
    panel = @$('.collection-panel:first')
    if panel?
      panel.outerHeight()

  cardsPerRow: ->
    panel = @$('.collection-panel:first')
    panelWidth = panel.outerWidth()
    panelsPerRow = parseInt(@$().innerWidth()/panelWidth, 10)

  rowsInGrid: (cardCount) ->
    mod = cardCount % @cardsPerRow()
    addition = if mod > 0 then 1 else 0
    rows = parseInt(cardCount / @cardsPerRow(), 10) + addition

  rowsOfPadding: ->
    pageSize = @get('collection.pagingInfo.pageSize')
    mod = pageSize % @cardsPerRow()
    addition = if mod > 0 then 1 else 0
    rowsPerPage = parseInt(pageSize / @cardsPerRow(), 10) + addition
    rowsPerPage * (@get('currentPage') - 1)


Tent.CollectionPanelContentContainerView = Ember.ContainerView.extend
  item: null
  contentViewType: null
  collection: null
  multiSelect: false
   
  childViews: ['contentView']
  contentView: (->
    if @get('contentViewType')?
      eval(@get('contentViewType')).create
        content: @get('item')
        collection: @get('collection')
        multiSelect: @get('multiSelect')
        selection: @get('selection')
  ).property('item')

  selectionDidChange: (->
    @set('contentView.selection', @get('selection'))
  ).observes('selection','selection.@each')

  selectedDidChange: (isSelected)->
    if isSelected
      @addToSelection()
    else
      @removeFromSelection()

  addToSelection: ->
    @get('selection').pushObject(@get('item')) if not @get('selection').contains(@get('item'))
    
  removeFromSelection: ->
    @get('selection').removeObject(@get('item'))


###*
* @class Tent.CollectionPanelContentView
* This class should be extended to provide the content for a {@link #Tent.CollectionPanelView}
###
Tent.CollectionPanelContentView = Ember.View.extend
  templateName: null
  classNames: ['collection-panel-content']
  classNameBindings: ['selected']
  content: null
  multiSelect: false
  selection: []

  didInsertElement: ->
    @$().parents('.collection-panel:first').css('opacity', '1')

  selected: (->
    @get('selection')?.contains(@get('content'))
  ).property('selection', 'selection.@each')

  ###*
  * @method getLabelForField Returns a translated label for the given field name of a collections columns
  * @param {String} fieldName the field name of the column to be returned
  * @return {String} the translated label for the field
  ###
  getLabelForField: (fieldName)->
    column = @get('collection')?.getColumnByField(fieldName)
    Tent.I18n.loc(column?['title'])

  ###*
  * @method formattedValue Formats a given value using the formatter associated with a collection column definition.
  * @param {String} fieldName the field name of the column which is used to locate the formatter
  * @param {Object} value the value to be formatted
  * @return {String} the formatted value
  ###
  formattedValue: (fieldName, value) ->
    column = @get('collection')?.getColumnByField(fieldName)
    if column['formatter']?
      $.fn.fmatter[column['formatter']](value, {colModel: {formatOptions: column['formatoptions']}})
    else
      value

  click: (e)->
    if $(e.target).is('.item-selector')
      checked = $(e.target).is(':checked')
      @get('parentView').selectedDidChange(checked)




