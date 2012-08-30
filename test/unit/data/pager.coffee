
setup = ->
	Pager = Ember.Object.extend Tent.Data.Pager
	@pager = Pager.create()
teardown = ->
	@pager = null
	Pager = null

module 'Tent.Data.Pager', setup, teardown	

test 'Total pages', ->
	equal pager.get('totalPages'), 0, 'Initially no pages'
	pager.set('data', [51,52,53,54,55,56,57,58])
	pager.set('pageSize', 7)
	equal pager.get('totalPages'), 2, 'Total pages should be 2'
	pager.set('pageSize', 8)
	equal pager.get('totalPages'), 1, 'Total pages should be 1'
	pager.set('pageSize', 9)
	equal pager.get('totalPages'), 1, 'Total pages should be 1'

test 'Current page', ->
	pager.set('data', [51,52,53,54,55,56,57,58])
	pager.set('pageSize', 7)

	equal pager.get('_page'), 1, 'Default page number'
	equal pager.get('currentPage'), 1, 'Current page'
	pager.set('_page', 20)
	equal pager.get('currentPage'), 1, 'Invalid page defaults to 1'

	pager.set('currentPage', 2)
	equal pager.get('_page'), 2, 'Move to page 2'
	pager.set('currentPage', 4)
	equal pager.get('_page'), 2, 'Invalid page, remain at previous page'

test 'Content', ->
	pager.set('data', [51,52,53,54,55,56,57,58])
	pager.set('pageSize', 7)
	content = pager.get('content')
	equal content.length, 7, 'Return a full page'
	pager.set('currentPage', 2)
	content = pager.get('content')
	equal content.length, 1, 'Second page contains one item'

test 'GotoPage', ->
	pager.set('data', [51,52,53,54,55,56,57,58,59,60,61,62,63,64])
	pager.set('pageSize', 4)
	pager.goToPage(2)
	equal pager.get('content')[0], 55, 'Goto page 2: start'
	equal pager.get('content')[3], 58, 'Goto page 2: end'
	pager.goToPage(4)
	equal pager.get('content')[0], 63, 'Goto page 4'
	equal pager.get('content').length, 2, 'last page has 2 items'

test 'NextPage, PrevPage', ->
	pager.set('data', [51,52,53,54,55,56,57,58,59,60,61,62,63,64])
	pager.set('pageSize', 4)
	pager.goToPage(2)
	pager.nextPage()
	equal pager.get('content')[0], 59, 'Next page'
	pager.prevPage()
	equal pager.get('content')[0], 55, 'Prev page'
	
	



