
setup = ->
teardown = ->

module 'Tent.JqGridFormatters', setup, teardown

test 'Amount with only value passed in', ->
	formatter = $.fn.fmatter['amount']
	equal formatter.call(this, 1.0), '1.00', 'standard'
	equal formatter.call(this, null), '0.00', 'tries to look in the dom, then formats an invalid value'
	equal formatter.call(this, 0), '0.00', 'zero'
	equal formatter.call(this, undefined), '0.00', 'undefined'
	equal formatter.call(this, true), '0.00', 'true'
	equal formatter.call(this, ""), '0.00', 'empty string'

test 'Amount: Provide a dom node', ->
	formatter = $.fn.fmatter['amount']

	cell = $('<div><input value="333" /></div>')
	equal formatter.call(this, null, null, cell), '333.00', 'Dom cell passed in'
	equal formatter.call(this, 0, null, cell), '0.00', 'zero'
	equal formatter.call(this, undefined, null, cell), '333.00', 'undefined'
	equal formatter.call(this, true, null, cell), '0.00', 'true'
	equal formatter.call(this, "", null, cell), '333.00', 'empty string'

test 'Amount Unformat', ->
	formatter = $.fn.fmatter['amount']
	cell = $('<div><input value="3,333" /></div>')
	
	equal formatter.unformat('1,234.55'), 1234.55 , 'Standard'
	equal formatter.unformat(null, null, cell), 3333.00, 'Dom cell passed in'
	equal formatter.unformat(0, null, cell), 0.00, 'zero'
	equal formatter.unformat(undefined, null, cell), 3333, 'undefined'
	equal formatter.unformat(true, null, cell), 0.00, 'true'
	equal formatter.unformat("", null, cell), 3333.00, 'empty string'

test 'Amount FormatCell', ->
	formatter = $.fn.fmatter['amount']
	
	cell = $('<div><input value="3333" /></div>')
	formatter.formatCell(null,null,cell)
	equal $('input',cell).val(), "3,333.00", 'Format the cell value'

	cell = $('<div><input value="abc" /></div>')
	formatter.formatCell(null,null,cell)
	equal $('input',cell).val(), "0.00", 'Format invalid cell value'






