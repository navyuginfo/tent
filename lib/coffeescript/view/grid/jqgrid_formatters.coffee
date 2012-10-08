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