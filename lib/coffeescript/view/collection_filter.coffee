require '../template/collection_filter'

###*
* @class Tent.CollectionFilter
*
* Displays a filter panel which will apply the filter choices to a collection.
*
* The actual filter fields are defined by the {@link #filterTemplate} property.
*
* ##Usage
*
*               {{view Tent.CollectionFilter 
                  filterTemplate="task_collection_filter" 
                  collectionBinding="Pad.remoteCollection"
                 }} 
###

Tent.CollectionFilter = Ember.View.extend
  ###*
  * @property {Tent.Collection} collection The collection which is to be filtered
  ###
  collection: null

  ###*
  * @property {Template} filterTemplate The name of a template which is used to display the filter fields.
  *
  * The filterTemplate should reference the filter fields using the path **view.filter**
  * 
  * e.g.
  *       {{view Tent.TextField valueBinding="view.filter.id" label="ID"}}
  *       {{view Tent.TextField valueBinding="view.filter.title" label="Title"}}
  *       {{view Tent.DateField valueBinding="view.filter.start" label="Start"}}
  ###
  filterTemplate: null

  templateName: 'collection_filter'
  classNames: ['tent-filter', 'clearfix']
  availableFiltersBinding: 'collection.availableFilters'
  #selectedFilterBinding: 'collection.selectedFilter'

  init: ->
    @_super()
    @createEmptyFilter()

  createEmptyFilter: ->
    @set('currentFilter', {
      name: ""
      label: ""
      description: ""
    })
    
    values = {}
    for column in @get('collection.columnsDescriptor')
      values[column.field] = {field:column.field, op:"", data:""}
  
    @get('currentFilter')['values'] = values

  didInsertElement: ->
    #if not @get('filterTemplate')?
      #@populateContainer()
      #@get('container').appendTo(@$('.filter-details'))
      #@$('.filter-details').append(@get('container').$(''))
      #@get('container').appendTo('');

  filter: ->
    @get('collection').filter(@get('currentFilter'))
    @$('.filter-details').collapse('hide')
    #@$('.summary-panel .toggle').click()

  selectedFilterDidChange: (->
    #if @get('selectedFilter')?
      #@set('currentFilter.values', $.extend({}, @get('selectedFilter.values')))
    @set('currentFilter', Ember.copy(@get('selectedFilter'), true))
    @filter()
  ).observes('selectedFilter')

  saveFilter: ->
    @get('collection').saveFilter(@get('currentFilter'))
    @set('selectedFilter', @get('currentFilter'))
    return true

  currentFilterDidChange: (->
    console.log @get('currentFilter.values.id.data')
  ).observes('currentFilter', 'currentFilter.@each')

  collapsiblePanel: (->
    "#" + @get('elementId') + ' .filter-details'
  ).property()



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
    for column in @get('collection.columnsDescriptor')
      fieldView = null
      #filter = @getFilterForField(column.field)
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
          fieldView = Tent.DateField.create
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
