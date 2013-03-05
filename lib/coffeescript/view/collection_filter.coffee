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
  currentFilter: 
    name: ""
    label: ""
    description: ""
    values: {}

  init: ->
    @_super()
    @populateFilterFromCollection()

  didInsertElement: ->
    @closeFilterPanel()
    if @get('collection.columnsDescriptor')?
      @clearFilter()
  
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
        if not filter.values[column.name]?
          @set('currentFilter.values.' + column.name, {field:column.name, op:"", data:""})

  clearFilter: ->
    @clearView(@)

  clearView: (parentView)->
    for view in parentView.get('childViews')
      view.clear() if view.clear?
      @clearView(view) if view.get('childViews')?
    
  currentFilterDidChange: (->
    console.log('Current filter = ' + @get('currentFilter.name'))
  ).observes('currentFilter')

  currentLabel: (->
    @get('currentFilter.label')
  ).property('currentFilter','currentFilter.label')

  filter: ->
    @stopGroupingOnGrid()
    @get('collection').filter(@get('currentFilter'))
    @closeFilterPanel()

  changeFilter: ->
    @stopGroupingOnGrid()
    @get('collection').filter()
    @closeFilterPanel()  

  stopGroupingOnGrid: ->
    @get('parentView').clearAllGrouping() if @get('parentView')?

  selectedFilterDidChange: (->
    if @get('dropdownSelection')?
      @get('collection').setSelectedFilter(@get('dropdownSelection.name'))
      @populateFilterFromCollection()
      @changeFilter()
  ).observes('dropdownSelection')

  saveFilter: ->
    @get('collection').saveFilter(@get('currentFilter'))
    @set('dropdownSelection', {name: @get('currentFilter').name, label:@get('currentFilter').label})
    #@filter()
    @closeFilterPanel()
    return true

  newFilter: ->
    @clearFilter()

  closeFilterPanel: ->
    @$('.filter-details')?.collapse('hide') #existence check for unit test

  #closeSaveFilterDialog: ->
  #  Ember.View.views[@$('.filter-details .tent-modal').attr('id')].hide()

  collapsiblePanel: (->
    "#" + @get('elementId') + ' .filter-details'
  ).property()

  doSearch: ->
    @get('collection').search(@get('searchValue'))


Tent.FilterDefinition = Ember.Object.extend
  name: ""
  label: ""
  description: ""
  values: {}


Tent.FilterFieldsView = Ember.ContainerView.extend
  classNames: ['form-horizontal']
  collection: null
  collectionFilterBinding: 'parentView'

  init: ->
    @_super()
    @populateContainer()

  populateContainer: ()->
    if @get('collection.columnsDescriptor')?
      for column in @get('collection.columnsDescriptor')
        fieldView = null
        if column.filterable!=false
          switch column.type
            when "string"
              fieldView = Tent.TextField.create
                label: Tent.I18n.loc(column.title) 
                isFilter: true 
                valueBinding: "parentView.parentView.currentFilter.values." + column.name + ".data" 
                filterOpBinding: "parentView.parentView.currentFilter.values." + column.name + ".op" 
                filterBinding: "parentView.parentView.currentFilter"
                field: column.name
            when "date", "utcdate"
              fieldView = Tent.DateRangeField.create
                label: Tent.I18n.loc(column.title) 
                isFilter: true 
                valueBinding: "parentView.parentView.currentFilter.values." + column.name + ".data" 
                closeOnSelect:true
                arrows:true
                filterOpBinding: "parentView.parentView.currentFilter.values." + column.name + ".op" 
                dateFormat: "yy-mm-dd"
                #filterBinding: "parentView.parentView.parentView.currentFilter"
                #field: column.name
            when "number", "amount"
              fieldView = Tent.NumericTextField.create
                label: Tent.I18n.loc(column.title) 
                isFilter: true 
                rangeValueBinding: "parentView.parentView.currentFilter.values." + column.name + ".data" 
                #valueBinding: "parentView.parentView.parentView.currentFilter.values." + column.name + ".data" 
                filterOpBinding: "parentView.parentView.currentFilter.values." + column.name + ".op" 
                filterBinding: "parentView.parentView.currentFilter"
                field: column.name
            when "boolean"
              fieldView = Tent.Checkbox.create
                label: Tent.I18n.loc(column.title) 
                isFilter: true 
                checkedBinding: "parentView.parentView.currentFilter.values." + column.name + ".data" 
                filterOpBinding: "parentView.parentView.currentFilter.values." + column.name + ".op" 
                filterBinding: "parentView.parentView.currentFilter"
                field: column.name

          @get('childViews').pushObject(fieldView) if fieldView?
