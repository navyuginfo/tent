# Amount Formatter

jQuery.extend $.fn.fmatter, 
	amount: (cellvalue, options, rowdata) ->
		Tent.Formatting.amount.format(cellvalue)

jQuery.extend $.fn.fmatter.amount,
	unformat: (cellvalue, options) ->
		Tent.Formatting.amount.unFormat(cellvalue)

# Date Formatter

jQuery.extend $.fn.fmatter, 
	date: (cellvalue, options, rowdata) ->
		Tent.Formatting.date.format(cellvalue)

jQuery.extend $.fn.fmatter.date,
	unformat: (cellvalue, options) ->
		Tent.Formatting.date.unFormat(cellvalue)



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

Tent.JqGrid.editOptions =
	'amount': {}

Tent.JqGrid.editRules =
	'amount': {custom: true, custom_func: Tent.JqGrid.Validators.amount} 
