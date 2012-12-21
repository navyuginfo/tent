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


test 'Boolean Ranges', ->
	group = Tent.JqGrid.Grouping
	comparator = group.getComparator('boolean','exact')
	ok comparator.compare(true, true), 'true/true'
	ok not comparator.compare(false, true), 'false/true'
	ok not comparator.compare(true, false), 'true/false'
	ok comparator.compare(false, false), 'false/false'

test 'Number Ranges', ->
	group = Tent.JqGrid.Grouping
	comparator = group.getComparator('number','10s')
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

test 'Date Ranges', ->
	group = Tent.JqGrid.Grouping
	comparator = group.getComparator('date','exact')
	#ok comparator.compare(new Date('5/5/2012'), new Date('5/5/2012')), 'exact equal'
	#ok not comparator.compare(new Date('5/5/2012'), new Date('6/6/2012')), 'exact nequal'

	comparator = group.getComparator('date','week')
	ok comparator.compare(new Date('5/5/2012'), new Date('5/5/2012')), 'exact equal'
	ok not comparator.compare(new Date('5/5/2012'), new Date('6/6/2012')), 'not equal'
	ok not comparator.compare(new Date('5/5/2012'), new Date('7/5/2012')), 'same week'
	equal comparator.rowTitle('5/5/2012'), 'Week 18, 2012', 'week title'

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



