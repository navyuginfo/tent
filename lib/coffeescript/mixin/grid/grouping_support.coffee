###*
* @class Tent.Grid.GroupingSupport
* Adds grouping support to a grid
###
Tent.Grid.GroupingSupport = Ember.Mixin.create
  showingGroups: false

  getColumnType: (columnName)->
    columnType = 'string'
    for col in @get('columns')
      if col.name == columnName then columnType= col.type
    columnType

  newGroupSelected: (groupType, columnName) ->
    console.log 'starting multi grouping', groupType, columnName
    if groupType == 'none'
      @clearAllGrouping()
    else
      @set('showingGroups', true)
      @get('collection').groupingStart
        columnName: columnName
        type: groupType
        columnType: @getColumnType(columnName)

  updateGroupFormatting: ->
    table = @getTableDom()
    #sel = $('tr', table)
    #sel.removeClass('group-row')
    #sel.removeClass('group-expanded')
    #sel.removeClass('group-collapsed')
    if table?
      for row in @get('content')
        if row.get('rowcnt')
          table.jqGrid('setRowData', row.get('id'), false, 'group-row')
          labelData = table.jqGrid('getCell', row.get('id'), 0)
          if row.get('expanded')
            table.jqGrid('setRowData', row.get('id'), false, 'group-expanded')
            table.jqGrid('setCell', row.get('id'), 0, "<span class='group-arrow'>&#x25BC;</span> #{labelData}")
          else
            table.jqGrid('setRowData', row.get('id'), false, 'group-collapsed')
            table.jqGrid('setCell', row.get('id'), 0, "<span class='group-arrow'>&#x25BA;</span> #{labelData}")

  showGroupHeader: (id, selectedGroup)->
    widget = this

    columnName = @get('groupingInfo.columnName')
    columnType = @get('groupingInfo.columnType')
    groupType = @get('groupingInfo.type')
    columnTitle = @getColumnTitle(columnName)

    if selectedGroup?
      content = ""
      content = "<span class='title'>" + @getColumnTitle(columnName) + "</span>" if @get('showGroupTitle')
      content = content + "<span class='range'>"

      comparator = Tent.JqGrid.Grouping.getComparator(columnType, groupType)
      startValue = selectedGroup[columnName.decamelize()]
      if startValue?
        content = content + comparator.rowTitle(startValue)
      content = content + "</span>"

    #aggregateColumns = @addAggregateData(@get('columnModel'), selectedGroup)
    aggregateColumns = @getTableDom()[0].getAggregateDataForGroupHeaderRow( {columns: @get('columnModel')}, selectedGroup, true)
    headerRow = $('<tbody><tr class="group-header"><td><i class="icon-caret-left"></i>'+content+'</td>'+aggregateColumns+'</tr></tbody>')
    @$('.ui-jqgrid-hbox .ui-jqgrid-htable tbody').remove()
    @$('.ui-jqgrid-hbox .ui-jqgrid-htable').append(headerRow)
    headerRow.click(->
      widget.returnToGroupList()
    )
    @columnsDidChange()

  refreshGroupHeader: ->
    @showGroupHeader(@get('collection.groupingInfo.currentGroupId'), @get('currentGroup'), true) if @get('collection.groupingInfo.currentGroupId')

  columnOrderDidChange: (->
    @refreshGroupHeader()
  ).observes('columnInfo.order')

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
    @set('showingGroups', false)
    @get('collection').clearGrouping()

  didSelectGroup: (id, status, e) ->
    @get('collection').didSelectGroup(id, status, e)

  isGroupRow: (id) -> @get('collection').isGroupRow(id)
