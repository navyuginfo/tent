###*
* @class Tent.Grid.ExportSupport
* Adds export functionality to a grid
###

Tent.Grid.ExportSupport = Ember.Mixin.create
  ###*
  * @property {Boolean} showExportButton Display a button in the header which allows the table data to
  * be exported a selected format.
  ###
  showExportButton: true

  addNavigationBar: ->
    @_super()

  getVisibleColumns: ->
    columns = @get('collection').gatherGridData().columns.hidden
    visibleColumns = []
    for own key, value of columns
      if key isnt "cb" and !value
        visibleColumns.push(key.underscore())
    visibleColumns

  updateExportUrls: ->
    visibleColumnString = @getVisibleColumns().join(',')
    params = {del: ",", headers: true, quotes: true, date: @generateExportDate(), columns: visibleColumnString}
    collection = @get('collection')
    for contentType in ['json', 'csv', 'xls']
      if collection?
        @set "#{contentType}Url", collection.getURL(contentType, params)
      else
        @set "#{contentType}Url", ""
    @set 'jsonUrlPart', @get('jsonUrl')?.split('/').pop().split('?')[0]

  gridDidChange: (->
    @updateExportUrls()
  ).observes(
    'collection.columnInfo',
    'collection.sortingInfo', 
    'collection.filteringInfo',
    'collection.pagingInfo',
    'collection.groupingInfo'
  )

  clientDownload: (file) ->
    # Allow the client to save the generated file.
    # For no just print to a window
    if navigator.appName != 'Microsoft Internet Explorer'
      window.open('data:text/csv;charset=utf-8,' + escape(file))
    else
      popup = window.open('', 'csv', '')
      popup.document.body.innerHTML = '<pre>' + file + '</pre>'

  exportCSV: (data, keys)->
    orderedData = [];
    for obj in data
      arr = []
      for key, value of obj
        arr.push(value)
      orderedData.push(arr);

    if @get('multiSelect')
      keys = keys[1..]

    str = ""
    str += obj.name + ',' for obj in keys
    str  = str.slice(0,-1) + '\r\n' + orderedData.join('\r\n')

  generateExportDate: ->
    Tent.Formatting.date.format((new Date()), "dd-M-yy hh-mm tz")
