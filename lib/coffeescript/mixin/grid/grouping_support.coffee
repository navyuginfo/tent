###*
* @class Tent.Grid.GroupingSupport
* Adds grouping support to a grid
###
Tent.Grid.GroupingSupport = Ember.Mixin.create
  remoteGrouping: false

  ###*
   * @property {Boolean} showGroupTitle Show the title of the group in each grouping row along with the group data.
  ###
  showGroupTitle: true

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
    @set('currentGroup', @getSelectedGroup(id))
    @showGroupHeader(id, @get('currentGroup'))
    @get('collection').setCurrentGroupId(id)
    @get('collection').goToPage(1)

  getSelectedGroup: (id)->
    for item in @get('content').toArray()
      if item.get('id') == parseInt(id,10)
        selectedGroup = item
    return selectedGroup

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
    @get('collection').clearGrouping()
    @hideGroupHeader()
    @setShowingGroupsListState(false)

  setShowingGroupsListState: (isShowing) ->
    @set('showingGroups', isShowing)
    @set('collection.isShowingGroupsList', isShowing)

  isShowingValidGroups: ->
    @get('showingGroups') and @get('groupingInfo.columnName')?
