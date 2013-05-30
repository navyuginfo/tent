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
    params = {del: ",", headers: true, quotes: true, date: @generateExportDate(), columns: visibleColumnString, customHeaders: customHeaderString}
    if (collection = @get('collection'))?
      collection.getURL(contentType, params)

  clientDownload: (file,type) ->
    # Allow the client to save the generated file.
    # For no just print to a window
    if navigator.appName != 'Microsoft Internet Explorer'
      # window.open('data:text/csv;charset=utf-8,' + escape(file))
      data='data:text/csv;charset=utf-8,' + escape(file)
      link=document.createElement('a')
      link.setAttribute('href',data)
      link.setAttribute('download','data.'+type)
      link.click()
    else
      popup = window.open('', 'csv', '')
      popup.document.body.innerHTML = '<pre>' + file + '</pre>'

  exportCSV: (data, customParams)->
    orderedData = [];
    for obj in data
      arr = []
      str = ""
      for key, value of obj
        arr.push(value)
        str += key + customParams.del
      orderedData.push(arr);

    str  = str.slice(0,-1) + '\r\n'
    orderedData.forEach (row)->
      str += row.join(customParams.del) + '\r\n'
    str

  generateExportDate: ->
    Tent.Formatting.date.format((new Date()), "dd-M-yy hh-mm tz")

  getPersonalizedData: (data, customParams)->
    personalizedData = []
    for obj in data
      personalizedObject = {}
      for index in [0 .. customParams.columns.length-1]
        personalizedObject[customParams.customHeaders[index]] = obj[Ember.String.camelize(customParams.columns[index])]
      personalizedData.pushObject(personalizedObject)
    personalizedData