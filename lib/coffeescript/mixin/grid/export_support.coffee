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

  getVisibleColumns: (custom = false)->
    #custom = true, gives the column names as displayed on UI
    visibleColumns = @getColModel().filter (column) ->
      (column.name isnt 'cb') and (not column.hidden)
    visibleColumns.map (column) =>
      if custom
        userDefinedTitles = @get('columnInfo.titles')
        userDefinedTitles[column.index] or column.t
      else
        column.name.underscore()

  getExportUrl: (contentType)->
    visibleColumnString = @getVisibleColumns().join(',')
    customHeaderString = @getVisibleColumns(true).join(',')
    params = {del: ",", headers: true, quotes: true, date: @generateExportDate(), columns: visibleColumnString, custom_headers: customHeaderString}
    if (collection = @get('collection'))?
      collection.getURL(contentType, params)

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
