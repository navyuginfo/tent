Tent.Grid.ColumnMenu = Ember.Mixin.create
	 
	addColumnDropdowns: () ->
		for column in @get('columns')
			column.groupable = not (column.groupable? && column.groupable ==false)
			column.renamable = not (column.renamable? && column.renamable ==false)

			if column.groupable or column.renamable
				template = Handlebars.compile "
					 	<ul class='dropdown-menu column-dropdown' data-column='{{column.name}}' data-orig-title='{{title}}'>
							{{#if column.groupable}}
								<li class='group dropdown-submenu'>
									<a tabindex='-1'>Group</a>
								    <ul class='dropdown-menu'>
								    	{{#each groupType}}
								    		<li data-grouptype='{{name}}'><a tabindex='-1'>{{title}}</a></li>
								    	{{/each}}
								    </ul>
								</li>
							{{/if}}
							{{#if column.renamable}}
								<li class='rename dropdown-submenu'>
									<a tabindex='-1'>Rename</a>
								    <ul class='dropdown-menu'>
								    	<li>
								    		<input type='text' value='{{title}}'/>
								    	</li>
								    </ul>
								</li>
							{{/if}}
						</ul>"


				groupType = Tent.JqGrid.Grouping.ranges[column.type] || Tent.JqGrid.Grouping.ranges['string']
				context = 
					column: column
					title: Tent.I18n.loc column.title
					groupType: groupType
				
				columnDivId = '#jqgh_' + @get('elementId') + '_jqgrid_' + column.name
				@$(columnDivId).after template(context)
				@$(columnDivId).addClass('has-dropdown').attr('data-toggle','dropdown')

		@groupByColumnBindings()
		@renameColumnHeaderBindings()
	
	toggleColumnDropdown: (columnField)->
		columnDivId = '#jqgh_' + @get('elementId') + '_jqgrid_' + columnField
		$(columnDivId).dropdown('toggle')

	groupByColumnBindings: ->
		widget = this

		@$('.group.dropdown-submenu').click((e)->
			target = $(e.target)
			groupType = target.attr('data-grouptype') or target.parents('li[data-grouptype]:first').attr('data-grouptype')
			column = target.attr('data-column') or target.parents('ul.column-dropdown:first').attr('data-column')
			columnType = 'string'
			for col in widget.get('columns')
				if col.name == column then columnType= col.type
			widget.groupByColumn(column, groupType, columnType)
		)

	groupByColumn: (column, groupType, columnType)->
		@get('collection').sort(
			fields: [
				sortAsc: true
				field: column
			]
		)

		comparator = Tent.JqGrid.Grouping.getComparator(columnType, groupType)
		this.getTableDom().groupingGroupBy(column, {
				groupText : ['<b>' + @getTitleForColumn(column) + ':  {0}</b>']
				range: comparator
			}
		)

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
				originalTitle = dropdownMenu.attr('data-orig-title')
				widget.renameGridColumnHeader(columnField, originalTitle)
				$(this).val(originalTitle)
				widget.toggleColumnDropdown(columnField)
			)
		)

	renameColumnHeader: (columnField, value, dropdownMenu)->
		@renameGridColumnHeader(columnField, value)
		dropdownMenu.attr('data-orig-title', value)
		@toggleColumnDropdown(columnField)

	renameGridColumnHeader: (colname, value) ->
		# jqGrid ignores "" as a column header, so set it to a space.
		if value == ""
			value = " "
		@getTableDom().jqGrid('setLabel', colname, value);
		for column in @get('columns')
			column.title = value if column.name == colname
