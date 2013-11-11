Tent.Data.GroupPager = Ember.Mixin.create
  groupRows: []
  groupPage: 1
  groupPageSize: 40

  expandGroup: (id) ->
    id = parseInt(id)
    console.log "expanding group #{id}"
    row = @groupRow(id)
    items = @createEmptyGroupItems(row.rowcnt, row)
    args = [id + 1, 0].concat(items)
    Array.prototype.splice.apply(@get('groupRows'), args)
    row.set('expanded', true)
    @fetchItems(id)

  collapseGroup: (id) ->
    id = parseInt(id)
    row = @groupRow(id)
    console.log "collapsing group #{id}", row.rowcnt
    @get('groupRows').splice(id + 1, row.rowcnt)
    console.log "rows after collapsing splice", @get('groupRows')
    row.set('expanded', false)
    @groupRowsChanged()

  didSelectGroup: (id, status, e) ->
    console.log "selected group row #{id}"
    row = @groupRow(id)
    unless row.expanded
      @expandGroup(id)
    else
      @collapseGroup(id)

  isGroupRow: (id) -> @groupRow(id)?.rowcnt?

  # fetch one page-size worth of items if they are not already loaded,
  # starting from a specific index the row's group determines to which group
  # the row belongs.  if the group is null, then the row is a top level group
  # row.  if the group has no group of its own, then the row is a subitem of a
  # top level group.
  #
  # if the group has its own group, then row is a subitem belonging to a
  # second-level group.  we inspect all the entries in the group row cache to
  # see if they have been loaded, and if not, we load one page of data of that
  # type to be inserted at that position in the cache. as this call is
  # asynchronous, we do not want to intitiate additional fetches of the same
  # type for adjacent rows, so we skip those rows that have identical
  # configuration.
  #
  # for example, the current grouping setup might have 3 top level items, with
  # the latter two items expanded. if the first expanded group has 7 items, and
  # our page size is 10, we initiate a request for 10 of the first group's
  # items, but only 7 will return, so we additionally request one page of items
  # for the 2nd group so that we can fulfill our full page size of 10 items.
  fetchItems: (startingRowId) ->
    console.log 'fetching items for row id', startingRowId
    endingRowId = startingRowId + @get('groupPageSize')
    for i in [startingRowId..endingRowId]
      row = @groupRow(i)
      if row? && !row.loaded && row.group != group
        group = row.group
        console.log 'fetching group', group
        @fetchGroupItems(group, i, row.itemId, row.itemId + @get('groupPageSize'))

  onGroupRowsLoaded: (index, rows) ->
    console.log 'rows loaded, index:', index, 'rows:', rows

    if index == 0
      items = @createEmptyGroupItems(rows.totalRows - 1)
      args = [0, items.length].concat(items)
      Array.prototype.splice.apply(@get('groupRows'), args)

    for row, i in rows
      row.loaded = true
      $.extend(@groupRow(index + i), row)

    @notifyPropertyChange('groupRows')

  groupPageObserver: (->
    console.log 'group page changed', @get('groupPageStart')
    @fetchItems(@get('groupPageStart'))
    @groupRowsChanged()
  ).observes('groupPage', 'groupPageStart', 'groupPageEnd')

  groupRowsChanged: (->
    console.log "group rows changed", @get('groupRows')
    rows = @get('groupRows').slice(@get('groupPageStart'), @get('groupPageEnd'))
    row.set('id', i + @get('groupPageStart')) for row, i in rows
    console.log 'new rows are', rows
    rows.set('totalRows', @get('groupRows.length'))
    rows.set('isLoaded', true)
    @set('modelData', rows)
  ).observes('groupRows')

  groupPageStart: (->
    console.log "new group page start"
    (@get('groupPage') - 1) * @get('groupPageSize')
  ).property('groupPage', 'groupPageSize')

  groupPageEnd: (->
    console.log "new group page end"
    @get('groupPage') * @get('groupPageSize')
  ).property('groupPage', 'groupPageSize')

  fetchFirstGroup: ->
    @fetchGroupItems(null, 0, 0, @get('groupPageSize'))

  groupingStart: (settings) ->
    console.log 'starting grouping with settings:', settings
    @set('groupRows', [])

    unless @get('groupSettings')?
      @set 'groupSettings',
        groupBy: []
        types: []

    if @get('groupSettings.groupBy.length') < 2 # limit multi-level grouping to 2 levels
      @get('groupSettings.groupBy').pushObject(settings.columnName.decamelize())
      @get('groupSettings.types').pushObject(settings.type)

    @fetchFirstGroup()

  clearGrouping: ->
    @set('groupSettings', null)

  goToGroupPage: (page) ->
    console.log "setting groupPage", page
    @set('currentPage', page)
    @set('groupPage', page)

  groupRow: (id) -> @get('groupRows')[id]

  createEmptyGroupItems: (rowcnt, group) ->
    console.log "creating items for group", group, "with rowcnt", rowcnt
    for i in [0..rowcnt-1]
      Ember.Object.create
        group: group
        itemId: i
        loaded: false
        expanded: false
