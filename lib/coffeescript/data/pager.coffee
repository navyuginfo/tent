
Tent.Data.Pager = Ember.Mixin.create
	data: []
	paged: false
	pageSize: 10
	totalRows: 12

	_page: 1

	content: (->
		page = @get('currentPage')
		size = @get('pageSize')
		@get('data')?.slice(((page - 1) * size), (page * size)) || []
	).property('data', 'currentPage', 'pageSize')
	
	currentPage: ((key, value) ->
		if arguments.length == 1
			if @isValidPage(@get('_page')) then @get('_page') else 1
		else
			@set('_page', value) unless !@isValidPage(value)
			@get('_page')
	).property('data')

	isValidPage: (page) ->
		page >= 1 && page <= @get('totalPages')

	totalPages: (->
		data = @get('data') || []
		Math.ceil(data.length / @get('pageSize'))
	).property('data', 'pageSize')

	goToPage: (page) ->
		@set('currentPage', page)

	nextPage: ->
		newPage = @get('currentPage') + 1
		@set('currentPage', newPage) unless !@isValidPage(newPage)
  
	prevPage: ->
		newPage = @get('currentPage') - 1
		@set('currentPage', newPage) unless !@isValidPage(newPage)



	#page: (pageInfo)->
	#	query = $.extend(pageInfo, {type:'paging'})
	#	@set('content', @get('store').findQuery(eval(@get('dataType')), query))

