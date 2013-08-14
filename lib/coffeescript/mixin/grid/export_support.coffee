###*
* @class Tent.Grid.ExportSupport
* Adds export functionality to a grid
###

Tent.Grid.ExportSupport = Ember.Mixin.create
  ###*
  * @property {Boolean} showExportButton Display a button in the header which allows the table data to
  * be exported to a selected format.
  ###
  showExportButton: true

  ###*
  * @property {Array} enabledExports The list of export types which are allowed
  * Any types listed here will appear as options in the grids Exports dropdown.
  ###
  enabledExports: ['xls', 'csv', 'json']

  addNavigationBar: ->
    @_super()

  getVisibleColumns: (custom = false)->
    #custom = true, gives the column names as displayed on UI
    visibleColumns = @getColModel().filter (column) ->
      (column.name isnt 'cb') and (not column.hidden)
    visibleColumns.map (column) =>
      if custom
        userDefinedTitles = @get('collection.columnInfo.titles')
        userDefinedTitles[column.index] or column.t
      else
        column.name.underscore()

  getExportUrl: (contentType)->
    visibleColumnString = @getVisibleColumns().join(',')
    customHeaderString = @getVisibleColumns(true).join(',')
    params = {del: ",", headers: true, quotes: true, date: @generateExportDate(), columns: visibleColumnString, custom_headers: customHeaderString}
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
      str = if customParams.headers and customParams.quotes then "\'" else ""
      del = if customParams.quotes then "\'" + customParams.del + "\'" else customParams.del
      for key, value of obj
        arr.push(value)
        str += key + del if customParams.headers
      orderedData.push(arr);
  
    if customParams.headers
      n = if customParams.quotes then -2 else -1
      str  = str.slice(0,n) + "\r\n"
  
    orderedData.forEach (row)->
      str += "\'" if customParams.quotes 
      str += row.join(del) 
      str += if customParams.quotes then "\' \r\n" else "\r\n"
    str

  generateExportDate: ->
    Tent.Formatting.date.format((new Date()), "dd-M-yy hh-mm tz")

  getPersonalizedData: (data, customParams)->
    #data needs to hava a column known as currency in case it has amount columns or it will
    #be rounded off to 2 decimal places by default 
    precision = 2
    if data[0]['currency']
      precision = Tent.CURRENCIES_ISO_4217[data[0]['currency']].cent
    personalizedData = []
    columns = customParams.columns.split(',')
    customHeaders = customParams.custom_headers.split(',')
    for obj in data
      personalizedObject = {}
      for index in [0 .. columns.length-1]
        if typeof (value = obj[Ember.String.camelize(columns[index])]) is "number"
          value = value.toFixed(precision)
        personalizedObject[customHeaders[index]] = value
      personalizedData.pushObject(personalizedObject)
    personalizedData