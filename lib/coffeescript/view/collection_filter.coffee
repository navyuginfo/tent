require '../template/collection_filter'

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

Tent.CollectionFilter = Ember.View.extend
  ###*
  * @property {Tent.Collection} collection The collection which is to be filtered
  ###
  collection: null

  templateName: 'collection_filter'
  classNames: ['tent-filter', 'clearfix']
  availableFiltersBinding: 'collection.filteringInfo.availableFilters'
  selectedDropdownFilterBinding: 'collection.selectedFilter'

  init: ->
    @_super()
    @createEmptyFilter()
    @populateFilterFromCollection()

  createEmptyFilter: ->
    @set('currentFilter', {
      name: ""
      label: ""
      description: ""
    })
    @set('currentFilter.values', {})

    if @get('collection.columnsDescriptor')?
      @clearFilter()
    
  populateFilterFromCollection: ->
    if @get('collection.filteringInfo')? and @get('collection.filteringInfo.selectedFilter')?
      for filter in @get('collection.filteringInfo.availableFilters')
        if filter.name == @get('collection.filteringInfo.selectedFilter')
          selectedFilter = filter
          @set('currentFilter', Ember.copy(selectedFilter, true))
          @ensureAllFieldsRepresented()

  # We want the current filter to contain all fields, not just those with values
  ensureAllFieldsRepresented: ->
    filter = @get('currentFilter')
    for column in @get('collection.columnsDescriptor')
      if column.filterable!=false
        if not filter.values[column.name]?
          @set('currentFilter.values.' + column.name, {field:column.name, op:"", data:""})

  clearFilter: ->
    currentFilter = @get('currentFilter')
    @set('currentFilter.name', "")
    @set('currentFilter.label', "")
    @set('currentFilter.description', "")
    for column in @get('collection.columnsDescriptor')
      if column.filterable!=false
        @set('currentFilter.values.' + column.name, {field:column.name, op:"", data:""})

  didInsertElement: ->
    @closeFilterPanel()

  filter: ->
    @get('collection').filter(@get('currentFilter'))
    @closeFilterPanel()
    #@$('.summary-panel .toggle').click()

  selectedFilterDidChange: (->
    if @get('selectedDropdownFilter')?
      @set('currentFilter', Ember.copy(@get('selectedDropdownFilter'), true))
      @filter()
  ).observes('selectedDropdownFilter')

  saveFilter: ->
    @get('collection').saveFilter(@get('currentFilter'))
    #@closeSaveFilterDialog()
    return true

  closeFilterPanel: ->
    @$('.filter-details').collapse('hide')

  closeSaveFilterDialog: ->
    Ember.View.views[@$('.filter-details .tent-modal').attr('id')].hide()

  collapsiblePanel: (->
    "#" + @get('elementId') + ' .filter-details'
  ).property()

  doSearch: ->
    @get('collection').search(@get('searchValue'))



  #getFilterForField: (field) ->
  #  for filter in @get('currentFilter.values')
  #      return filter if filter.field==field

Tent.FilterDefinition = Ember.Object.extend
  name: ""
  label: ""
  description: ""
  values: {id: "51",title: ""}


Tent.FilterFieldsView = Ember.ContainerView.extend
  childViews: ['filtersView']
  classNames: ['form-horizontal']
  collection: null

  filtersView: (->
    c = Ember.ContainerView.create()
    @populateContainer(c)
    return c
  ).property()

  populateContainer: (c)->
    if @get('collection.columnsDescriptor')?
      for column in @get('collection.columnsDescriptor')
        fieldView = null
        if column.filterable!=false
          switch column.type
            when "string"
              fieldView = Tent.TextField.create
                label: Tent.I18n.loc(column.title) 
                isFilter: true 
                valueBinding: "parentView.parentView.parentView.currentFilter.values." + column.name + ".data" 
                filterOpBinding: "parentView.parentView.parentView.currentFilter.values." + column.name + ".op" 
                filterBinding: "parentView.parentView.parentView.currentFilter"
                field: column.name
            when "date", "utcdate"
              fieldView = Tent.DateRangeField.create
                label: Tent.I18n.loc(column.title) 
                isFilter: true 
                valueBinding: "parentView.parentView.parentView.currentFilter.values." + column.name + ".data" 
                closeOnSelect:true
                arrows:true
                #filterOpBinding: "parentView.parentView.parentView.currentFilter.values." + column.name + ".op" 
                #filterBinding: "parentView.parentView.parentView.currentFilter"
                #field: column.name
            when "number", "amount"
              fieldView = Tent.NumericTextField.create
                label: Tent.I18n.loc(column.title) 
                isFilter: true 
                rangeValueBinding: "parentView.parentView.parentView.currentFilter.values." + column.name + ".data" 
                filterOpBinding: "parentView.parentView.parentView.currentFilter.values." + column.name + ".op" 
                filterBinding: "parentView.parentView.parentView.currentFilter"
                field: column.name
            when "boolean"
              fieldView = Tent.Checkbox.create
                label: Tent.I18n.loc(column.title) 
                isFilter: true 
                checkedBinding: "parentView.parentView.parentView.currentFilter.values." + column.name + ".data" 
                filterOpBinding: "parentView.parentView.parentView.currentFilter.values." + column.name + ".op" 
                filterBinding: "parentView.parentView.parentView.currentFilter"
                field: column.name

          c.get('childViews').pushObject(fieldView) if fieldView?
