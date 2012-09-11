Tent.GridPagingSupport = Ember.Mixin.create
	paged: false
	remotePaging: false #paging, sorting, searching are done remotely

	init: ->
		@_super()
		
	attachPager: (->
		if @get("paged")
			pager = new Slick.Controls.Pager(@get('dataView'), @get('grid'), @$().find(".pager"));
	).observes 'grid'

	addListenersForPageChange: (->
		if not @get('remotePaging')
			@get('dataView').syncPagedGridSelection = @handlePagedSelections
	).observes('dataView')


	# The native grid/dataview does not manage selections across pages
	# This code adds listeners to enable this
	handlePagedSelections: (grid, preserveHidden) ->
		selectedRowIds = @mapRowsToIds(grid.getSelectedRows())
		inHandler = false
		grid.onSelectedRowsChanged.subscribe (e, args) =>
			if inHandler then return # Called from a paging request
			@updateSelectedIdsWithCurrentPageSelection(grid)

		@updateSelectedIdsWithCurrentPageSelection = (grid) ->
			currentPageSelectedIds = @mapRowsToIds(grid.getSelectedRows())
			for id in currentPageSelectedIds
				selectedRowIds.push(id) if id not in selectedRowIds
			selectedRowIds = @removeUnselectedRows(selectedRowIds, currentPageSelectedIds)
			grid.selectedRowIds = selectedRowIds

		@removeUnselectedRows = (selectedRowIds, currentPageSelectedIds) ->
			counter = @getLength()
			while counter
				rowInCurrentPage = @getItem(counter-=1)
				selectedRowIds = $.grep(selectedRowIds, (element, index) ->
					if element == rowInCurrentPage.id
						if element not in currentPageSelectedIds then return false
					return true
				)
			selectedRowIds

		@onRowsChanged.subscribe((e, args) =>
			if selectedRowIds.length > 0
				inHandler = true
				selectedRowsOnCurrentPage = @mapIdsToRows(selectedRowIds)
				if not preserveHidden 
					selectedRowIds = @mapRowsToIds(selectedRowsOnCurrentPage)
				grid.setSelectedRows(selectedRowsOnCurrentPage)
				inHandler = false
		)

	page: (pagingInfo)->
		@get('collection').goToPage(pagingInfo.pageNum)

