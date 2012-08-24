
setup = ->

teardown = ->

module 'Tent.RemotePagedData', setup, teardown

test 'Get paging info', ->
	dataView = Tent.RemotePagedData.create
		pagesize: 5
		pagenum: 0
		totalRows: 9

	info = dataView.getPagingInfo()
	equal info.pageSize, 5, "pagesize"
	equal info.pageNum, 0, "pagenum"
	equal info.totalRows, 9, "totalrows"
	equal info.totalPages, 2, "total pages"

	dataView.set('pagesize', null)
	info = dataView.getPagingInfo()
	equal info.totalPages, 1, "total pages should be one when no pagesize is set"

	dataView = null

test 'Set paging options', ->
	dataView = Tent.RemotePagedData.create
		pagesize: 5
		pagenum: 0
		totalRows: 9
		parentView: 
			page: (info)->

	dataView.setPagingOptions({pageNum:1})
	equal dataView.getPagingInfo().pageNum, 1, 'Valid page number'
	dataView.setPagingOptions({pageNum:10})
	equal dataView.getPagingInfo().pageNum, 1, 'Page size is larger than pages available'
	 
test 'highlightSelectedRowsOnGrid', ->

	parentView = Ember.Object.create
		page: (info)->
		grid: {
			setSelectedRowsCalled: false
			setSelectedRows: (selectedRowIds)->
				@selectedRowIds = selectedRowIds
				@setSelectedRowsCalled = true
		}

	dataView = Tent.RemotePagedData.create
		pagesize: 5
		pagenum: 0
		totalRows: 9
		selectedRowIds: [51,52, 60, 68]
		parentView: parentView
		items: [
			{id:50}
			{id:51}
			{id:52}
			{id:53}
		]
			
	dataView.highlightSelectedRowsOnGrid()
	ok parentView.get('grid').setSelectedRowsCalled, 'Called setSelectedRows on parentView'
	deepEqual parentView.get('grid').selectedRowIds, [1,2], 'Pick out the row number of the selected items on this page only'

test 'Get and set item', ->
	items = [
		{id:50}
		{id:51}
		{id:52}
		{id:53}
	]

	dataView = Tent.RemotePagedData.create()
	dataView.setItems items
	deepEqual dataView.getItems(), items, 'Items have been retrieved'
	equal dataView.getItem(2).id, 52, 'Item 2 retrieved'