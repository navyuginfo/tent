# Amount Edit Formatter

###*
* @class jqgrid.formatter.amount Allows jsGrid cell content to be formatted as an amount
* This formatter should be added to a column descriptor as follows:
*       {id: "some_id", ..., formatter: "amount", formatoptions:{negative:true}}
*
* When 'negative' is set to true, then negative values will be displayed in different style to
* non-negative amounts (usually colored red).
###
partiallyLoadedCell = (options) ->
	partiallyLoadedColumns = Ember.View.views[options.gid.split("_")[0]].get("content.filteredColumns.partiallyFiltered")
	partiallyLoadedColumns.contains(options.colModel.name)

jQuery.extend $.fn.fmatter, 
	amount: (cellvalue, options, cell) ->
		if (not cellvalue) and (cellvalue != 0) and cell?
			if options?.gid and options.colModel?.name and partiallyLoadedCell(options)
				return "<span class=\"unentitled-cell\" title=\"#{Tent.I18n.loc('unentitledCellMessage')}\"></span>"
			else
				cellvalue = $('input', cell).attr('value') or 0
		formattedVal = Tent.Formatting.amount.format(cellvalue)
		if options? and options.colModel.formatoptions? and options.colModel.formatoptions.negative and cellvalue < 0
			'<span class="negative">'+formattedVal+'</span>'
		else 
			formattedVal

jQuery.extend $.fn.fmatter.amount,
	unformat: (cellvalue, options, cell) ->
		if (not cellvalue) and (cellvalue != 0) and cell?
          cellvalue = $("input", cell).attr("value") 
        Tent.Formatting.amount.unformat(cellvalue) or ""

# Format the value of a Dom element
jQuery.extend $.fn.fmatter.amount,
	formatCell: (cellvalue, options, cell) ->
		if cell?
			input = $('input', cell)
			cellvalue = $("input", cell).attr("value")
		input.val(Tent.Formatting.amount.format(cellvalue) or "")


# Number Edit Formatter
###*
* @class jqgrid.formatter.number Allows jsGrid cell content to be formatted as a number
* This formatter should be added to a column descriptor as follows:
*       {id: "some_id", ..., formatter: "number", formatoptions:{negative:true}}
*
* When 'negative' is set to true, then negative values will be displayed in different style to
* non-negative numbers (usually colored red).
###
jQuery.extend $.fn.fmatter, 
	number: (cellvalue, options, cell) ->
		if (not cellvalue) and (cellvalue != 0) and cell?
			if options?.gid and options.colModel?.name and partiallyLoadedCell(options)
				return "<span class=\"unentitled-cell\" title=\"#{Tent.I18n.loc('unentitledCellMessage')}\"></span>"
			else
				cellvalue = $('input', cell).attr('value') or 0
		formattedVal = Tent.Formatting.number.format(cellvalue)
		if options? and options.colModel.formatoptions? and options.colModel.formatoptions.negative and cellvalue < 0
			'<span class="negative">'+formattedVal+'</span>'
		else 
			formattedVal

jQuery.extend $.fn.fmatter.number,
	unformat: (cellvalue, options, cell) ->
		if (not cellvalue) and (cellvalue != 0) and cell?
			cellvalue = $('input', cell).attr('value')
		Tent.Formatting.number.unformat(cellvalue) or ""


# Percent Formatter
###*
* @class jqgrid.formatter.percent Allows jsGrid cell content to be formatted as a percentage value
* This formatter should be added to a column descriptor as follows:
*       {id: "some_id", ..., formatter: "percent"}
###
jQuery.extend $.fn.fmatter, 
	percent: (cellvalue, opts, cell) ->
		if (not cellvalue) and (cellvalue != 0) and cell?
			if opts?.gid and opts.colModel?.name and partiallyLoadedCell(opts)
				return "<span class=\"unentitled-cell\" title=\"#{Tent.I18n.loc('unentitledCellMessage')}\"></span>"
			else
				cellvalue = $('input', cell).attr('value') or 0
		Tent.Formatting.percent.format(cellvalue)

jQuery.extend $.fn.fmatter.percent,
	unformat: (cellvalue, options, cell) ->
		if (not cellvalue) and (cellvalue != 0) and cell?
			cellvalue = $('input', cell).attr('value')
		Tent.Formatting.percent.unformat(cellvalue) or ""

# Format the value of a Dom element
jQuery.extend $.fn.fmatter.percent,
	formatCell: (cellvalue, options, cell) ->
		if cell?
			input = $('input', cell)
			cellvalue = input.attr('value')
			input.val(Tent.Formatting.percent.format(cellvalue) or "")


# Date Formatter
###*
* @class jqgrid.formatter.date Allows jsGrid cell content to be formatted as date values
* This formatter should be added to a column descriptor as follows (dateFormat is optional):
*       {id: "some_id", ..., formatter: "date", formatoptions:{dateFormat: "dd-M-yy"}}
###
jQuery.extend $.fn.fmatter, 
	date: (cellvalue, options, rowdata) ->
		if options.colModel.formatoptions
			return Tent.Formatting.date.format(cellvalue, options.colModel.formatoptions.dateFormat)
		else
			return Tent.Formatting.date.format(cellvalue)


jQuery.extend $.fn.fmatter.date,
	unformat: (cellvalue, options) ->
		Tent.Formatting.date.unformat(cellvalue)

