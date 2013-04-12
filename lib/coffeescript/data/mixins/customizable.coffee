###
This mixin allows UI state to be stored by the user, and restored automatically the next time the user uses
the same collection


The json data we expect is:

paging: {
  pageSize: 12
}
sorting: {
  field: 'title'
  asc: 'desc'
}
column: {
  titles: {
    duration: 'Time Elapsed'
  }
  widths: {
    id: 5
    title: 35
    duration: 10
    percentcomplete: 10
    effortdriven: 10
    start: 10
    finish: 10
    completed: 10
  }
  order: {
    id: 1
    title: 3
    duration: 2
    percentcomplete: 4
    effortdriven: 5
    start: 6
    finish: 7
    completed: 8
  }
  hidden: {
    start: true
    finish: true
  }
}
grouping: {
  columnName: 'duration'
  type: 'exact'
}

###

Tent.Data.Customizable = Ember.Mixin.create
  isCustomizable: true  #Allows the user to store and retrieve the current state of the collection (and UI properties such as grouping/column visibility etc)
  defaultName: Tent.I18n.loc 'tent.jqGrid.saveUi.defaultName'
  defaultPersonalization: 
    customizationName: Tent.I18n.loc 'tent.jqGrid.saveUi.defaultName'
    paging: {}
    sorting: {}
    columns: 
      titles: {}
      widths: {}
      order: {}
      hidden: {}
    grouping: {}
    filtering: {
      availableFilters: []
    }

  init: ->
    @_super()
    @set('customizationName', @get('defaultName'))
    @set('personalizationsRecord', @fetchPersonalizations())

  personalizationsRecordDidChange: (->
    @set('personalizations', @get('personalizationsRecord').toArray()) if @get('personalizationsRecord').toArray().length > 0
  ).observes('personalizationsRecord','personalizationsRecord.@each')

  saveUIState: (name) ->
    @set('customizationName', name) if name?
    uiState = @gatherGridData(@get('customizationName'))
    @set('newRecord', @get('store').savePersonalization('collection', @get('dataType'), name, uiState))
    if not @customizationAlreadyExists(name)
      newRecord = @createPersonalizationRecordForClientSide(name, uiState)
      @get('personalizations').pushObject(newRecord) if newRecord?

  customizationAlreadyExists: (name)->
    exists = false
    for p in @get('personalizations').toArray()
      if p.get('name') == name
        exists = true
    exists

  createPersonalizationRecordForClientSide: (name, uiState)->
    # To be implemented by application collection

  storeFinished: (->
    r = @get('newRecord')
  ).observes('newRecord', 'newRecord.@each')
    
  gatherGridData: (name)->
    state = $.extend(
      {customizationName: name},
      {paging: @get('pagingInfo')},
      {sorting: @get('sortingInfo')},
      {filtering: @get('filteringInfo')}
      {columns: @get('columnInfo')}
      {grouping: @get('groupingInfo')}
    )

  fetchPersonalizations: ->
    @get('store').fetchPersonalizations('collection', @get('dataType'))

  isShowingDefault: (->
    return @get('customizationName') == @get('defaultName')
  ).property('customizationName')


