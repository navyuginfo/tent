# Amount Formatter
jQuery.extend $.fn.fmatter, 
	amountEdit: (cval, opts) ->
		cval = Tent.Formatting.amount.format(cval)
		'<input type="text" value="'+ cval+'" data-formatter="amountEdit" onblur="Ember.View.views[$(this).parents(\'.tent-jqgrid\').attr(\'id\')].saveEditableCell(this)"/>'

jQuery.extend $.fn.fmatter.amountEdit,
	unformat: (cellvalue, options, cell) ->
		$('input', cell).attr('value')


jQuery.extend $.fn.fmatter, 
	amount: (cellvalue, options, rowdata) ->
		Tent.Formatting.amount.format(cellvalue)

jQuery.extend $.fn.fmatter.amount,
	unformat: (cellvalue, options) ->
		Tent.Formatting.amount.unformat(cellvalue) or "" 

# Date Formatter

jQuery.extend $.fn.fmatter, 
	date: (cellvalue, options, rowdata) ->
		Tent.Formatting.date.format(cellvalue)

jQuery.extend $.fn.fmatter.date,
	unformat: (cellvalue, options) ->
		Tent.Formatting.date.unformat(cellvalue)

#jQuery.extend $.fn.fmatter, 
#	checkbox: (cellvalue, options, rowdata) ->
#		Tent.Formatting.date.format(cellvalue)

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
		'<input type="checkbox" ' + bchk  + ' value="'+ cval+'" offval="no" data-formatter="checkboxEdit" onchange="Ember.View.views[$(this).parents(\'.tent-jqgrid\').attr(\'id\')].saveEditableCell(this)" tabindex="0"/>'

jQuery.extend $.fn.fmatter.checkboxEdit,
	unformat: (cellvalue, options, cell) ->
		$('input', cell).is(':checked')

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
	'checkbox': 'checkbox'

Tent.JqGrid.editOptions =
	'amount': {}
	'checkbox': {value:"True:False", disabled: false}

Tent.JqGrid.editRules =
	'amount': {custom: true, custom_func: Tent.JqGrid.Validators.amount} 
