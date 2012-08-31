Tent.GridFilteringSupport = Ember.Mixin.create
	setupFilter: ->
		@.$('.filter-toggle').click( =>
			if $(@get('grid').getTopPanel()).is(":visible")
				@get('grid').hideTopPanel()
			else
				@get('grid').showTopPanel()
		)

	setupColumnFilters: ->
		if @get('useColumnFilters')
			grid = @get('grid')
			columnFilters = @get('columnFilters')
			grid.showHeaderRowColumns()
			@set('columnFilters', {})
			that = this
			$(grid.getHeaderRow()).delegate(":input", "change keyup", (e) ->
				that.columnFilters[$(this).data("columnId")] = $.trim($(this).val())
				that.get('dataView').refresh()
			)

			@updateHeaderRow()

			grid.onColumnsReordered.subscribe((e, args) =>
				@updateHeaderRow()
			)

			grid.onColumnsResized.subscribe((e, args) =>
				@updateHeaderRow()
			)
			@get('dataView').setFilterArgs(
				slickGrid: @
			)
			@get('dataView').setFilter(@columnFiltering)

	updateHeaderRow: ->
		columnFilters = @get('columnFilters')
		for col in @get('adaptedColumns')
			if col.id != "selector"
				header = @get('grid').getHeaderRowColumn(col.id)
				$(header).empty()
				$("<input type='text'>")
					.data("columnId", col.id)
					.val(columnFilters[col.id])
					.appendTo(header);
      
	columnFiltering: (item, args) ->
		grid = args.slickGrid.get('grid')

		columnFilters = args.slickGrid.get('columnFilters')
		for columnId of columnFilters
			console.log 'filtering for .. ' + columnId
			if columnId != undefined && columnFilters[columnId] != ""
				c = grid.getColumns()[grid.getColumnIndex(columnId)]
				re = new RegExp("^" + columnFilters[columnId],"i")
				if !re.test(item[c.field])
					return false
		return true