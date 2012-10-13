# Amount Edit Formatter
jQuery.extend $.fn.fmatter, 
	amount: (cellvalue, opts, cell) ->
		if not cellvalue
			cellvalue = $('input', cell).attr('value') or 0
		Tent.Formatting.amount.format(cellvalue)

jQuery.extend $.fn.fmatter.amount,
	unformat: (cellvalue, options, cell) ->
		if not cellvalue
			cellvalue = $('input', cell).attr('value')
		Tent.Formatting.amount.unformat(cellvalue) or ""

jQuery.extend $.fn.fmatter.amount,
	formatCell: (cellvalue, options, cell) ->
		input = $('input', cell)
		cellvalue = input.attr('value')
		input.val(Tent.Formatting.amount.format(cellvalue) or "")


# Date Formatter
jQuery.extend $.fn.fmatter, 
	date: (cellvalue, options, rowdata) ->
		Tent.Formatting.date.format(cellvalue)

jQuery.extend $.fn.fmatter.date,
	unformat: (cellvalue, options) ->
		Tent.Formatting.date.unformat(cellvalue)


#	checkboxEdit Formatter
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
		dataEvents: [
			{ 
				type: 'blur', 
				fn: (e) -> 
					Ember.View.views[$(this).parents('.tent-jqgrid').attr('id')].saveEditableCell(this)
					$(this).val(Tent.Formatting.amount.format($(this).val()))
			}
		]
	}
	'checkbox': {value:"True:False", disabled: false}

Tent.JqGrid.editRules =
	'amountEdit': {custom: true, custom_func: Tent.JqGrid.Validators.amount} 
