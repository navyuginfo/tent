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

  ###*
  * @property {Boolean} fetchPersonalizationsOnCreation Instruct the collection to load its personalizations from the 
  * server when it is instantiated.
  ###
  fetchPersonalizationsOnCreation: true
  personalizationCategory: 'collection'
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
  personalizations: []
  personalizationType: null
  personalizationGroup: null

  personalizationSubCategory: (->
    type = @get('personalizationType')
    if type? then type else @get('dataType')
  ).property('dataType', 'personalizationType')

  init: ->
    @_super()
    @set('customizationName', @get('defaultName') or "")
    @set('personalizationsRecord', @fetchPersonalizations())

  personalizationsRecordDidChange: (->
    if @get('personalizationsRecord').toArray().length > 0
      @set('personalizations', @get('personalizationsRecord').toArray()) 
    else
      @set('personalizations', [])
  ).observes('personalizationsRecord','personalizationsRecord.@each')

  saveUIState: (name) ->
    if name?
      name=name.trim()
      @set('customizationName', name)
    uiState = $.extend(true, {}, @gatherGridData(@get('customizationName')))
    @savePersonalization(name, uiState)
    @addPersonalizationToCollection(name, uiState)

  savePersonalization: (name, uiState)->
    @set('newRecord', @get('store').savePersonalization('collection', @get('personalizationSubCategory'), name, uiState))

  addPersonalizationToCollection: (name, uiState) ->
    newRecord = @createPersonalizationRecordForClientSide(name, uiState)
    if newRecord?
      @removeExistingCustomization(name)
      @get('personalizations').pushObject(newRecord) 

  addReportToCollection: (report) ->
    @get('personalizations').pushObject(report) 

  saveReport: (report, callback)->
    reportName = report.get('name')
    settings = $.extend(true, {}, report.get('settings'), @gatherGridData(reportName))
    # 'callback' accepts the createdRecord as a parameter, and any lifecycle listeners should be defined in the callback.
    newRecord = @get('store').savePersonalization('report', report.get('subcategory'), reportName, settings, callback, report.get('group'))
    
  removeExistingCustomization: (name)->
    for p, index in @get('personalizations')
      if p.get('name') == name
        @get('personalizations').splice(index,1)
        return

  createPersonalizationRecordForClientSide: (name, uiState)->
    # To be implemented by application collection

  #storeFinished: (->
  #  r = @get('newRecord')
  #).observes('newRecord', 'newRecord.@each')

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
    @get('store').fetchPersonalizationsWithQuery(
      category: @get('personalizationCategory')
      subcategory: @get('personalizationSubCategory').toString()
      group: @get('personalizationGroup')
    )

  isShowingDefault: (->
    return @get('customizationName') == @get('defaultName')
  ).property('customizationName')

  getPersonalizationFromName: (name) ->
    matches = @get('personalizations').filter((item)=> item.get('name') ==  name)
    matches[0] if matches.length > 0

  getSelectedPersonalization: ->
    @getPersonalizationFromName(@get('customizationName'))


