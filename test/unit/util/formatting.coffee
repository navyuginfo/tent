
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

test 'Amount cleanup', ->
	formatter = Tent.Formatting.amount

	equal formatter.cleanup('123,456.00'), '123,456.00', 'clean'
	equal formatter.cleanup('12sd3,abc456.00'), '123,456.00', 'alph-numerics'
	equal formatter.cleanup('1,2,3,4,5,6.00'), '123,456.00', 'invalid commas'
	equal formatter.cleanup('3456.78.9'), '3,456.78', 'two decimals'
	equal formatter.cleanup('123,456..09'), '123,456.00', 'two adjacent decimals'
	equal formatter.cleanup('123,456.011'), '123,456.01', '3 decimal places'
	equal formatter.cleanup('-12s3,4s56.00'), '-123,456.00', 'negative'
	equal formatter.cleanup('ss.09'), '0.09', 'fraction only'
	equal formatter.cleanup(123456.02), '123,456.02', 'number'
	equal formatter.cleanup(null), '', 'null'
	equal formatter.cleanup(undefined), '', 'undefined'
	equal formatter.cleanup(''), '', 'empty'

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
	
	
test 'Date formatting', ->
	#stubbing CultureInfo as it is not found during tests
	Date.CultureInfo = {formatPatterns:{}}
	formatter = Tent.Formatting.date
	equal formatter.format(new Date(2012,0,1)), '01/01/2012', 'date in mm/dd/yy format if no format is specified'
	equal formatter.format(new Date(2012,0,5), 'dd-mm-yy'), '05-01-2012', 'date in specified format'
	equal formatter.format(new Date(2012,0,5), 'dd-M-yy hh-mm tz').match(/05-Jan-2012 00:00/).length, 1, 'date in dd-M-yy hh-mm tz format'