Tent.Tree = Ember.View.extend
  
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
  content: {}
  selection: []

  template:(->
    guid = Ember.guidFor(@)
    Ember.Handlebars.compile("<div id='#{guid}-tree' {{bindAttr class='radio:fancytree-radio'}}></div>")
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

  didInsertElement: ->
    options = $.extend(
      {source: @get('content')}, 
      @getTreeEvents(), 
      @getNodeEvents(), 
      @getDefaultSettings()
    )
    @$("##{Ember.guidFor(@)}-tree").fancytree(options)

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
    for event in nodeEvents
      options[event] = ((e, data) => @[event].call(@, e, data)) if @[event]?
    options

  getDefaultSettings: ->
    options = {}
    defaultSettings = ['activeVisible', 'autoActivate', 'autoCollapse', 'autoScroll',
                      'checkbox', 'clickFolderMode', 'disabled', 'extensions', 'generateIds',
                      'icons', 'keyboard', 'nolink', 'selectMode', 'tabbable', 'minExpandLevel']
    options[setting] = @get(setting) for setting in defaultSettings
    options

  getTreeDom: ->
    @$("##{Ember.guidFor(@)}-tree")
  
  getTree: ->
    @getTreeDom().fancytree('getTree')

  enable: ->
    @getTreeDom().fancytree('enable') if @getTreeDom().fancytree('option', 'disabled')

  disable: ->
    @getTreeDom().fancytree('disable') if not @getTreeDom().fancytree('option', 'disabled')

  getRootNode: ->
    @getTreeDom().fancytree('getRootNode')
    
  expandAll: ->
    @getRootNode().visit (node) ->
      node.setExpanded(true)

  collapseAll: ->
    @getRootNode().visit (node) ->
      node.setExpanded(false)

  toggleExpand: ->
    @getRootNode().visit (node) ->
      node.toggleExpanded()

  selectAll: ->
    @getTree().visit((node) -> node.setSelected(true))

  deselectAll: ->
    @getTree().visit((node) -> node.setSelected(false))

  toggleSelect: ->
    @getTree().visit((node) -> node.toggleSelected())

  getActiveNode: ->
    @getTreeDom().fancytree('getActiveNode')

  toJSON: ->
    JSON.stringify(@getTree().toDict(true))

  getNode: (id) ->
    @getTree().getNodeByKey(id)

  focusNode: (id) ->
    @getTree().activateKey(id)

  setNodeTitle: (title, id) ->
    if id?
      @getNode(id).setTitle(title)
    else
      @getActiveNode().setTitle(title)

  sortTree: (compareFunction, deepSort = true) ->
    @getRootNode().sortChildren(compareFunction, deepSort)

  sortActiveBranch: (compareFunction, deepSort = true) ->
    @getActiveNode().sortChildren(compareFunction, deepSort)

  addChildren: (node, options) ->
    node.addChildren(options)

  addChildrenToActiveNode: (options) ->
    @addChildren(@getActiveNode(), options)

  addChildrenToRootNode: (options) ->
    @addChildren(@getRootNode(), options)

  addChildrenToNode: (nodeId, options) ->
    @addChildren(@getNode(nodeId), options)

  replaceChildren: (node, options) ->
    node.fromDict(options)

  replaceRootChildren: (options) ->
    @replaceChildren(@getRootNode(), options)

  replaceActiveNodeChildren: (options) ->
    @replaceChildren(@getActiveNode(), options)

  getSelectedNodes: ->
    @getTreeDom().getSelectedNodes()

  select: (e, data) ->
    selectedNodes = data.tree.getSelectedNodes()
    @set 'selection', selectedNodes.mapProperty('value')