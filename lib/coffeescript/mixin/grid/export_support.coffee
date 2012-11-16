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
		tableDom = @getTableDom()
		@renderExportButton(tableDom)

	renderExportButton: (tableDom)->
		if @get('showExportButton') 
			# Ensure that the caption header is displayed
			if not @get('title')?
				tableDom.setCaption('&nbsp;')

			button = """
				<div class="btn-group export">
					<a class="" data-toggle="dropdown" href="#">
					Export
					<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a class="export-json">#{Tent.I18n.loc("jqGrid.export.json")}</a></li>
						<li><a class="export-xml">#{Tent.I18n.loc("jqGrid.export.xml")}</a></li>
						<li><a class="export-csv">#{Tent.I18n.loc("jqGrid.export.csv")}</a></li>
                        <li><a href="#{if @get('collection')? then @get('collection').getURL('xlsx')}">#{Tent.I18n.loc("jqGrid.export.xlsx")}</a></li>
					</ul>
				</div>
			"""
			@$(".ui-jqgrid-titlebar").append(button)

			@$('a.export-json').click =>
				ret = $.fn.xmlJsonClass.toJson(tableDom.getRowData(),"data","    ",true)
				@clientDownload(ret)
		 
			@$('a.export-xml').click =>
				ret = "<root>" + $.fn.xmlJsonClass.json2xml(tableDom.getRowData(),"    ")+"</root>"
				@clientDownload(ret)

			@$('a.export-csv').click =>
				ret = @exportCSV(tableDom.getRowData(), @getColModel())
				@clientDownload(ret)


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


