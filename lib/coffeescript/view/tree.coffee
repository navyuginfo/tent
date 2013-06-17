#
# Copyright PrimeRevenue, Inc. 2013
# All rights reserved.
#

###*
* @class Tent.Tree
*
* Usage
*        {{view Tent.Tree
            contentBinding="" 
            selectionBinding="" 
            aria=""
            activeVisible=""
            autoActivate=""
            autoScroll=""
            checkbox=""
            folderOnClickShould=""
            disabled=""
            icons=""
            keyboard=""
            nodeSelection=""
            tabbable=""
            radio=""
          }}

###
Tent.Tree = Ember.View.extend
  template:(->
    # Each tree needs to have a unique HTML id
    # Ember creates a guid for every view while inserting it, so using the same and appending
    # "-tree" to create HTML id for the fancytree instance
    guid = Ember.guidFor(@)
    Ember.Handlebars.compile("""
      <div id="#{guid}-tree" {{bindAttr class="view.radio:fancytree-radio"}}></div>
    """)
  ).property()

  ###*
  * @property {Boolean} [aria=false] A boolean property which enables/disables WAI-ARIA support.
  ###
  aria: false

  ###*
  * @property {Boolean} [activeVisible=true] A boolean property which makes sure active nodes
  * are visible (expanded).
  ###
  activeVisible: true

  ###*
  * @property {Boolean} [autoActivate=true] A boolean property indicating whether to
  * automatically activate a node when it is focused (using keys).
  ###
  autoActivate: true 

  ###*
  * @property {Boolean} [autoCollapse=false] A boolean property indicating whether to
  * automatically collapse all siblings, when a node is expanded.
  ###
  autoCollapse: false

  ###*
  * @property {Boolean} [autoScroll=false] A boolean property indicating whether to
  * automatically scroll nodes into visible area
  ###
  autoScroll: false

  ###*
  * @property {Boolean} [checkbox=false] A boolean property responsible for displaying
  * checkboxes on the nodes.
  ###
  checkbox: false

  ###*
  * @property {String} folderOnClickShould The property responsible for the folder click behaviour
  * If the value is 'expandOnDblClick' the folder expands only on double click
  * If the value is 'activate' the folder gets activated (not selected) on click
  * If the value is 'expand' the folder expands on click (not selected & activated)
  * If the value is 'activateAndExpand' the folder is expanded & activated on click
  ###
  folderOnClickShould: 'expandOnDblClick'

  ###*
  * @property {Boolean} [disabled=false] A boolean property responsible for enabling/disabling
  * the entire tree
  ###
  disabled: false

  ###*
  * @property {Array} extensions built for the fancytree widget which we wish to load
  * must be specified here.
  ###
  extensions: []

  ###*
  * @property {Boolean} [generateIds=true] A boolean property indicating whether to generate
  * unique ids for li elements.
  ###
  generateIds: false

  ###*
  * @property {Boolean} [icons=true] when true icons for the nodes are displayed on the UI
  ###
  icons: false

  ###*
  * @property {Boolean} [keyboard=true] A boolean property indicating keyboard navigation support
  ###
  keyboard: true

  ###*
  * @property {String} nodeSelecion The property resposible for node selection behaviour
  * If the value is 'singleSelect' user can select only one node
  * If the value is 'multiSelect' user can select multiple nodes
  * If the value is 'heirMultiSelect' user can select all the children on selecting parent node
  ###
  nodeSelection: 'multiSelect'

  ###*
  * @property {Boolean} [tabbable=true] a boolean indicating whether the whole tree behaves as one single control
  ###
  tabbable: true

  ###*
  * @property {Integer} minExpandLevel Locks expand/collapse for all the nodes on the given minExpandLevel value
  ###
  minExpandLevel: 1

  ###*
  * @property {Boolean} [radio=false] Displays radio buttons instead of checkboxes when set to true
  * property checkbox must be set to true in order to see the radio button.
  * To simulate radio group behavior the property nodeSelection must be set to 'singleSelect'
  * else we will have multi-select radio buttons.
  ###
  radio: false

  ###*
  * @property {Array} content an array of parent child relationship which is responsible for 
  * rendering the tree.
  * Example:
  * [
  *  {
  *    title: 'Node Title', 
  *    folder: true, // the value must be set to true else folderOnClickShould value wont have any effect
  *    tooltip: 'tooltip that needs to be displayed for the node on hover',
  *    extraClasses: 'class1 class2', //Adding classes to nodes,
  *    expanded: true, //Will be expanded on load
  *    lazy: true, //TODO, children will be loaded via AJAX call
  *    children: [
  *      {
  *        title: "<span>can enter HTML too using a span tag </span>",
  *        value: 100 // if it is a leaf node then we must specify the value, which will be 
  *                  // collected in selection array on selection.
  *      },
  *      {title: 'child 2', value: 'can be any data type'}
  *    ]
  *  }
  * ]
  * 
  ###
  content: Em.A()

  ###*
  * @property {Array} selection an array which holds selected leafnode values from the tree.
  ###
  selection: Em.A()


  selectMode: (->
    switch @get('nodeSelection')
      when 'singleSelect' then 1
      when 'multiSelect' then 2
      when 'heirMultiSelect' then 3
      else 2
  ).property('nodeSelection')

  clickFolderMode:(->
    switch @get('folderOnClickShould')
      when 'activate' then 1
      when 'expand' then 2
      when 'activateAndExpand' then 3
      when 'expandOnDblClick' then 4
      else 4
  ).property('folderOnClickShould')

  # A method which adds array observers which gives us exactly the items which were added
  # or removed. Using this method instead of reinitializing the whole tree with the changed
  # array
  addArrayObservers: (array) ->
    array.addArrayObserver Em.Object.create({
      arrayWillChange: (array, start, removeCount, addCount) =>
        # Here the array is the previous one which will be changed after this hook
        # We can't get the items which were removed once the array changes
        # so grabbing them in arrayWillChange 
        if removeCount && removeCount is array.get('length') # don't want to iterate when all nodes are being removed
          @get('selection').clear()
          @reloadTree([])
          @rerender()
        else if removeCount
          @removeNodes(array[start...start+removeCount])
      arrayDidChange: (array, start, removeCount, addCount) =>
        # Here the array is the changed one
        # We cannot get the information about newly added items until the array
        # changes so grabbing them in arrayDidChange
        if addCount && addCount is array.get('length')
          @reloadTree(array)
        else if addCount
          @addNodes(array[start...start+addCount])
    })

  contentDidChange: (->
    @reloadTree(@get('content'))
    @addArrayObservers(@get('content'))
    @get('selection').clear()
  ).observes('content') # explicitly did not add content.@each

  optionsDidChange: (->
    options = ['activeVisible', 'autoActivate', 'aria', 'autoCollapse', 'autoScroll', 'minExpandLevel',
    'clickFolderMode', 'checkbox', 'disabled', 'icons', 'keyboard', 'selectMode', 'tabbable']
    element = @getTreeDom()
    for name in options
      value = @get(name)
      optionDidChange = value isnt element.fancytree('option', name)
      element.fancytree('option', name, value) if optionDidChange
  ).observes(
    'activeVisible','autoActivate', 'aria', 'autoCollapse', 'autoScroll', 'clickFolderMode',
    'checkbox', 'disabled', 'icons', 'keyboard', 'selectMode', 'tabbable', 'minExpandLevel'
  )

  didInsertElement: ->
    options = $.extend({source: @get('content')}, @getTreeEvents(), @getNodeEvents(), @getDefaultSettings())
    @getTreeDom().fancytree(options)
    unless @get('hasArrayObservers')
      @addArrayObservers(@get('content')) 
      @set 'hasArrayObservers', true

  getTreeEvents: ->
    options = {}
    treeEvents = ['treeInit', 'create']
    for event in treeEvents
      options[event] = ((e, data, flag) => @[event].call(@, e, data, flag)) if @[event]?
    options
  
  getNodeEvents: ->
    options = {}
    nodeEvents = ['beforeActivate', 'activate', 'deactivate', 'beforeSelect', 'select',
                  'beforeExpand', 'collapse', 'expand', 'loadChildren', 'focustree',
                  'blurtree', 'focus', 'blur', 'click', 'dblclick', 'keydown', 'keypress',
                  'createnode', 'rendernode', 'lazyload', 'lazyread']
    widget = @
    for event in nodeEvents
      options[event] = ((e, data) -> widget[e.type.slice(9)](e, data)) if widget[event.toLowerCase()]?
    options

  getDefaultSettings: ->
    options = {}
    defaultSettings = ['aria','activeVisible', 'autoActivate', 'autoCollapse', 'autoScroll',
                      'checkbox', 'clickFolderMode', 'disabled', 'extensions', 'generateIds',
                      'icons', 'keyboard', 'nolink', 'selectMode', 'tabbable', 'minExpandLevel']
    options[setting] = @get(setting) for setting in defaultSettings
    options

  removeNodes: (options) ->
    @removeChildFromRootNode(option) for option in options 
  
  addNodes: (nodes) ->
    @addChildrenToRootNode(node) for node in nodes

  getTreeDom: (-> @$("##{Ember.guidFor(@)}-tree"))
  
  getTree: (-> @getTreeDom().fancytree('getTree'))

  enable: ->
    @getTreeDom().fancytree('enable') if @getTreeDom().fancytree('option', 'disabled')

  disable: ->
    @getTreeDom().fancytree('disable') if not @getTreeDom().fancytree('option', 'disabled')

  reloadTree: ((content) -> @getTree().reload(content))

  getRootNode: (-> @getTreeDom().fancytree('getRootNode'))
    
  expandAll: (-> @getRootNode().visit((node) -> node.setExpanded(true)))

  collapseAll: (-> @getRootNode().visit((node) -> node.setExpanded(false)))

  toggleExpand: (-> @getRootNode().visit((node) -> node.toggleExpanded()))

  selectAll: (-> @getTree().visit((node) -> node.setSelected(true)))

  deselectAll: (-> @getTree().visit((node) -> node.setSelected(false)))

  toggleSelect: (-> @getTree().visit((node) -> node.toggleSelected()))

  getActiveNode: (-> @getTreeDom().fancytree('getActiveNode'))

  # Fetches the JSON format of the tree data
  toJSON: (-> JSON.stringify(@getTree().toDict(true)))

  getNode: ((id) -> @getTree().getNodeByKey(id))

  focusNode: ((id) -> @getTree().activateKey(id))

  setNodeTitle: (title, id) ->
    if id?
      @getNode(id).setTitle(title)
    else
      @getActiveNode().setTitle(title)

  sortTree: (compareFunction, deepSort = true) ->
    @getRootNode().sortChildren(compareFunction, deepSort)

  sortActiveBranch: (compareFunction, deepSort = true) ->
    @getActiveNode().sortChildren(compareFunction, deepSort)

  addChildren: ((node, options) -> node.addChildren(options))

  addChildrenToActiveNode: ((options) -> @addChildren(@getActiveNode(), options))

  addChildrenToRootNode: (options) -> 
    @addChildren(@getRootNode(), options)

  addChildrenToNode: ((nodeId, options) -> @addChildren(@getNode(nodeId), options))

  removeChild: (node, options) ->
    title = options.title
    childNode = node.findFirst (n) ->
      n.title is title
    if childNode.isFolder()
      @recursivelyRemoveNodeChildren(childNode) if childNode.isSelected()
    else
      index = @get('selection').indexOf(childNode.data.value)
      @get('selection').removeAt(index) unless index is -1
    node.removeChild(childNode)
 
  removeChildFromActiveNode: ((options) -> @removeChild(@getActiveNode(), options))

  removeChildFromRootNode: ((options) -> @removeChild(@getRootNode(), options))

  removeChildFromNode: ((nodeId, options) -> @removeChild(@getNode(nodeId), options))

  replaceChildren: ((node, options) -> node.fromDict(options))

  replaceRootChildren: ((options) -> @replaceChildren(@getRootNode(), options))

  replaceActiveNodeChildren: ((options) -> @replaceChildren(@getActiveNode(), options))

  reinitialize: (-> @getTreeDom().fancytree())

  recursivelyAdd: (node) ->
    if node.isFolder()
      return @recursivelyAddNodeChildren(node)
    else
      return @get('selection').pushObject(node.data.value) unless node.isSelected()

  recursivelyAddNodeChildren: (node) ->
    @recursivelyAdd(child) for child in node.children

  recursivelyRemove: (node) ->
    if node.isFolder()
      return @recursivelyRemoveNodeChildren(node)
    else
      index = @get('selection').indexOf(node.data.value)
      return @get('selection').removeAt(index) unless index is -1

  recursivelyRemoveNodeChildren: (node) ->
    @recursivelyRemove(child) for child in node.children

  beforeselect: (e, data) ->
    if data.node.isFolder()
      # We don't need to add value of a node which is a folder(has children) to selection Array
      # unless the nodeSelection is 'heriMultiSelect' because in this case, on clicking the node
      # all the children will be selected 
      return unless @get('nodeSelection') is 'heirMultiSelect'
      # As the method gets executed before the selection happens, isSelected() = true indicates
      # that the node is about to be deselected, hence removing corresponding data
      if data.node.isSelected()
        return @recursivelyRemoveNodeChildren(data.node)
      else
        return @recursivelyAddNodeChildren(data.node)
    else
      # If the node is a leaf node, isSelected() = true inside beforeselect hook indicates
      # the user action for the node is deselection, hence remove that node value from
      # selection array
      if data.node.isSelected()
        index = @get('selection').indexOf(data.node.data.value)
        @get('selection').removeAt(index) unless index is -1
      else
        @get('selection').pushObject(data.node.data.value)