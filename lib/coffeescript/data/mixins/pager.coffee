###*
* @class Tent.Data.Pager
* Adds paging support
###

Tent.Data.Pager = Ember.Mixin.create
	paged: false
	pageSize: null
	_page: 1
	_totalRows: 27
	_scrollDir: 'down'
	

	init: ->
		@_super()
		@REQUEST_TYPE.PAGE = 'paging'

	currentPage: ((key, value) ->
		if arguments.length == 1
			if @isValidPage(@get('_page')) then @get('_page') else 1
		else
			@set('_page', value) unless !@isValidPage(value)
			@get('_page')
	).property('data')

	isValidPage: (page) ->
		#page >= 1 && page <= @get('totalPages')
		return true #server side paging only => will fail until new data arrives

	totalPages: (->
		@get('_totalPages') || (Math.max(1, Math.ceil(@get('totalRows') / @get('pageSize')))) || 1
	).property('_totalPages','totalRows', 'pageSize')

	totalRows: (->
		@get('_totalRows') || @get('_totalPages') * @get('pagesize') || 1
	).property('_totalRows', '_totalPages', 'pageSize')

	startRow: (->
		((@get('currentPage') - 1) * @get('pageSize')) + 1
	).property('currentPage', 'pageSize')

	endRow: (->
		if (@get('totalRows') - @get('startRow')) < @get('pageSize')
			@get('totalRows')
		else
			@get('currentPage') * @get('pageSize')
	).property('startRow', 'currentPage', 'totalRows', 'pageSize')

	goToPage: (page) ->
		@set('currentPage', page)
		if @get('isShowingGroupsList')
			@set('currentGroupPage', page)
		@update(@REQUEST_TYPE.PAGE)

	nextPage: ->
		newPage = @get('currentPage') + 1
		@set('currentPage', newPage) unless !@isValidPage(newPage)
		@update(@REQUEST_TYPE.PAGE)
  
	prevPage: ->
		newPage = @get('currentPage') - 1
		@set('currentPage', newPage) unless !@isValidPage(newPage)
		@update(@REQUEST_TYPE.PAGE)

	pagingInfo: (->
		pageSize: @get('pageSize')
		page: @get('currentPage')
		totalRows: @get('totalRows')
		totalPages: @get('totalPages')
		scrolling: @get('scroll')
	).property('pageSize', 'currentPage', 'totalPages', 'totalRows')
			
	updatePagingInfo: (info) ->
		@set('_totalRows', info.totalRows)
		@set('_page', info.page)
