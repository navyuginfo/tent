require '../template/collection_filter'
require '../mixin/toggle_visibility'

###*
* @class Tent.CollectionFilter
*
* Displays a filter panel which will apply the filter choices to a collection.
*
*
* ##Usage
*
*               {{view Tent.CollectionFilter 
                  collectionBinding="Pad.remoteCollection"
                 }} 
###

Tent.CollectionFilter = Ember.View.extend Tent.ToggleVisibility, 
  ###*   
  * @property {Tent.Collection} collection The collection which is to be filtered
  ###
  collection: null    
  templateName: 'collection_filter'  
  classNames: ['tent-filter'] 
  availableFiltersBinding: 'collection.filteringInfo.availableFilters'
  fieldsHaveRendered: false

  currentFilter: 
    name: ""
    label: ""
    description: ""
    values: []

  init: ->
    @_super()
    @populateFilterFromCollection()

  didInsertElement: ->
    @set('grid', @get('parentView.grid'))
    @setupToggling()
  
  setupToggling: ->
    widget = @
    @$(".open-dropdown").click((e)->
      widget.toggleVisibility()
    )

    @$(".filter-panel .close-panel .btn").click(->
      widget.closeFilterPanel()
    )

  toggleVisibility: ->
    component = @.$(".dropdown-menu")
    source = @$(".open-dropdown")

    if component.css('display')=='none'
      @set('isShowing', true)
      component.css('display', 'block')
      source.addClass('active')
    else
      @set('isShowing', false)
      component.css('display', 'none')
      source.removeClass('active')

  filteringInfoDidChange: (->
    # Update currentFilter when the collection filter is changed
    @populateFilterFromCollection()
  ).observes('collection.filteringInfo')

  populateFilterFromCollection: ->
    if @get('collection.filteringInfo')? and @get('collection.filteringInfo.selectedFilter')?
      for filter in @get('collection.filteringInfo.availableFilters')
        if filter.name == @get('collection.filteringInfo.selectedFilter')
          selectedFilter = filter
          @set('currentFilter.name', selectedFilter.name)
          @set('currentFilter.label', selectedFilter.label)
          @set('currentFilter.description', selectedFilter.description)
          @set('currentFilter.values', selectedFilter.values)
          @ensureAllFieldsRepresented()

  # We want the current filter to contain all fields, not just those with values
  ensureAllFieldsRepresented: ->
    filter = @get('currentFilter')
    for column in @get('collection.columnsDescriptor')
      if column.filterable!=false
        if not @get('collection').getFilterValueForColumn(column.name)
          @get('collection').createBlankFilterFieldValue(column.name)

  clearFilter: ->
    @clearView(@)

  clearView: (parentView)->
    for view in parentView.get('childViews')
      view.clear() if view.clear?
      @clearView(view) if view.get('childViews')?

  filter: ->
    @stopGroupingOnGrid()
    @get('collection').doFilter(@get('currentFilter'))
    @closeFilterPanel()

  closeFilterPanel: ->
    @toggleVisibility()
    # @hideComponent(widget.$(".dropdown-menu"))

  showFilterFields: (->
    #  # For IE, prevent script timeout by loading the filter panel when it is shown,
    #  # rather than when the grid is loaded.
    @get('fieldsHaveRendered') or @get('isShowing')
  ).property('fieldsHaveRendered', 'isShowing')

  stopGroupingOnGrid: ->
    @get('grid').clearAllGrouping() if @get('grid')?

  saveFilter: ->
    @get('collection').saveFilter(@get('currentFilter'))
    @set('dropdownSelection', {name: @get('currentFilter').name, label:@get('currentFilter').label})
    return true

  newFilter: ->
    @clearFilter()

  collapsiblePanel: (->
    "#" + @get('elementId') + ' .filter-details'
  ).property()

  doSearch: ->
    @get('collection').search(@get('searchValue'))


Tent.FilterDefinition = Ember.Object.extend
  name: ""
  label: ""
  description: ""
  values: []


Tent.FilterFieldsView = Ember.ContainerView.extend
  classNames: ['form-horizontal']
  collection: null
  collectionFilterBinding: 'parentView'
  fieldsHaveRendered: false

  init: ->
    @_super()
    @set('collectionFilter', @get('parentView'))
    @populateContainer()

  populateContainer: ()->
    if @get('collection.columnsDescriptor')?
      for column in @get('collection.columnsDescriptor')
        # IE8 : processing of filter fields was triggering a script timeout.
        # Wrap in setTimeout to avoid this. 
        # TODO: review for later removal
        (()=>
          col = column # use a local closure to ensure that the setTimeout gets each column rather than just the last one.
          setTimeout(=>
            if col.filterable!=false
              fieldView = @generateField(col)
              @get('childViews').pushObject(fieldView) if fieldView?
              @set('fieldsHaveRendered')
          ,10)
        )()

  fieldsHaveRenderedDidChange: (->
    @get('collectionFilter').set('fieldsHaveRendered', true)
  ).observes('fieldsHaveRendered')
  
  generateField: (column)->
    fieldView = null
    switch column.type
      when "string"
        fieldView = Tent.TextField.create
          label: Tent.I18n.loc(column.title) 
          isFilter: true 
          valueBinding: "parentView.collectionFilter.currentFilter.values." + column.name + ".data" 
          filterOpBinding: "parentView.collectionFilter.currentFilter.values." + column.name + ".op" 
          filterBinding: "parentView.collectionFilter.currentFilter"
          field: column.name
      when "date", "utcdate"
        fieldView = Tent.DateRangeField.create
          label: Tent.I18n.loc(column.title) 
          isFilter: true 
          valueBinding: "parentView.collectionFilter.currentFilter.values." + column.name + ".data" 
          closeOnSelect:true
          arrows:true
          filterOpBinding: "parentView.collectionFilter.currentFilter.values." + column.name + ".op" 
          dateFormat: "yy-mm-dd"
      when "number", "amount"
        fieldView = Tent.NumericTextField.create
          label: Tent.I18n.loc(column.title) 
          isFilter: true 
          serializer: Tent.Formatting.number.serializer
          rangeValueBinding: "parentView.collectionFilter.currentFilter.values." + column.name + ".data" 
          filterOpBinding: "parentView.collectionFilter.currentFilter.values." + column.name + ".op" 
          filterBinding: "parentView.collectionFilter.currentFilter"
          field: column.name
      when "boolean"
        fieldView = Tent.Checkbox.create
          label: Tent.I18n.loc(column.title) 
          isFilter: true 
          checkedBinding: "parentView.collectionFilter.currentFilter.values." + column.name + ".data" 
          filterOpBinding: "parentView.collectionFilter.currentFilter.values." + column.name + ".op" 
          filterBinding: "parentView.collectionFilter.currentFilter"
          field: column.name

    return fieldView

