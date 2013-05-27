setup = ->
teardown = ->

module 'Tent.JqGrid.Grouping', setup, teardown

test 'getComparator', ->
	group = Tent.JqGrid.Grouping
	ok group.getComparator('date', 'week')?, 'date/week comparator exists'

	ok group.getComparator('date', 'exact')?, 'fall back to default'

	ok group.getComparator('badxx', 'exact')?, 'fall back to string comparator'

	ok group.getComparator('date', 'xxxx')?, 'fall back to default with invalid groupType'

test 'Row Title',->
	c = Tent.JqGrid.Grouping.comparator.create()
	equal c.rowTitle('title1'), 'title1', 'Identity'
	equal c.rowTitle(null), '', 'null'
	equal c.rowTitle(undefined), '', 'undefined'

	formatter = (value)->
		'_' + value
	equal c.rowTitle('title3', formatter), '_title3', 'formatter applied'
	

test 'Boolean Ranges', ->
	group = Tent.JqGrid.Grouping
	comparator = group.getComparator('boolean','exact')
	ok comparator.compare(true, true), 'true/true'
	ok not comparator.compare(false, true), 'false/true'
	ok not comparator.compare(true, false), 'true/false'
	ok comparator.compare(false, false), 'false/false'

test 'Number Ranges - 10s', ->
	group = Tent.JqGrid.Grouping
	comparator = group.getComparator('number','10')
	ok comparator.compare(2, 6), '2/6'
	ok comparator.compare(0, 6), '0/6'
	ok not comparator.compare(0, 10), '0/10'
	ok not comparator.compare(2, 16), '2/16'
	ok comparator.compare(-39, -31), '-39/-31'
	ok comparator.compare(-50, -45), '-50/-45'

	equal comparator.rowTitle('9'), '0 - 9','9'
	equal comparator.rowTitle('97'), '90 - 99','97'
	equal comparator.rowTitle('-5'), '-10 - -1','-5'
	equal comparator.rowTitle('-10'), '-10 - -1','-5'

test 'Number Ranges - 100s', ->
	group = Tent.JqGrid.Grouping
	comparator = group.getComparator('number','100')
	ok comparator.compare(2, 60), '2/6'
	ok comparator.compare(0, 60), '0/6'
	ok not comparator.compare(0, 100), '0/100'
	ok not comparator.compare(2, 106), '2/106'
	ok comparator.compare(-199, -101), '-199/-101'
	ok comparator.compare(-500, -450), '-500/-450'

	equal comparator.rowTitle('9'), '0 - 99','9'
	equal comparator.rowTitle('97'), '0 - 99','97'
	equal comparator.rowTitle('-5'), '-100 - -1','-5'
	equal comparator.rowTitle('-100'), '-100 - -1','-5'

test 'Number Ranges - 1000s', ->
	group = Tent.JqGrid.Grouping
	comparator = group.getComparator('number','1000')
	ok comparator.compare(200, 600), '200/600'
	ok comparator.compare(0, 600), '0/600'
	ok not comparator.compare(0, 1000), '0/1000'
	ok not comparator.compare(2, 1006), '2/1006'
	ok comparator.compare(-999, -101), '-999/-101'
	ok comparator.compare(-5000, -4500), '-5000/-4500'

	equal comparator.rowTitle('650'), '0 - 999','650'
	equal comparator.rowTitle('470'), '0 - 999','97'
	equal comparator.rowTitle('-500'), '-1000 - -1','-5'
	equal comparator.rowTitle('-1000'), '-1000 - -1','-5'

test 'Date Ranges', ->
	group = Tent.JqGrid.Grouping
	comparator = group.getComparator('date','exact')
	equal comparator.rowTitle('5/5/2012'), '5/5/2012', 'exact title'
	formatter = (value)->
		$.datepicker.formatDate('mm/dd/yy', value)
	equal comparator.rowTitle(new Date('5/5/2012'), formatter), '05/05/2012', 'date value'

	###comparator = group.getComparator('date','week')
	ok comparator.compare(new Date('5/5/2012'), new Date('5/5/2012')), 'exact equal'
	ok not comparator.compare(new Date('5/5/2012'), new Date('6/6/2012')), 'not equal'
	ok not comparator.compare(new Date('5/5/2012'), new Date('7/5/2012')), 'same week'
	equal comparator.rowTitle('5/5/2012'), 'Week 18, 2012', 'week title'
	###
	
	comparator = group.getComparator('date','month')
	ok comparator.compare(new Date('5/5/2012'), new Date('5/5/2012')), 'equal'
	ok not comparator.compare(new Date('5/5/2012'), new Date('6/6/2012')), 'not equal'
	ok not comparator.compare(new Date('5/5/2012'), new Date('5/5/2011')), 'not equal'
	ok comparator.compare(new Date('5/5/2012'), new Date('5/24/2012')), 'same month'
	equal comparator.rowTitle('5/5/2012'), 'May 2012', 'month title'

	comparator = group.getComparator('date','quarter')
	ok comparator.compare(new Date('1/7/2012'), new Date('1/7/2012')), 'equal'
	ok comparator.compare(new Date('1/5/2012'), new Date('3/24/2012')), 'same quarter'
	ok not comparator.compare(new Date('5/5/2012'), new Date('7/6/2012')), 'not equal'
	ok not comparator.compare(new Date('5/5/2012'), new Date('5/5/2011')), 'not equal'
	equal comparator.rowTitle('5/5/2012'), 'Quarter 2, 2012', 'quarter title'

	comparator = group.getComparator('date','year')
	ok comparator.compare(new Date('1/7/2012'), new Date('1/7/2012')), 'equal'
	ok comparator.compare(new Date('1/5/2012'), new Date('9/24/2012')), 'same year'
	ok not comparator.compare(new Date('5/5/2012'), new Date('7/6/2008')), 'not equal'
	ok not comparator.compare(new Date('5/5/2012'), new Date('5/5/2011')), 'not equal'
	equal comparator.rowTitle('5/5/2012'), 'Year = 2012', 'year title'



