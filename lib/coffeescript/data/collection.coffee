require './mixins/pager'
require './mixins/sorter'
require './mixins/columninfo'
require './mixins/filter'
require './mixins/grouping_support'
require './mixins/group_pager'
require './mixins/search_support'
require './mixins/export_support'
require './mixins/customizable'

###*
* @class Tent.Data.Collection
* An object used to wrap an array of objects, with a facade for paging, sorting and filtering, 
###
Tent.Data.Collection = Ember.ArrayController.extend Tent.Data.Pager, Tent.Data.GroupPager, Tent.Data.Sorter, Tent.Data.ColumnInfo, Tent.Data.Filter, Tent.Data.ExportSupport, Tent.Data.Customizable, Tent.Data.SearchSupport, Tent.Data.ExportSupport,
  content: null
  dataType: null
  data: []
  serverPaging: false
  liveStreaming: false
  store: null
  personalizable: true
  isLoadable: false #Does the collection have a 'isLoaded' state
  REQUEST_TYPE: {'ALL': 'all'}

  init: ->
    @_super()

  # This is currently returning a plain array of the stripped down model (only displayed columns are included)
  dataChanged: (->
    @set('totals', @get('gridTotalsData'))
    @set('content', @get('gridData'))
  ).observes('modelData', 'modelData.totals')

  # Convert Ember model to deep Object
  gridData: (->
    grid = []
    for model in @get('modelData')
      item = {"id" : model.get('id')}
      for column in @get('columnsDescriptor')
        item[column.field] = model.get(column.field) if column.field
      grid.push(item)
    grid
  ).property('modelData')

  gridTotalsData: (->
    totals = []
    if @get('modelData.totals')?
      for totalsRow in @get('modelData.totals')
        newRow = {}
        for own key,value of totalsRow
          newKey = key.split('_sum')[0]
          newRow[newKey] = if value==false then null else value
        totals.push(newRow)
    totals
  ).property('modelData.totals')

  isLoaded: (->
    @get('modelData.isLoaded')
  ).property('modelData.isLoaded')

  columnsDescriptor: (->
    @get('store').getColumnsForType(@get('dataType'))
  ).property('dataType')

  ###*
  *  @method getColumnByField Return a column given a fieldName
  *   @param {String} fieldName the field name of the column to be returned
  ###
  getColumnByField: (fieldName)->
    @get('columnsDescriptor').filter((item)->
      item['name'] == fieldName
    )[0]

  update: (requestType)->
    if @get('dataType')? && @get('store')?
      query = $.extend(
        {}, 
        {type: requestType}, 
        {paging: @get('pagingInfo')},
        {sorting: @getSortingInfo()},
        {filtering: @getFilteringInfo()}
        {grouping: @getGroupingInfo()}
        {searching: @getSearchingInfo()}
      )
      # Add support for asynch calls later  
      response = @get('store').findQuery(eval(@get('dataType')), query)
      @set('modelData', response.modelData)
      @updatePagingInfo(response.pagingInfo)

