Tent.Tree = Ember.View.extend
  aria: false  
  activeVisible: true
  autoActivate: true 
  autoCollapse: false
  autoScroll: false
  checkbox: false
  folderOnClickShould: 'expandOnDblClick'
  disabled: false
  extensions: []
  generateIds: false
  icons: false
  keyboard: true
  nodeSelection: 'multiSelect'
  tabbable: true
  nolink: true
  minExpandLevel: 1
  radio: false
  renderTreeFromHTML: false
  content: Em.A()
  selection: []

  template:(->
    unless @get('renderTreeFromHTML')
      guid = Ember.guidFor(@)
      Ember.Handlebars.compile("""
        <div id="#{guid}-tree" {{bindAttr class="view.radio:fancytree-radio"}}></div>
      """)
  ).property()

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

  addArrayObservers: (array) ->
    array.addArrayObserver Em.Object.create({
      arrayWillChange: (array, start, removeCount, addCount) =>
        @removeNodes(array[start...start+removeCount]) if removeCount
      arrayDidChange: (array, start, removeCount, addCount) =>
        @addNodes(array[start...start+addCount]) if addCount
    })

  contentDidChange: (->
    @reloadTree(@get('content'))
    @addArrayObservers(@get('content'))
  ).observes('content') # explicitly did not add content.@each

  optionsDidChange: (->
    options = ['activeVisible', 'autoActivate', 'aria', 'autoCollapse', 'autoScroll', 
    'clickFolderMode', 'checkbox', 'disabled', 'icons', 'keyboard', 'selectMode', 'tabbable']
    for name in options
      element = @getTreeDom()
      value = @get(name)
      optionDidChange = value isnt element.fancytree('option', name)
      element.fancytree('option', name, value) if optionDidChange
  ).observes(
    'activeVisible','autoActivate', 'aria', 'autoCollapse', 'autoScroll', 'clickFolderMode',
    'checkbox', 'disabled', 'icons', 'keyboard', 'selectMode', 'tabbable'
  )

  didInsertElement: ->
    options = $.extend({}, @getTreeEvents(), @getNodeEvents(), @getDefaultSettings())
    if @get('renderTreeFromHTML')
      @$("##{@get('elementId')}").fancytree(options)
    else
      options["source"] = @get('content')
      @$("##{Ember.guidFor(@)}-tree").fancytree(options)
    @addArrayObservers(@get('content'))

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

  removeNodes: (nodes) ->
    @removeChildrenFromRootNode(node) for node in nodes
  
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

  addChildrenToRootNode: ((options) -> @addChildren(@getRootNode(), options))

  addChildrenToNode: ((nodeId, options) -> @addChildren(@getNode(nodeId), options))

  removeChildren: ((node, options) -> node.removeChildren(options))
 
  removeChildrenFromActiveNode: ((options) -> @removeChildren(@getActiveNode(), options))

  removeChildrenFromRootNode: ((options) -> @removeChildren(@getRootNode(), options))

  removeChildrenFromNode: ((nodeId, options) -> @removeChildren(@getNode(nodeId), options))

  replaceChildren: ((node, options) -> node.fromDict(options))

  replaceRootChildren: ((options) -> @replaceChildren(@getRootNode(), options))

  replaceActiveNodeChildren: ((options) -> @replaceChildren(@getActiveNode(), options))

  getSelectedNodes: (-> @getTreeDom().getSelectedNodes())

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
      return @get('selection').removeAt(index)

  recursivelyRemoveNodeChildren: (node) ->
    @recursivelyRemove(child) for child in node.children

  beforeselect: (e, data) ->
    if data.node.isFolder()
      return unless @get('nodeSelection') is 'heirMultiSelect'
      if data.node.isSelected()
        return @recursivelyRemoveNodeChildren(data.node)
      else
        return @recursivelyAddNodeChildren(data.node)
    else
      if data.node.isSelected()
        index = @get('selection').indexOf(data.node.data.value)
        @get('selection').removeAt(index)
      else
        @get('selection').pushObject(data.node.data.value)