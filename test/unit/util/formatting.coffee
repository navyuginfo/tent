
setup = ->
teardown = ->

module 'Tent.Formatting', setup, teardown

test 'Amount formatting', ->
	formatter = Tent.Formatting.amount
	
	equal formatter.format(123456), '123,456.00', 'amount'
	equal formatter.format(123456.344), '123,456.34', '2 decimal places'
	equal formatter.format(123456.357), '123,456.36', '2 decimal places round up'
	equal formatter.format(-123456), '-123,456.00', 'negative'
	equal formatter.format(.34), '0.34', 'fraction only'
	equal formatter.format("123456.344"), '123,456.34', 'string'
	equal formatter.format(null), '', 'null'
	equal formatter.format(undefined), '', 'undefined'
	equal formatter.format(""), '0.00', 'empty string'

test 'Amount unformatting', ->
	formatter = Tent.Formatting.amount
	
	equal formatter.unformat('123,456.00'), 123456, 'amount' 
	equal formatter.unformat('123,456.3456'), 123456.3456, '2 decimal places not enforced'
	equal formatter.unformat('-123,456.00'), -123456, 'negative'
	equal formatter.unformat('.34'), .34, 'fraction only'
	equal formatter.unformat(123456.344), 123456.344, 'number'
	equal formatter.unformat(null), null, 'null'
	equal formatter.unformat(undefined), null, 'undefined'
	equal formatter.unformat(""), 0, 'empty string'

test 'Amount formatting with divisor', ->
	formatter = Tent.Formatting.amount
	formatter.divisor = 
		func: ->
			.01

	equal formatter.format(123456), '123,456.00', 'Divisor if .01'
	equal formatter.format(123456.344), '123,456.34', '2 decimal places'
	equal formatter.format(123456.7), '123,456.70', '2 decimal places round up'
	equal formatter.format(-123456), '-123,456.00', 'negative'
	equal formatter.format(.34), '0.34', 'fraction only'
	equal formatter.format("123456"), '123,456.00', 'string'
	equal formatter.format(null), '', 'null'
	equal formatter.format(undefined), '', 'undefined'
	equal formatter.format(""), '0.00', 'empty string'

test 'Amount unformatting with divisor', ->
	formatter = Tent.Formatting.amount
	formatter.divisor = 
		func: ->
			.01

	equal formatter.unformat('123,456.00'), 123456, 'amount' 
	equal formatter.unformat('123,456.3456'), 123456.3456, '2 decimal places not enforced'
	equal formatter.unformat('-123,456.00'), -123456, 'negative'
	equal formatter.unformat('.34'), 0.34, 'fraction only'
	equal formatter.unformat(123456.344), 123456.344, 'number'
	equal formatter.unformat(null), null, 'null'
	equal formatter.unformat(undefined), null, 'undefined'
	equal formatter.unformat(""), 0, 'empty string'

test 'Number formatting', ->
	formatter = Tent.Formatting.number

	equal formatter.format(123456), '123456', 'Number'
	equal formatter.format(123456.5434), '123456.5434', 'decimal places'
	equal formatter.format(-123456), '-123456', 'negative'
	equal formatter.format(.465), '0.465', 'fraction'
	equal formatter.format("123456"), '123456', 'string'
	equal formatter.format(null), '', 'null'
	equal formatter.format(undefined), '', 'undefined'
	equal formatter.format(""), '', 'empty string'

test 'Number unformatting', ->
	formatter = Tent.Formatting.number

	equal formatter.unformat('123456'), 123456, 'Number'
	equal formatter.unformat('123456.5434'), 123456.5434, 'decimal places'
	equal formatter.unformat('-123456'), -123456, 'negative'
	equal formatter.unformat('.465'), .465, 'fraction'
	equal formatter.unformat('0.465'), .465, 'fraction'
	equal formatter.unformat(null), null, 'null'
	equal formatter.unformat(undefined), null, 'undefined'
	equal formatter.unformat(""), null, 'empty string'

test 'Percent Formatting', ->
	formatter = Tent.Formatting.percent

	equal formatter.format(.12), '12%', 'Number'
	equal formatter.format(.1234), '12.3%', 'decimal places'
	equal formatter.format(-.1234), '-12.3%', 'negative'
	equal formatter.format(.00465), '0.5%', 'fraction'
	equal formatter.format("12.3%"), '12.3%', 'string'
	equal formatter.format(null), '', 'null'
	equal formatter.format(undefined), '', 'undefined'
	equal formatter.format(""), '', 'empty string'

test 'Percent unformatting', ->
	formatter = Tent.Formatting.percent

	equal formatter.unformat('12.3%'), .123, 'Number'
	equal formatter.unformat('12.3456%'), .123, 'decimal places'
	equal formatter.unformat('-123.456%'), -1.235, 'negative'
	equal formatter.unformat('46.5'), .465, 'fraction'
	equal formatter.unformat('0.465'), .005, 'fraction'
	equal formatter.unformat(null), null, 'null'
	equal formatter.unformat(undefined), null, 'undefined'
	equal formatter.unformat(""), null, 'empty string'
	
	
	