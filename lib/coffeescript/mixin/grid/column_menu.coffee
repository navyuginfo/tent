Tent.Grid.ColumnMenu = Ember.Mixin.create
	columnsDidChange: ->
		@leftAlignLastDropdown()

	addColumnDropdowns: () ->
		for column in @get('columns')
			column.groupable = not (column.groupable? && column.groupable ==false)
			column.renamable = not (column.renamable? && column.renamable ==false)
			column.sortable = not (column.sortable? && column.sortable ==false)

			if column.groupable or column.renamable or column.sortable
				template = Handlebars.compile '
					 	<ul class="dropdown-menu column-dropdown" data-column="{{column.name}}" data-last-title="{{title}}" data-orig-title="{{title}}">
							{{#if column.sortable}}
								<li class="sort dropdown-submenu">
									<a tabindex="-1">{{sort}}</a>
								    <ul class="dropdown-menu wide">
								    	<li><a tabindex="-1" class="ascending">{{ascending}}</a></li>
								    	<li><a tabindex="-1" class="descending">{{descending}}</a></li>
								    </ul>
								</li>
							{{/if}}
							{{#if column.groupable}}
								<li class="group dropdown-submenu">
									<a tabindex="-1">{{group}}</a>
								    <ul class="dropdown-menu">
								    	<li data-grouptype="none"><a tabindex="-1">{{none}}</a></li>
								    	{{#each groupType}}
								    		<li data-grouptype="{{name}}"><a class="revert" tabindex="-1">{{title}}</a></li>
								    	{{/each}}
								    </ul>
								</li>
							{{/if}}
							{{#if column.renamable}}
								<li class="rename dropdown-submenu">
									<a tabindex="-1">{{rename}}</a>
								    <ul class="dropdown-menu wide">
								    	<li><input type="text" value="{{title}}" class="input-medium"/></li>
								    	<li><a tabindex="-1" class="revert">{{revert}}</a></li>
								    </ul>
								</li>
							{{/if}}
						</ul>'


				groupType = Tent.JqGrid.Grouping.ranges[column.type] || Tent.JqGrid.Grouping.ranges['string']
				context = 
					column: column
					title: Tent.I18n.loc column.title
					groupType: groupType
					none: Tent.I18n.loc ("tent.grouping.no_grouping")
					revert: Tent.I18n.loc ("tent.grouping.revert")
					sort: Tent.I18n.loc ("tent.sorting.main")
					ascending: Tent.I18n.loc ("tent.sorting.ascending")
					descending: Tent.I18n.loc ("tent.sorting.descending")
					group: Tent.I18n.loc ("tent.grouping._groupBy")
					rename: Tent.I18n.loc ("tent.rename.main")
				
				columnDivId = '#jqgh_' + @get('elementId') + '_jqgrid_' + column.name
				@$(columnDivId).addClass('dropdown')
				$(columnDivId + ' .title').after template(context)
				$(columnDivId + ' .title').addClass('has-dropdown').attr('data-toggle','dropdown')

		@leftAlignLastDropdown()
		@groupByColumnBindings()
		@renameColumnHeaderBindings()
		@sortingBindings()
	
	toggleColumnDropdown: (columnField)->
		columnDivId = '#jqgh_' + @get('elementId') + '_jqgrid_' + columnField
		$(columnDivId + ' .title' ).dropdown('toggle')

	leftAlignLastDropdown: ->
		if @.$('.ui-jqgrid-htable').length > 0
			@$('.column-dropdown .dropdown-submenu').removeClass('pull-left')
			@$('.ui-th-column: .column-dropdown').removeClass('last')

			table = @$('.ui-jqgrid-htable')
			tableRight = $(window).width() - (table.offset().left + table.outerWidth())
			
			@$('.ui-th-column:visible').each(->
				columnLeft = $(window).width() - $(this).offset().left
				if (columnLeft - 250) < tableRight
					$('.dropdown-submenu', $(this)).addClass('pull-left')
				if (columnLeft - 120) < tableRight
					$('.column-dropdown', $(this)).addClass('last')
			)

	# We hide the standard sort buttons using css.
	# When a dropdown sort button is selected, send a click event 
	# to the standard sort buttons and let jqGrid handle it.
	sortingBindings: ->
		widget = this
		@$('.dropdown-menu .sort .ascending').click((e)->
			target = $(e.target)
			widget.findAscendingButton(target).click()
		)
		@$('.dropdown-menu .sort .descending').click((e)->
			target = $(e.target)
			widget.findDescendingButton(target).click()
		)

	findAscendingButton: (target) ->
		target.parents('.ui-th-column:first').find('.ui-icon-asc').eq(0)

	findDescendingButton: (target) ->
		target.parents('.ui-th-column:first').find('.ui-icon-desc').eq(0)

	groupByColumnBindings: ->
		widget = this

		@$('.group.dropdown-submenu').click((e)->
			target = $(e.target)
			groupType = target.attr('data-grouptype') or target.parents('li[data-grouptype]:first').attr('data-grouptype')
			if groupType == 'none'
				widget.getTableDom().jqGrid('groupingRemove', true)
			else
				column = target.attr('data-column') or target.parents('ul.column-dropdown:first').attr('data-column')
				columnType = 'string'
				for col in widget.get('columns')
					if col.name == column then columnType= col.type
				widget.groupByColumn(column, groupType, columnType)
		)

	groupByColumn: (column, groupType, columnType)->
		lastSort = @getTableDom()[0].p.sortname
		for columnDef in @get('columns')
			if columnDef.name == column and columnDef.sortable? and columnDef.sortable
				if (not lastSort?) or not (lastSort == column)
					@getTableDom().sortGrid(column)

		comparator = Tent.JqGrid.Grouping.getComparator(columnType, groupType)
		this.getTableDom().groupingGroupBy(column, {
				groupText : ['<b>' + @getTitleForColumn(column) + ':  {0}</b>']
				range: comparator
			}
		)

		this.gridDataDidChange()

	renameColumnHeaderBindings: ->
		widget = this

		@$('.rename.dropdown-submenu').hover((e)->
			$('input',@).focus()
		).click((e)->
			target = $(e.target)
			e.stopPropagation()
			e.preventDefault()
		)

		@$('.rename.dropdown-submenu input').bind('keyup', ((e)->
			target = $(e.target)
			dropdownMenu = target.parents('ul.column-dropdown:first')
			columnField = dropdownMenu.attr('data-column')
			
			if e.keyCode == 13	# return key				
				widget.renameColumnHeader(columnField, $(this).val(), dropdownMenu)
			else if e.keyCode == 27 # escape key
				# reset to the original title
				lastTitle = dropdownMenu.attr('data-last-title')
				widget.renameGridColumnHeader(columnField, lastTitle)
				$(this).val(lastTitle)
				widget.toggleColumnDropdown(columnField)
				e.preventDefault()
				e.stopPropagation()
			)
		)

		@$('.rename.dropdown-submenu .revert').click((e)->
			target = $(e.target)
			dropdownMenu = target.parents('ul.column-dropdown:first')
			columnField = dropdownMenu.attr('data-column')

			originalTitle = dropdownMenu.attr('data-orig-title')
			widget.renameColumnHeader(columnField, originalTitle, dropdownMenu)
			$('.rename.dropdown-submenu input', dropdownMenu).val(originalTitle)
		)

	renameColumnHeader: (columnField, value, dropdownMenu)->
		@toggleColumnDropdown(columnField)
		@renameGridColumnHeader(columnField, value)
		dropdownMenu.attr('data-last-title', value)

	renameGridColumnHeader: (colname, value) ->
		# jqGrid ignores "" as a column header, so set it to a space.
		if value == ""
			value = " "
		@getTableDom().jqGrid('setLabel', colname, value);
		for column in @get('columns')
			column.title = value if column.name == colname

		@columnsDidChange()
