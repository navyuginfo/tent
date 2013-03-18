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
    tableDom = @getTableDom()
    @renderExportButton(tableDom)

  renderExportButton: (tableDom)->
    if @get('showExportButton') 
      # Ensure that the caption header is displayed
      #if not @get('title')?
      #  tableDom.setCaption('&nbsp;')
      params = {del: ",", headers: true, quotes: true, date: @generateExportDate()}
      jsonUrl = if @get('collection')? then @get('collection').getURL('json',`undefined`, params['headers'],params['quotes'],params['date'])
      csvUrl = if @get('collection')? then @get('collection').getURL('csv', params['del'], params['headers'],params['quotes'],params['date'])
      xslxUrl = if @get('collection')? then @get('collection').getURL('xlsx', `undefined`, params['headers'],params['quotes'],params['date'])

      button = """
        <div class="btn-group export jqgrid-title-button">
          <a class="" data-toggle="dropdown" href="#">
            <i class="icon-share"></i>Export
          </a>
          <ul class="dropdown-menu">
            <li><a href="#{jsonUrl}" class="export-json">#{Tent.I18n.loc("tent.jqGrid.export.json")}</a></li>
            <!-- <li><a class="export-xml">#{Tent.I18n.loc("tent.jqGrid.export.xml")}</a></li> -->
            <li><a href="#{csvUrl}" class="export-csv">#{Tent.I18n.loc("tent.jqGrid.export.csv")}</a></li>
            <li><a href="#{xslxUrl}" class="export-xlsx">#{Tent.I18n.loc("tent.jqGrid.export.xlsx")}</a></li>
            <li class="divider"></li>
            <li class="dropdown-submenu-left">
              <a href="#">Delimiter</a>
              <ul class="dropdown-menu custom-export">
                <li>
                  <form class="form-horizontal well" id="customExportForm">
                    <div class="control-group">
                      <label class="control-label">Delimiter</label>
                      <div class="controls">
                          <select name="delimiter" class="input-small" id="delimiter">
                          <option value="">#{Tent.I18n.loc("tent.pleaseSelect")}</option>  
                          <option value="," selected>#{Tent.I18n.loc("tent.jqGrid.export.comma")}</option>
                          <option value="|">#{Tent.I18n.loc("tent.jqGrid.export.pipe")}</option>
                          <option value=";">#{Tent.I18n.loc("tent.jqGrid.export.semicolon")}</option>
                          <option value=":">#{Tent.I18n.loc("tent.jqGrid.export.colon")}</option>
                        </select>
                      </div>
                    </div>            
                    <div class="control-group">
                      <label class="control-label">#{Tent.I18n.loc("tent.jqGrid.export._or")}</label>
                    </div>                     
                    <div class="control-group">
                      <label class="control-label">#{Tent.I18n.loc("tent.jqGrid.export.enterDelimiter")}</label>
                      <div class="controls">
                        <input type="text" name="customDelimiter" id="customDelimiter"  maxlength="1" class="input-small">
                      </div>
                    </div>
                    <div class="control-group">
                      <label class="control-label">#{Tent.I18n.loc("tent.jqGrid.export.headers")}</label>
                      <div class="controls">
                        <label class="radio inline">
                          <input type="radio" name="columnHeaders" value="true" checked>#{Tent.I18n.loc("tent.on")}
                        </label>
                        <label class="radio inline">
                          <input type="radio" name="columnHeaders" value="false">#{Tent.I18n.loc("tent.off")}
                        </label>  
                      </div>
                    </div>        
                    <div class="control-group">
                      <label class="control-label">#{Tent.I18n.loc("tent.jqGrid.export.inclQuotes")}</label>
                      <div class="controls">
                        <label class="radio inline">
                          <input type="radio" name="includeQuotes" value="true" checked>#{Tent.I18n.loc("tent.on")}
                        </label>
                        <label class="radio inline">
                          <input type="radio" name="includeQuotes" value="false">#{Tent.I18n.loc("tent.off")}
                        </label>  
                      </div>
                    </div>                                  
                    <div class="control-group">
                      <div class="controls">
                        <button type="button" class="btn">#{Tent.I18n.loc("tent.jqGrid.export.export")}</button>
                      </div>
                    </div>

                  </form>
                </li>
              </ul>
            </li>              
          </ul>
        </div>
      """
      @$(".grid-header .header-buttons").append(button)

      unless jsonUrl?
        @$('a.export-json').click =>
          ret = '{ "exportDate": "'+@generateExportDate()+'",\n'+$.fn.xmlJsonClass.toJson(tableDom.getRowData(),"data","    ",true)+'}'
          @clientDownload(ret)

      @$('a.export-xml').click =>
        ret = "<root>    <exportDate>"+@generateExportDate()+"</exportDate>    " + $.fn.xmlJsonClass.json2xml(tableDom.getRowData(),"    ")+"</root>"
        @clientDownload(ret)

      unless csvUrl?
        @$('a.export-csv').click =>
          ret = 'exportDate \n'+@generateExportDate()+'\n'+ @exportCSV(tableDom.getRowData(), @getColModel())
          @clientDownload(ret)

      @$('#customExportForm').click (e) =>
        e.stopPropagation()

      @$('#customExportForm').find('button').click  =>
        arry = $('#customExportForm').serializeArray()
        extension = 'csv'
        delimiter = ','
        columnHeaders = true
        includeQuotes = true
        $.each arry, (i, fd) ->
          if fd.name == 'delimiter' && fd.value != ','
            extension = 'txt'
            delimiter = fd.value
          if fd.name == 'customDelimiter'
            delimiter = fd.value  if fd.value.length > 0
          if fd.name == 'columnHeaders'
            columnHeaders = fd.value
          if fd.name == 'includeQuotes'
            includeQuotes = fd.value
        document.location.href =  @get('collection').getURL(extension, delimiter, columnHeaders, includeQuotes,@generateExportDate())

      @$('#delimiter').change =>
        if $('#delimiter').val().length > 0
          $('#customDelimiter').val('')
        else
          $('#delimiter').val(',') if $('#customDelimiter').val().length == 0

      @$('#customDelimiter').blur =>
        if $('#customDelimiter').val().length > 0
          $('#delimiter').val('')
        else
          $('#delimiter').val(',')


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


