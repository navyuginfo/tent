#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
# Always pass an array to the list binding and default selection even 
# if there is only one item in the array for table view 
#

require '../template/table'
require '../template/table_row'

Tent.Table = Ember.View.extend
  classNames: ['table','table-condensed']
  classNameBindings: ['isBordered:table-bordered']
  tagName: 'table'
  templateName: 'table'
  isBordered: true

  _columnHeaders: (->
    @get('headers').split(',') if @get('headers')?
  ).property('headers')

  visibleHeaders: (-> @get('_columnHeaders')).property('_columnHeaders')

  _columns: (->
    @get('columns').split(',') if @get('columns')?
    ).property('columns')

  visibleColumns: (-> @get('_columns')).property('_columns')

  init: ->
    @_super()
    @set('multiselection', false) if @get('multiselection') == undefined
    @set('isEditable', true) if @get('isEditable') == undefined
    if not @get('_list')? 
      @createListProxy()

  createListProxy: ->
    @set '_list', Tent.SelectableArrayProxy.create
      content: @get('list')
    @get('_list').set('isMultipleSelectionAllowed', @get('multiselection'))

  isRowSelected: (row) ->
    if (selElements = @get('_list').get('selected')) isnt null
      #for the time when page first renders or when nothing is selected
      rowContent = row.get('content')
      return true if selElements.contains(rowContent)
      selElements.some (element) ->
        return true if element == rowContent

        elementId = Ember.get(element, 'id')
        rowId = Ember.get(rowContent, 'id')
        return elementId == rowId if elementId? && rowId?
        false
    else
      false

  ##
  # method to populate the new list of items or push a single item
  ##
  select: (selection) ->
    if selection and selection instanceof Array
      prevSelection = @get('_list.selected')
      if prevSelection
        for element in prevSelection
          @select element
      if selection
        for element in selection
          @select element
    else
      if not @get('_list')? 
        @createListProxy()
      @get('_list').set('selected', selection)

  selectAll: (->
    if @get('allSelected')
      @get('_list').selectAll()
    else
      @get('_list').clearSelection()
  ).observes('allSelected')

  updateContent: ( ->
    @get('_list').set('content',@get('list'))
  ).observes('list') 

  ##
  # Compute the selected list of items associated with
  # table
  ##
  selection: ((key,value)->
    if value isnt undefined
      @select value
    else
      @get('_list.selected')
  ).property('_list.selected')
  


Tent.TableRow = Ember.View.extend
  tagName: 'tr'
  templateName: 'table_row'
  classNameBindings: ['isSelected:tent-selected']
  parentTableBinding: 'parentView.parentView'
  didInsertElement: ->
    if @get('parentTable').get('isEditable')
      # checks the radioButtons/checkboxes in case of defaultselection
      @checkSelection()

  format: (columnName, columnValue) ->
    if (formatterProvider = @get('parentTable.formatter'))?
      tableContent = @get('parentTable.list')
      formatter = formatterProvider(tableContent, columnName)
      return formatter.format(columnValue) if formatter?
    columnValue

  isSelected: (-> 
    @get('parentTable').isRowSelected(this)
  ).property('parentTable.selection')
  
  checkSelection: (-> 
    if @get 'isSelected'
      @$('input').prop('checked',true) 
    else
      @$('input').prop('checked',false)
  ).observes('isSelected')
  
  mouseUp: (event)->
    @get('parentTable').select(@get('content')) if @get('parentTable').get('isEditable')
    # to remove default click events of checkbox and radiobuttons
    @$("input").click (event) ->
      $(@).prop('checked',false) if $(@).prop('checked') 
      false if event.target is @
    
Tent.TableCell = Ember.View.extend
  tagName: 'td'
  classNameBindings: ['isRadio:tent-width-small']
  
  defaultTemplate: Ember.Handlebars.compile('{{view.formattedColumnValue}}')
  
  row: (->
    @get('parentView').get('parentView')
  ).property('parentView')

  formattedColumnValue: (->
    columnName = @get('content')
    columnValue = @get('row.content.' + columnName)
    @get('row').format(columnName, columnValue)
  ).property('row', 'content')

Tent.TableHeader = Ember.View.extend
  tagName: 'th'
  defaultTemplate: Ember.Handlebars.compile('{{view.printableColumnName}}')
  printableColumnName: (->
    columnName = Tent.I18n.loc(@get('content'))
    columnName.camelToWords() if typeof(columnName) == 'string'
  ).property('content')
