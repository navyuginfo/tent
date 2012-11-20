###*
* @class Tent.Data.Pager
* Adds paging support
###

Tent.Data.Pager = Ember.Mixin.create
	paged: false
	pageSize: 12
	_page: 1
	_totalRows: 27

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

	goToPage: (page) ->
		@set('currentPage', page)
		@update(@REQUEST_TYPE.PAGE)

	nextPage: ->
		newPage = @get('currentPage') + 1
		@set('currentPage', newPage) unless !@isValidPage(newPage)
		@update(@REQUEST_TYPE.PAGE)
  
	prevPage: ->
		newPage = @get('currentPage') - 1
		@set('currentPage', newPage) unless !@isValidPage(newPage)
		@update(@REQUEST_TYPE.PAGE)


	getPagingInfo: ->
		if @get('paged')
			pageSize: @get('pageSize')
			pageNum: @get('currentPage')
			totalPages: @get('totalPages')
		else
			{}
			
	updatePagingInfo: (info) ->
		@set('_totalRows', info.totalRows)
		@set('_page', info.pageNum)
