require '../template/jqgrid_header'
require '../template/jqgrid_export'

Tent.JqGridHeaderView = Ember.View.extend
  classNames: ['grid-header', 'control-strip', 'ui-jqgrid-titlebar', 'ui-widget-header', 'ui-helper-clearfix']
  templateName: 'jqgrid_header'
  grid: null

  someExportsAreAllowed: (->
    #@get('grid.allowCsvExport') or @get('grid.allowXlsExport') or @get('grid.allowJsonExport')
    @get('grid.enabledExports')? and (@get('grid.enabledExports')?.length > 0)
  ).property()

  exportView: Ember.View.extend
    classNames: ['export button-wrapper']
    templateName: 'jqgrid_export'
    csv: 'csv'
    json: 'json'
    xls: 'xls'
    allowCsvExport: (->
      @get('parentView.grid.enabledExports').contains(@get('csv'))
    ).property('parentView.grid.enabledExports')
    allowJsonExport: (->
      @get('parentView.grid.enabledExports').contains(@get('json'))
    ).property('parentView.grid.enabledExports')
    allowXlsExport: (->
      @get('parentView.grid.enabledExports').contains(@get('xls'))
    ).property('parentView.grid.enabledExports')

    exportData: (e) ->
      contentType = e.context
      grid = @get('parentView.parentView')
      tableDom = grid.getTableDom()
      url = grid.getExportUrl(contentType)
      visibleColumnString = grid.getVisibleColumns().join(',')
      customHeaderString = grid.getVisibleColumns(true).join(',')
      customParams = { del: ',' , columns: visibleColumnString, custom_headers: customHeaderString, headers: true};
      personalizedData = grid.getPersonalizedData(tableDom.getRowData(), customParams)  

      if contentType is 'json'
        if url?
          jsonUrlPart = url.split('/').pop().split('?')[0]
          @$('.export-json').attr('download', jsonUrlPart)
        ret = '{ "exportDate": "'+grid.generateExportDate()+'",\n'+$.fn.xmlJsonClass.toJson(personalizedData,"data","    ",true)+'}'
        return grid.clientDownload(ret, contentType)

      if url?
        document.location.href = url 
      else 
        ret = 'exportDate \n'+grid.generateExportDate()+'\n'+ grid.exportCSV(personalizedData, customParams)
        grid.clientDownload(ret, contentType)

    didInsertElement: ->
      grid = @get('parentView.parentView')
      tableDom = grid.getTableDom()

      # @$('a.export-xml').click =>
      #   ret = "<root>    <exportDate>"+grid.generateExportDate()+"</exportDate>    " + $.fn.xmlJsonClass.json2xml(tableDom.getRowData(),"    ")+"</root>"
      #   grid.clientDownload(ret,'xml')


      @$('#customExportForm').click (e) =>
        e.stopPropagation()

      @$('#customExportForm').find('button').click  =>
        arry = @$('#customExportForm').serializeArray()
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
            columnHeaders = if (fd.value == "true") then true else false
          if fd.name == 'includeQuotes'
            includeQuotes = if (fd.value == "true") then true else false
            
        visibleColumnString = grid.getVisibleColumns().join(',')
        customHeaderString = grid.getVisibleColumns(true).join(',')
        customParams = { del: delimiter, headers: columnHeaders, quotes: includeQuotes, date: grid.generateExportDate(), columns: visibleColumnString, custom_headers: customHeaderString};
        url = grid.get('collection').getURL(extension, customParams)
    
        if !url
          personalizedData = grid.getPersonalizedData(tableDom.getRowData(), customParams)
          ret = 'exportDate \n'+grid.generateExportDate()+'\n'+ grid.exportCSV(personalizedData, customParams)
          grid.clientDownload(ret, extension)
        else
          return document.location.href = grid.get('collection').getURL(extension, customParams);

      @$('#delimiter').change =>
        if $('#delimiter').val().length > 0
          $('#customDelimiter').val('')
        else
          $('#delimiter').val(',') if $('#customDelimiter').val().length == 0

      if (Tent.Browsers.isIE())
        @$('.custom-export').mouseleave((e)->
          $('body').focus()
        )

        @$('.custom-export').bind('keyup', ((e)->
          if(e.keyCode == 27 || e.keyCode == 13)# escape key or enter key
            $('body').focus();
          )
        )

      @$('#customDelimiter').blur =>
        if $('#customDelimiter').val().length > 0
          $('#delimiter').val('')
        else
          $('#delimiter').val(',')
