require '../template/jqgrid_header'
require '../template/jqgrid_export'

Tent.JqGridHeaderView = Ember.View.extend
  classNames: ['grid-header', 'ui-jqgrid-titlebar', 'ui-widget-header', 'ui-helper-clearfix']
  templateName: 'jqgrid_header'

  exportView: Ember.View.extend
    classNames: ['btn-group', 'export', 'jqgrid-title-button']
    templateName: 'jqgrid_export'
    didInsertElement: ->
      grid = @get('view.parentView.parentView')
      tableDom = grid.getTableDom()
      unless grid.get('jsonUrl')?
        @$('a.export-json').click =>
          ret = '{ "exportDate": "'+grid.generateExportDate()+'",\n'+$.fn.xmlJsonClass.toJson(tableDom.getRowData(),"data","    ",true)+'}'
          grid.clientDownload(ret)

      @$('a.export-xml').click =>
        ret = "<root>    <exportDate>"+grid.generateExportDate()+"</exportDate>    " + $.fn.xmlJsonClass.json2xml(tableDom.getRowData(),"    ")+"</root>"
        grid.clientDownload(ret)

      unless grid.get('csvUrl')?
        @$('a.export-csv').click =>
          ret = 'exportDate \n'+grid.generateExportDate()+'\n'+ grid.exportCSV(tableDom.getRowData(), grid.getColModel())
          grid.clientDownload(ret)

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
        customParams = { del: delimiter, headers: columnHeaders, quotes: includeQuotes, date: grid.generateExportDate()};
        return document.location.href = grid.get('collection').getURL(extension, customParams);

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
