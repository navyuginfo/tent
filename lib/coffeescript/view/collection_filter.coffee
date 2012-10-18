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
    @set('currentFilter', {
      name: ""
      label: ""
      description: ""
      values: {id:{}}
    })
  
  filter: ->
    @get('collection').filter(@get('currentFilter'))

  selectedFilterDidChange: (->
    if @get('selectedFilter')?
      #@set('currentFilter.values', $.extend({}, @get('selectedFilter.values')))
      @set('currentFilter', Ember.copy(@get('selectedFilter'), true))

  ).observes('selectedFilter')

  saveFilter: ->
    @get('collection').saveFilter(@get('currentFilter'))
    @set('selectedFilter', @get('currentFilter'))
    return true

  currentFilterDidChange: (->
    console.log @get('currentFilter.values.id.data')
  ).observes('currentFilter', 'currentFilter.@each')

Tent.FilterDefinition = Ember.Object.extend
  name: ""
  label: ""
  description: ""
  values: {id: "51",title: ""}