# Action Formatter
###*
* @class jqgrid.formatter.action Allows jsGrid cell content to be treated as a link.
* This formatter should be added to a column descriptor as follows (redirectColumn is optional):
*       {id: "some_id", ..., formatter: "action", .formatoptions({action: 'showNewRoute', redirectColumn: 'columnName'})
* If no column name is supplied, it will redirect to 'newRoute' with context as data of the clicked row. The clicked row is 
* searched on the basis of field 'id' in the data hash by comparing it against the clicked row Id.
* If a column name is passed with in the format options, instead of rowId, value of the given column on the clicked row is compared
* against the column value in the grid data.
* This speacial redirectColumn option is required, for complicated data such that, data with single id needs to be shown
* in different rows, with certain different column values, in that case, the 'id' for all the rows would be different
* to meet ember data needs but the actual id for that data should be stored in some other column, so that 
* appropriate processing and redirection can be done.
###
jQuery.extend $.fn.fmatter,
	action: (cellvalue, options, rowdata) ->
		#check for cell value is required because in case of totals if null is returned we don't want
		# a link with value "null" in the grid
		if cellvalue
			if options.colModel.formatoptions.redirectColumn?
		    return '<a onclick="Ember.View.views[$(this).parents(\'.tent-jqgrid\').attr(\'id\')].sendAction(\'' + options.colModel.formatoptions.action + '\', this, \'' + options.rowId + '\',\''+options.colModel.formatoptions.redirectColumn+'\')">' + cellvalue + '</a>'
			else 
				return '<a onclick="Ember.View.views[$(this).parents(\'.tent-jqgrid\').attr(\'id\')].sendAction(\'' + options.colModel.formatoptions.action + '\', this, \''+options.rowId+'\')">' + cellvalue + '</a>'

# CheckboxEdit Formatter
###*
* @class jqgrid.formatter.checkboxEdit Allows jsGrid boolean cell content to be displayed as a checkbox
* This formatter should be added to a column descriptor as follows:
*       {id: "some_id", ..., formatter: "checkboxEdit"}
###
jQuery.extend $.fn.fmatter, 
	checkboxEdit: (cval, opts) ->
		op = $.extend({},opts.checkbox)
		if opts.colModel != undefined && !$.fmatter.isUndefined(opts.colModel.formatoptions)
			op = $.extend({},op,opts.colModel.formatoptions)
		 
		if ($.fmatter.isEmpty(cval) || $.fmatter.isUndefined(cval) ) 
			cval = $.fn.fmatter.defaultFormat(cval,op)

		cval=cval+""
		cval=cval.toLowerCase()
		bchk = if cval.search(/(false|0|no|off)/i) < 0 then " checked='checked' " else ""
		'<input type="checkbox" ' + bchk  + ' value="'+ cval+'" offval="no" data-formatter="checkboxEdit" onchange="Ember.View.views[$(this).parents(\'.tent-jqgrid\').attr(\'id\')].saveEditableCell(this)"/>'

jQuery.extend $.fn.fmatter.checkboxEdit,
	unformat: (cellvalue, options, cell) ->
		$('input', cell).is(':checked')


# Select Edit formatter
###*
* @class jqgrid.formatter.selectEdit Allows jsGrid cell content to be selected from a select box dropdown
* This formatter should be added to a column descriptor as follows:
*       {id: "some_id", ..., formatter: "selectEdit", editoptions:{value: {1:'One',2:'Two',3:'Three'}}}
###
jQuery.extend $.fn.fmatter, 
	selectEdit: (cval, opts) ->
 		options = opts.colModel.editoptions.value
 		if options?
 			el = '<select data-formatter="selectEdit" onchange="Ember.View.views[$(this).parents(\'.tent-jqgrid\').attr(\'id\')].saveEditableCell(this)" >'
 			for val, text of options
 				selected = if val==cval then 'selected="selected"' else ""
	 			el += "<option value=\"#{val}\" #{selected}>" + text 
	 		el += '</select>'
	 	el

jQuery.extend $.fn.fmatter.selectEdit,
	unformat: (cellvalue, options, cell) ->
		$('select', cell).val()



# Validators for cell editing
Tent.JqGrid.Validators = Ember.Object.create
	amount: (value, colname) ->
		unformatted = Tent.Formatting.amount.unformat(value) 
		if unformatted == 0 and value != 0
			[false, Tent.Formatting.number.errorText()]
		else 
			[true]


Tent.JqGrid.editTypes =
	'amount': 'text'
	'select': 'select'
	'checkbox': 'checkbox'

Tent.JqGrid.editOptions =
	'amount': {
		dataInit: (elem)->
			$(elem).css('text-align','right') #Make this a style change!
			#field.trigger('focus')
			$(elem).keypress (event) ->
				charCode = (if (event.which) then event.which else event.keyCode)
				if charCode isnt 46 and charCode > 31 and (charCode < 48 or charCode > 57)
					false
				else
					true


		dataEvents: [
			{ 
				type: 'keyup', 
				fn: (e) -> 
					Ember.View.views[$(this).parents('.tent-jqgrid').attr('id')].saveEditableCell(this)
			},
			{
				type: 'blur',
				fn: (e) ->
					$(this).val(Tent.Formatting.amount.format($(this).val()))
			}
		]
	}
	'checkbox': {value:"True:False", disabled: false}

Tent.JqGrid.editRules =
	'amountEdit': {custom: true, custom_func: Tent.JqGrid.Validators.amount} 
