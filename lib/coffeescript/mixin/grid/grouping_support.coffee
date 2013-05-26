###*
* @class Tent.Grid.GroupingSupport
* Adds grouping support to a grid
###
Tent.Grid.GroupingSupport = Ember.Mixin.create
	remoteGrouping: false

	# Determines whether groups or items are shown in the grid
	showingGroups: false


	# Called when a user selects a grouping option from the dropdown menu
	newGroupSelected: (groupType, columnName)->
		if @remoteGrouping
			@doRemoteGrouping(groupType, columnName)
		else
			@doLocalGrouping(groupType, columnName)

	doLocalGrouping: (groupType, columnName)->
		if groupType == 'none'			
			@getTableDom().jqGrid('groupingRemove', true)
		else 
			columnType = @getColumnType(columnName)
			
			lastSort = @getTableDom()[0].p.sortname
			for columnDef in @get('columns')
				if columnDef.name == columnName and columnDef.sortable? and columnDef.sortable
					if (not lastSort?) or not (lastSort == columnName)
						@getTableDom().sortGrid(columnName)

			comparator = Tent.JqGrid.Grouping.getComparator(columnType, groupType)
			this.getTableDom().groupingGroupBy(columnName, {
					groupText : ['<b>' + @getColumnTitle(columnName) + ':  {0}</b>']
					range: comparator
				}
			)
			this.gridDataDidChange()

	getColumnType: (columnName)->
		columnType = 'string'
		for col in @get('columns')
			if col.name == columnName then columnType= col.type
		columnType

	doRemoteGrouping: (groupType, columnName) ->
		@clearAllGrouping()
		if groupType == 'none'			
			@get('collection').goToPage(1)
		else 
			groupData = 
				columnName: columnName
				type: groupType
				columnType: @getColumnType(columnName)
			@setShowingGroupsListState(true)
			@get('collection').goToGroupPage(1, groupData)

	# A group was row was selected from the grid
	didSelectGroup: (itemId, status, e)->
		@selectRemoteGroup(itemId)

	selectRemoteGroup: (id)->
		@setShowingGroupsListState(false)
		@showGroupHeader(id)
		@get('collection').setCurrentGroupId(id)
		@get('collection').goToPage(1)

	showGroupHeader: (id)->
		widget = this

		columnName = @get('groupingInfo.columnName')
		columnType = @get('groupingInfo.columnType')
		groupType = @get('groupingInfo.type')
		columnTitle = @getColumnTitle(columnName)
		
		for item in @get('content').toArray()
			if item.get('id') == parseInt(id,10)
				selectedGroup = item

		if selectedGroup?
			content = "<span class='title'>" + @getColumnTitle(columnName) + "</span><span class='range'>"
			comparator = Tent.JqGrid.Grouping.getComparator(columnType, groupType)
			startValue = selectedGroup[columnName.decamelize()]
			if startValue?
				content = content + comparator.rowTitle(startValue);
			content = content + "</span>"

		content = content + @addAggregateData(@get('columnModel'), selectedGroup)

		headerRow = $('<tr class="group-header"><td colspan="' + @getColSpan() + '"><i class="icon-caret-left"></i>'+content+'</td></tr>')
		@$('.ui-jqgrid-hbox .ui-jqgrid-htable').append(headerRow)
		headerRow.click(->
			widget.returnToGroupList()
		)
		@columnsDidChange()

	addAggregateData: (columns, row)->
		hasAggregates = false
		span = '<span class="aggregate"><span class="caption">'+Tent.I18n.loc('tent.grouping.totals')+'</span>'
		columns.forEach ((col)->
			aggregate = row.get(col.name + "_sum")
			if aggregate != undefined
				hasAggregates = true;
				span = span + '<span class="item"><span class="title">'+col.title+'</span><span class="value">'+aggregate+'</span></span>'
		)
		if hasAggregates then span + '</span>' else ""

	hideGroupHeader: ->
		headerRow = @$('.ui-jqgrid-hbox .group-header')
		headerRow.remove()
		@columnsDidChange()

	getColSpan: ->
		visibleColumns = @getTableDom()[0].p.colModel.filter((col)->
			!col.hidden
		)
		visibleColumns.length

	returnToGroupList: ->
		@setShowingGroupsListState(true)
		@hideGroupHeader()
		@get('collection').goToGroupPage()

	clearAllGrouping: ->
		@get('collection').clearGrouping()
		@hideGroupHeader()
		@setShowingGroupsListState(false)

	setShowingGroupsListState: (isShowing) ->
		@set('showingGroups', isShowing)
		@set('collection.isShowingGroupsList', isShowing)
	
	isShowingValidGroups: ->
		@get('showingGroups') and @get('groupingInfo.columnName')?
	
		
	