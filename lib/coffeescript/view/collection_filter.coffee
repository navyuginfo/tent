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
    @set('currentFilter', Ember.Object.create
      name: ""
      label: ""
      description: ""
    )
    @get('currentFilter').set('values', {})

    if @get('collection.columnsDescriptor')?
      @clearFilter()
    
  populateFilterFromCollection: ->
    if @get('collection.filteringInfo')? and @get('collection.filteringInfo.selectedFilter')?
      for filter in @get('collection.filteringInfo.availableFilters')
        if filter.name == @get('collection.filteringInfo.selectedFilter')
          selectedFilter = filter
      @set('currentFilter', Ember.copy(selectedFilter, true))
      

  clearFilter: ->
    currentFilter = @get('currentFilter')
    @set('currentFilter.name', "")
    @set('currentFilter.label', "")
    @set('currentFilter.description', "")
    for column in @get('collection.columnsDescriptor')
      @set('currentFilter.values.' + column.field, {field:column.field, op:"", data:""})

  didInsertElement: ->
    @$('.filter-details').collapse('hide')

  filter: ->
    @get('collection').filter(@get('currentFilter'))
    @$('.filter-details').collapse('hide')
    #@$('.summary-panel .toggle').click()

  selectedFilterDidChange: (->
    if @get('selectedDropdownFilter')?
      @set('currentFilter', Ember.copy(@get('selectedDropdownFilter'), true))
      @filter()
  ).observes('selectedDropdownFilter')

  saveFilter: ->
    @get('collection').saveFilter(@get('currentFilter'))
    @set('selectedFilter', @get('currentFilter'))
    @closeSaveFilterDialog()
    return true

  closeSaveFilterDialog: ->
    Ember.View.views[@$('.filter-details .tent-modal').attr('id')].hide()

  currentFilterDidChange: (->
    console.log @get('currentFilter.values.id.data')
  ).observes('currentFilter', 'currentFilter.@each')

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
                valueBinding: "parentView.parentView.parentView.currentFilter.values." + column.field + ".data" 
                filterOpBinding: "parentView.parentView.parentView.currentFilter.values." + column.field + ".op" 
                filterBinding: "parentView.parentView.parentView.currentFilter"
                field: column.field
            when "date"
              fieldView = Tent.DateRangeField.create
                label: Tent.I18n.loc(column.title) 
                isFilter: true 
                valueBinding: "parentView.parentView.parentView.currentFilter.values." + column.field + ".data" 
                filterOpBinding: "parentView.parentView.parentView.currentFilter.values." + column.field + ".op" 
                filterBinding: "parentView.parentView.parentView.currentFilter"
                field: column.field
            when "number"
              fieldView = Tent.NumericTextField.create
                label: Tent.I18n.loc(column.title) 
                isFilter: true 
                valueBinding: "parentView.parentView.parentView.currentFilter.values." + column.field + ".data" 
                filterOpBinding: "parentView.parentView.parentView.currentFilter.values." + column.field + ".op" 
                filterBinding: "parentView.parentView.parentView.currentFilter"
                field: column.field
            when "boolean"
              fieldView = Tent.Checkbox.create
                label: Tent.I18n.loc(column.title) 
                isFilter: true 
                checkedBinding: "parentView.parentView.parentView.currentFilter.values." + column.field + ".data" 
                filterOpBinding: "parentView.parentView.parentView.currentFilter.values." + column.field + ".op" 
                filterBinding: "parentView.parentView.parentView.currentFilter"
                field: column.field

          c.get('childViews').pushObject(fieldView) if fieldView?
