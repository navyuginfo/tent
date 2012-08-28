

setup = ->

teardown = ->

module 'Tent.DateField', setup, teardown

test 'Test format and unFormat', ->
	view = Tent.DateField.create()
	equal view.get('options').dateFormat, 'mm/dd/yy', 'Date format option was set'
	equal view.format(new Date()), '01/01/1970', 'Format a date'
	deepEqual view.unFormat('01/01/1970'), new Date(), 'UnFormat a date'

test 'Test Validate', ->
	view = Tent.DateField.create()
	view.set('formattedValue', '12/04/2005')
	ok view.validate(), 'Valid date string'

	view.set('formattedValue', '12/44/20045')
	ok !view.validate(), 'Invalid date string'

	view.set('formattedValue', '')
	ok view.validate(), 'Empty string is valid'