Tent.Grid = Ember.Namespace.create()

###*
* @class Tent.Grid.CollectionSupport
* 
* A mixin which allows the use of a collection to provide content and 
* functionality for a grid
*
* The grid will bind to the following properties of the collection:
*   
* - columnsDescriptor: an array of descriptor objects defining the columns to be displayed
*       e.g. [
        {id: "id", name: "id", title: "_hID", field: "id", sortable: true, hideable: false},
        {id: "title", name: "title", title: "_hTitle", field: "title", sortable: true},
        {id: "amount", name: "amount", title: "_hAmount", field: "amount", sortable: true, formatter: "amount",  align: 'right'},
      ]
* - totalRows: the total number of rows in the entire result set (including pages not visible)
* - totalPages: The total number of pages of data available
*
* The collection should also provide the following methods:
*
* - sort(sortdata): Sort the collection according to the sortdata provided
*       e.g. 
        {fields: [
              sortAsc: true
              field: 'title'
          ]
        }
*        
* - goToPage(pageNumber): Navigate to the pagenumber provided (1 = first page)
*
###


Tent.Grid.CollectionSupport = Ember.Mixin.create
  ###*
  * @property {Object} collection The collection object providing the API to the data source
  ###
  collection: null

  ###*
  * @property {Boolean} paged Boolean to indicate the data should be presented as a paged list
  ###
  paged: false

  ###*
  * @property {Number} pageSize The number of items in each page
  ###
  pageSize: 12
  
  pagingInfoBinding: 'collection.pagingInfo'
  sortingInfoBinding: 'collection.sortingInfo'
  columnInfoBinding: 'collection.columnInfo'
  groupingInfoBinding: 'collection.groupingInfo'
   

  init: ->
    @_super(arguments)
    if @get('collection')?
      @setupCustomizedProperties()

  addNavigationBar: ->
    @renderSaveUIStateButton() if this.get('collection')?

  renderSaveUIStateButton: ->
    widget = @
    button = """
        <div class="btn-group jqgrid-title-button save-ui-state">
          <a data-toggle="dropdown" >#{Tent.I18n.loc("tent.button.save")}<span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a class="save">#{Tent.I18n.loc("tent.button.save")}</a></li>
            <li class="dropdown-submenu-left">
              <a>#{Tent.I18n.loc("tent.button.saveAs")}</a>
              <ul class="dropdown-menu save-as-panel">
                 
                  <p>#{Tent.I18n.loc("tent.jqGrid.saveUi.message")}</p>
                  <p><input type="text" class="input-medium keep-open" value="#{widget.get('collection.customizationName')}"/></p>
                  <div><a class='btn pull-left cancel'>#{Tent.I18n.loc("tent.button.cancel")}</a><a class='btn pull-right saveas'>#{Tent.I18n.loc("tent.button.save")}</a></div>
                 
              </ul>
            </li> 
            <li class="dropdown-submenu-left">
              <a>#{Tent.I18n.loc("tent.button.load")}</a>
              <ul class="dropdown-menu load-panel">
              </ul>
            </li>  
          </ul>
        </div>
    """
    @$(".ui-jqgrid-titlebar").append(button)

    @$('.save-ui-state').bind('keyup', ((e)->
      if e.keyCode == 27 # escape key
        widget.toggleUIStatePanel()
      )
    )

    @$('.save-ui-state input').bind('keyup', ((e)->
      if e.keyCode == 13 # escape key
        widget.saveAs($(@))
    ))

    @$('.save-ui-state .cancel').click(->
      widget.toggleUIStatePanel()
    )

    @$('.save-ui-state .save').click(->
      widget.toggleUIStatePanel()
      widget.saveUiState(widget.get('collection.customizationName'))
    )

    @$('.save-ui-state .saveas').click(->
      widget.saveAs($(@))
    )

    $('.keep-open').click((e)->
      e.stopPropagation()
    )

  populateCollectionDropdown: ->
    @$(".load-panel").empty()
    for personalization, index in @get('collection.personalizations').toArray()
      @$(".load-panel").append($('<li><a class="load" data-index="'+index+'">' + personalization.get('name') + '</a></li>'))

    @$(".load-panel .load").click((e)=>
      @initializeWithNewPersonalization($(e.target).attr('data-index'))
    )    
      
  saveAs: (el) ->
    @toggleUIStatePanel()
    customizationName = el.parents('.save-ui-state').find('input').val()
    @saveUiState(customizationName)

  toggleUIStatePanel: ->
    widget = this
    panel = @$('.save-ui-state')
    @$('.save-ui-state').toggleClass('open')        

  saveUiState: (name) ->
    @get('collection').saveUIState(name) if @get('collection')?

  setupCustomizedProperties: ->
    @setupPagingProperties()
    @setupSortingProperties()

  setupPagingProperties: ->
    @setPageSize()

  setPageSize: ->
    # If the collection has a pageSize specified, use that.
    if @get('paged') and @get('pageSize')? and not @get('pagingInfo.pageSize')?
      @set('pagingInfo.pageSize', @get('pageSize'))

  setupSortingProperties: ->

  setupColumnTitleProperties: ->
    # Copy any column titles provided by the collection
    # This is done inside the computed property, so just refresh it.
    @set('colNames', [])

  setupColumnVisibilityProperties: ->
    # Copy any hidden column information provided by the collection
    for name, hidden of @get('columnInfo.hidden')
      for column in @get('columnModel')
        column.hidden = hidden if column.name == name

  setupColumnWidthProperties: ->
    # Copy any column width information provided by the collection
    for name, width of @get('columnInfo.widths')
      for column in @get('columnModel')
        column.width = width if column.name == name

  setupColumnOrderingProperties: ->
    if @get('columnInfo')
      if @get('columnInfo.order')? and not $.isEmptyObject(this.get('columnInfo.order'))
        permutation = [0]
        for column, position in @get('columnModel')
          newPosition = @get('columnInfo.order')[column.name]
          permutation[newPosition] = position+1 if newPosition?
        if permutation.length > 1
          @getTableDom().remapColumns(permutation, true, false)
      else
        permutation = []
        for column, position in @get('columnModel')
          permutation[position] = column.order or position
        @set('columnInfo.order', {})
        @set('columnInfo.order.old', permutation)



  setupColumnGroupingProperties: ->
    if @get('groupingInfo.columnName')? and @get('groupingInfo.type')? 
      @doRemoteGrouping(@get('groupingInfo.type'), @get('groupingInfo.columnName'))
      #@groupByColumn(@get('groupingInfo.columnName'), @get('groupingInfo.type'))

  storeColumnDataToCollection: ->
    if @getTableDom().length > 0
      # Store hidden column data
      if  @get('collection')?
        for col in @getColModel()
          @set('columnInfo.hidden.' + col.name, col.hidden)

      # Store column widths 
      if @get('collection')?
        for col in @getTableDom().get(0).p.colModel
          @set('columnInfo.widths.' + col.name, col.width)

  storeColumnOrderingToCollection: (permutation)->
    oldOrder = @get('columnInfo.order.old')
    if oldOrder?
      for col, position in permutation
        #what was at position 'col' now equals 'position'
        for field of oldOrder
          if oldOrder[field] == col
            match = field
        if match?
          @set('columnInfo.order.' + match, position)
    @set('columnInfo.order.old', Ember.copy(@get('columnInfo.order')))
    console.log("Ordering = " + @get('columnInfo.order'))

  didInsertElement: ->
    if @get('collection')?
      @setupCustomizedProperties()
      @get('collection').goToPage(1)

  onPageOrSort: (postdata)->
    if @get('collection')?
      #  postdata is of the form:
      #       _search: false,  nd: 1349351912240, page: 1, rows: 12, sidx: "", sord: "asc"
      if @shouldSort(postdata)
        @getTableDom().jqGrid('groupingRemove', true)
        @get('collection').sort
          fields: [{sortDir: postdata.sord, field: postdata.sidx}]
      else
        @get('collection').goToPage(postdata.page)

  shouldSort: (postdata)->
    sortable = false
    sortBy = postdata.sidx.split(',')
    newSort = sortBy[sortBy.length-1].trim()
    for columnDef in @get('columns')
      if newSort.indexOf(columnDef.name) > -1 and columnDef.sortable? and columnDef.sortable
        postdata.sidx = columnDef.name
        sortable = true

    sortable and postdata.sidx!="" and (postdata.sidx != @get('sortingInfo.fields.firstObject.field') or postdata.sord != @get('sortingInfo.fields.firstObject.sortDir'))


  restoreUIState: ((index)->
    # Retrieve the first personalization for now.
    @initializeWithNewPersonalization(0)
  ).observes('collection.personalizations','collection.personalizations.@each')

  initializeWithNewPersonalization: (index)->
    if @get('collection.personalizations').toArray().length > 0
      uiState = @get('collection.personalizations').objectAt(index).get('settings')
      @set('collection.customizationName', uiState.customizationName)
      @set('collection.pagingInfo', uiState.paging) if uiState.paging?
      @set('collection.sortingInfo', uiState.sorting) if uiState.sorting?
      @set('collection.filteringInfo', uiState.filtering) if uiState.filtering?
      @set('columnInfo', uiState.columns) if uiState.columns?
      @set('groupingInfo', uiState.grouping) if uiState.grouping?
      @applyStoredPropertiesToGrid()
      @populateCollectionDropdown()


