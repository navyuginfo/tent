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
						<li><a href="#{@get('collection').getURL('xlsx')}">#{Tent.I18n.loc("jqGrid.export.xlsx")}</a></li>
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
													<option value="">Please Select</option>  
													<option value="," selected>COMMA</option>
													<option value="|">PIPE</option>
													<option value=";">SEMI COLON</option>
													<option value=":">COLON</option>
												</select>
											</div>
										</div>            
										<div class="control-group">
											<label class="control-label">or</label>
										</div>                     
										<div class="control-group">
											<label class="control-label">Enter Delimiter</label>
											<div class="controls">
												<input type="text" name="customDelimiter" id="customDelimiter"  maxlength="1" class="input-small">
											</div>
										</div>
										<div class="control-group">
											<label class="control-label">Column Headers</label>
											<div class="controls">
												<label class="radio inline">
													<input type="radio" name="columnHeaders" value="true" checked>On
												</label>
												<label class="radio inline">
													<input type="radio" name="columnHeaders" value="false">Off
												</label>  
											</div>
										</div>        
										<div class="control-group">
											<label class="control-label">Include Quotes</label>
											<div class="controls">
												<label class="radio inline">
													<input type="radio" name="includeQuotes" value="true" checked>On
												</label>
												<label class="radio inline">
													<input type="radio" name="includeQuotes" value="false">Off
												</label>  
											</div>
										</div>                                  
										<div class="control-group">
											<div class="controls">
												<button type="button" class="btn">Export</button>
											</div>
										</div>

									</form>
								</li>
							</ul>
						</li>              
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
				document.location.href =  @get('collection').getURL(extension, delimiter, columnHeaders, includeQuotes)     

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


