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
  pageSize: null
  
  pagingInfoBinding: 'collection.pagingInfo'
  sortingInfoBinding: 'collection.sortingInfo'
  columnInfoBinding: 'collection.columnInfo'
  groupingInfoBinding: 'collection.groupingInfo'

  ###*
  * @property {Boolean} scroll A boolean indicating that the grid should scroll vertically rather than paging
  ###
  scroll: false
   
  init: ->
    @_super(arguments)
    if @get('collection')?
      @setupCustomizedProperties()
      @addScrollPropertyToCollection()      

  addScrollPropertyToCollection: (->
    @set('collection.scroll', @get('scroll')) if @get('collection')?
  ).observes('scroll','collection')

  addNavigationBar: ->
    @_super()
    if @get('collection.personalizable') and (@get('usageContext') != 'report')
      @renderSaveUIStateButton() if @get('collection')? 
      @renderCollectionName()
      @populateCollectionDropdown()

  renderSaveUIStateButton: ->
    widget = @
    button = """
        <div class="button-wrapper save-ui-state">
          <a data-toggle="dropdown" class="button-control"><i class="icon-camera"></i><span class="custom-name"></span><span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a class="save">#{Tent.I18n.loc("tent.button.save")}</a></li>
            <li class="dropdown-submenu">
              <a>#{Tent.I18n.loc("tent.button.saveAs")}</a>
              <ul class="dropdown-menu save-as-panel">
                  <p>#{Tent.I18n.loc("tent.jqGrid.saveUi.message")}</p>
                  <p><input type="text" class="input-medium keep-open" value="#{widget.get('collection.customizationName')}"/></p>
                  <div><a class='btn pull-left cancel'>#{Tent.I18n.loc("tent.button.cancel")}</a><a class='btn pull-right saveas'>#{Tent.I18n.loc("tent.button.save")}</a></div>
              </ul>
            </li> 
            <li class="dropdown-submenu">
              <a>#{Tent.I18n.loc("tent.button.load")}</a>
              <ul class="dropdown-menu load-panel">
              </ul>
            </li>  
          </ul>
        </div>
    """
    @$(".grid-header .left").append(button)

    if (Tent.Browsers.isIE())
      @$('.save-ui-state .save-as-panel').mouseleave((e)->
        $('body').focus()
      )
    @$('.save-ui-state').bind('keyup', ((e)->
      if e.keyCode == 27 # escape key
        $('body').focus() if (Tent.Browsers.isIE())
        widget.toggleUIStatePanel()
      )
    )

    @$('.save-ui-state input').bind('keyup', ((e)->
      widget.observeValueInput($(this))
      if e.keyCode == 13 # return key
        $('body').focus() if (Tent.Browsers.isIE())
        widget.saveAs($(@))
    ))

    @$('.save-ui-state .cancel').click(->
      widget.toggleUIStatePanel()
    )

    @$('.save-ui-state .save').click(->
      if not $(this).hasClass('disabled')
        widget.save()
    )

    @$('.save-ui-state .saveas').click(->
      if not $(this).hasClass('disabled') and widget.getInputField().val().trim() != ""
        widget.saveAs($(@))
    )

    $('.keep-open').click((e)->
      e.stopPropagation()
    )

  renderCollectionName: (->
    if @get('collection')? and @get('collection.isCustomizable') and @get('collection.customizationName')?
      @$(".grid-header .custom-name").text(@get('collection.customizationName'))
    if @get('collection.isShowingDefault')
      @disableSaveButton()
    else 
      @enableSaveButton()
    @observeValueInput(@getInputField())
  ).observes('collection.customizationName')

  populateCollectionDropdown: (->
    if @$()?
      @$(".load-panel").empty()
      @$(".load-panel").append('<li><a class="load" data-index="-1">' + Tent.I18n.loc("tent.jqGrid.saveUi.default") + '</a></li>')
      if @get('collection.personalizations')?
        for personalization, index in @get('collection.personalizations').toArray()
          @$(".load-panel").append($('<li><a class="load" data-index="'+index+'" data-name="'+personalization.get('name')+'">' + personalization.get('name') + '</a></li>'))

      @$(".load-panel .load").click((e)=>
        index = $(e.target).attr('data-index')
        name = $(e.target).attr('data-name')
        @set('customizationIndex', index)
        @set('customizationName', name)
        @initializeFromCustomizationIndex(index)
      )
  ).observes('collection.personalizations', 'collection.personalizations.@each')
  
  getInputField: ->
     @$('.save-ui-state input')

  save: -> 
    @toggleUIStatePanel()
    @set('customizationName', @get('collection.customizationName'))
    @saveUiState(@get('collection.customizationName'))

  saveAs: (el) ->
    @toggleUIStatePanel()
    @set('customizationName', el.parents('.save-ui-state').find('input').val())
    @saveUiState(@get('customizationName'))

  toggleUIStatePanel: ->
    widget = this
    panel = @$('.save-ui-state')
    @$('.save-ui-state').toggleClass('open')        

  saveUiState: (name) ->
    @get('collection').saveUIState(name) if @get('collection')?

  disableSaveButton: ->
    @$('.save-ui-state .save').addClass('disabled')

  enableSaveButton: ->
    @$('.save-ui-state .save').removeClass('disabled')

  observeValueInput: ($input)->
    input = $input.val()
    if (!input? or input.trim() == "")
        @disableSaveAsButton()
    else 
        @enableSaveAsButton()

  disableSaveAsButton: ->
    @$('.save-ui-state .saveas').addClass('disabled')

  enableSaveAsButton: ->
    @$('.save-ui-state .saveas').removeClass('disabled')
  
  setupCustomizedProperties: ->
    @setupPagingProperties()
    @setupSortingProperties()

  setupPagingProperties: ->
    @setPageSize()

  setPageSize: ->
    # If the grid specifies a pageSize value, use that; otherwise fallback on 
    # the collection value
    if @get('pageSize')?
      @set('collection.pageSize', @get('pageSize'))
      @set('pagingInfo.pageSize', @get('pageSize')) if @get('pagingInfo')?

  setupSortingProperties: ->

  setupColumnTitleProperties: ->
    # Copy any column titles provided by the collection
    # This is done inside the computed property, so just refresh it.
    @set('colNames', [])

  setupColumnVisibilityProperties: ->
    # Copy any hidden column information provided by the collection
    if this.get('collection.personalizable')
      for name, hidden of @get('columnInfo.hidden')
        for column in @get('columnModel')
          column.hidden = hidden if column.name == name
    #@renderColumnChooser()

  setupColumnWidthProperties: ->
    # Copy any column width information provided by the collection
    if this.get('collection.personalizable')
      for name, width of @get('columnInfo.widths')
        for column in @get('columnModel')
          column.width = width if column.name == name

  setupColumnOrderingProperties: ->
    if this.get('collection.personalizable')
      if @get('columnInfo')
        if @get('columnInfo.order')? and not $.isEmptyObject(this.get('columnInfo.order'))
          permutation = [0]
          if @getColModel() and @getColModel().length > 0 and @getColModel()[0].name != 'cb'
            delete this.get('columnInfo.order')[0]
            order = this.get('columnInfo.order')
            lastkey = null
            for k,v of order
              order[k-1]=v-1
              lastkey = k
            delete this.get('columnInfo.order')[lastkey]
          for column, position in @get('columnModel')
            if @getColModel()[0].name == 'cb' then position = position+1
            column = @get('columnInfo.order')[position]
            permutation[column] = position if column?
          if permutation.length > 1
            @getTableDom().remapColumns(permutation, true, false)
        else
          permutation = [0]
          for column, position in @get('columnModel')
            permutation[position + 1] = column.order or (position + 1)
          @set('columnInfo.oldOrder', permutation)


  setupColumnGroupingProperties: ->
    if @get('groupingInfo.columnName')? and @get('groupingInfo.type')? 
      @doRemoteGrouping(@get('groupingInfo.type'), @get('groupingInfo.columnName'))
      #@groupByColumn(@get('groupingInfo.columnName'), @get('groupingInfo.type'))

  storeColumnDataToCollection: ->
    if @getTableDom().length > 0
      # Store hidden column data
      if  @get('columnInfo')?
        for col in @getColModel()
          @set('columnInfo.hidden.' + col.name, col.hidden)

      # Store column widths 
      if @get('columnInfo')?
        for col in @getTableDom().get(0).p.colModel
          @set('columnInfo.widths.' + col.name, col.width)

  storeColumnOrderingToCollection: (permutation)->
    if @get('columnInfo')?
      oldOrder = @get('columnInfo.oldOrder')
      if @getColModel() and @getColModel().length > 0 and @getColModel()[0].name != 'cb'
        permutation.unshift(0)
        permutation = permutation.map((item)->
                        item+1
                      )
        permutation[0] = 0
      if oldOrder?
        for col, position in permutation
          #what was at position 'col' now equals 'position'
          match = null
          for field of oldOrder
            if oldOrder[field] == col
              match = field
          if match?
            @set('columnInfo.order.' + match, position)
      @set('columnInfo.oldOrder', Ember.copy(@get('columnInfo.order')))
      console.log("Ordering = " + @get('columnInfo.order'))

  didInsertElement: ->
    if @get('collection')?
      @setupCustomizedProperties()
      #@get('collection').goToPage(1)

  onPageOrSort: (postdata, id, rcnt)->
    if @get('collection')?
      if @get('scroll')
        @set('rcnt', rcnt or 0)
      #  postdata is of the form:
      #       _search: false,  nd: 1349351912240, page: 1, rows: 12, sidx: "", sord: "asc"
      if @shouldSort(postdata)
        @getTableDom().jqGrid('groupingRemove', true)
        @get('collection').sort
          fields: [{sortDir: postdata.sord, field: postdata.sidx}]
      else
        unless @get('collection.personalizationsRecord') and not @get('collection.personalizationsRecord.isLoaded')
          @get('collection').goToPage(postdata.page)

  shouldSort: (postdata)->
    sortable = false
    sortBy = postdata.sidx.split(',')
    newSort = sortBy[sortBy.length-1].trim()
    if @get('columns')?
      for columnDef in @get('columns')
        if newSort.indexOf(columnDef.name) > -1 and columnDef.sortable? and columnDef.sortable
          postdata.sidx = columnDef.name
          sortable = true

    sortable and postdata.sidx!="" and (postdata.sidx != @get('sortingInfo.fields.firstObject.field') or postdata.sord != @get('sortingInfo.fields.firstObject.sortDir'))


  personalizationWasAdded: (->
    @initializeFromCollectionPersonalizationName()
  ).observes('collection.personalizations.@each')

  initializeFromCollectionPersonalizationName: ->
    if @get('collection')?
      personalization = @get('collection').getSelectedPersonalization()

      if personalization?
        settings = personalization.get('settings')
      else
        settings = @get('collection.defaultPersonalization')
        settings.filtering = @get('collection.defaultFiltering')
        
      @updateCollectionWithNewPersonalizationValues(@get('collection.customizationName'), settings)
      @updateGridWitNewPersonalizationValues(settings)

  getPersonalizationFromName: (name) ->
    matches = @get('collection.personalizations').filter((item)=> item.get('name') ==  name)
    matches[0] if matches.length > 0

  initializeFromCustomizationIndex: (index)->
    customization = @get('customizationName')

    if Number(index) == -1
      settings = @get('collection.defaultPersonalization')
      settings.filtering = @get('collection.defaultFiltering')
      customizationName = settings.customizationName
    else
      if @get('customizationName') != @get('collection.customizationName') and @get('collection.personalizations').objectAt(index)?
        settings = @get('collection.personalizations').objectAt(index).get('settings')
        customizationName = @get('collection.personalizations').objectAt(index).get('name')

    @updateCollectionWithNewPersonalizationValues(customizationName, settings)
    @updateGridWitNewPersonalizationValues(settings)

  updateCollectionWithNewPersonalizationValues: (name, settings) ->
    @set('collection.customizationName', name)
    @set('collection.pagingInfo', jQuery.extend(true, {}, settings.paging)) if settings.paging?
    @set('collection.sortingInfo', jQuery.extend(true, {}, settings.sorting)) if settings.sorting?
    @set('collection.filteringInfo', jQuery.extend(true, {}, settings.filtering)) if settings.filtering?

  updateGridWitNewPersonalizationValues: (settings) ->
    @set('columnInfo', jQuery.extend(true, {}, settings.columns)) if settings.columns?
    @set('groupingInfo', jQuery.extend(true, {}, settings.grouping)) if settings.grouping?
    @applyStoredPropertiesToGrid()
    @populateCollectionDropdown()

