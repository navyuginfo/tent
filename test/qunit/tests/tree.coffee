#
# Copyright PrimeRevenue, Inc. 2013
# All rights reserved.
#

view = null
tree = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

initializeTree = ->
  node1 = {
    title: 'Node 1',
    folder: true,
    key: 'node1',
    tooltip: "tooltip for node1",
    extraclasses: 'extra-class1 extra-class2',
    expanded: true,
    children:[
      {title: 'child-1 for node1', value: 'value-1'},
      {title: 'child-2 for Node 2', value: 100}
    ]
  }
  node2 = {
    title: 'Node 2',
    folder: true,
    key: 'node2',
    children:[{title: '<span>child with <b>html</b> title</span>', value: [1,2,3]}]
  }
  node3 = {title: 'Just a node', value: {name: 'Tent'}}
  Application.set "content", [node1, node2, node3]
  Application.stateSelection = Ember.A()

  view = Ember.View.create({
    app: Application
    template: Ember.Handlebars.compile """
      {{view Tent.Tree 
        elementId="qunit-tree"
        contentBinding="app.content" 
        selectionBinding="Application.stateSelection"
      }}
    """
  })

  appendView()
  tree = Em.View.views['qunit-tree']

setup = ->
  @TemplateTests = Ember.Namespace.create()
  @Application = Ember.Namespace.create()
  Ember.run ->
      @dispatcher = Ember.EventDispatcher.create()
      @dispatcher.setup()

teardown = ->
  if view
      Ember.run -> view.destroy()
      view = null
  Em.run -> 
    dispatcher.destroy()

  @TemplateTests = undefined  
  @Application = null

module "Tent.Tree", setup, teardown

test 'Ensure Tent.Tree renders as per specified array of parent & child nodes', ->
  initializeTree()

  ok view.$().length, 'Tree was rendered'
  equal view.$('.fancytree-folder').length, 2, '2 Folder Nodes rendered'
  equal view.$('.fancytree-expanded.fancytree-folder').length, 1, 'One folder is expanded on init'
  equal view.$('.fancytree-folder.fancytree-expanded .fancytree-title').attr('title'), 'tooltip for node1', 'right folder is expanded'
  equal tree.getNode('node1').children.length, 2, 'node1 has 2 children'
  equal tree.getNode('node2').children.length, 1, 'node2 has 1 child'

test 'Tent.Tree configuration', ->
  initializeTree()
  options = ['aria', 'activeVisible', 'autoActivate', 'autoCollapse', 'autoScroll', 'checkbox', 'disabled',
              'icons', 'keyboard', 'tabbable', 'minExpandLevel', 'clickFolderMode', 'selectMode']

  fancyTreeOptions = tree.getTree().options
  for option in options
    equal tree.get(option), fancyTreeOptions[option], "Default value of the property #{option} is set correctly to #{fancyTreeOptions[option]}"

  for option in options
    switch option
      when 'clickFolderMode' then tree.set(option, 'activateAndExpand')
      when 'selectMode' then tree.set(option, 'heirMultiSelect')
      when 'minExpandLevel' then tree.set(option, 2)
      else tree.set(option, !tree.get(option))

  fancyTreeOptions = tree.getTree().options
  for option in options
    equal tree.get(option), fancyTreeOptions[option], "New value for the property #{option} is set to #{fancyTreeOptions[option]}"

test 'Tent.Tree selections', ->
  initializeTree()
  tree.set('checkbox', true)
  equal tree.get('selection').length, 0, 'Initially the selection array is empty'
  tree.set('nodeSelection', 'heirMultiSelect')
  tree.selectAll()
  equal Application.stateSelection.length, 4, 'Selection has 4 children values'
  ['value-1', 100, [1,2,3], {name: 'Tent'}]
  equal Application.stateSelection[0], 'value-1', 'Selection has right value'
  equal Application.stateSelection[1], 100, 'Selection has right value'
  deepEqual Application.stateSelection[2], [1,2,3], 'Selection has right value'
  deepEqual Application.stateSelection[3], {name: 'Tent'}, 'Selection has right value'
  # deselecting the first folder node which should deselect it's children too
  tree.getTree().visit (node) ->
    node.setSelected(false) if node.key is 'node1'
  equal Application.stateSelection.length, 2, 'New length after deselection is 2'
  deepEqual Application.stateSelection[0], [1,2,3], 'Selection now has array as first element'
  deepEqual Application.stateSelection[1], {name: 'Tent'}, 'Selection now has the hash object as second/last element'

test 'Tent.Tree add children', ->
  initializeTree()
  equal view.$('.fancytree-folder').length, 2, '2 Folder Nodes rendered'
  nodes = [
    {
      title: 'programmatically Added Node', 
      folder:true,
      key: 'pNode',
      children:[
        {
          title: 'programmatically added children',
          value: 'newValue'
        }
      ]
    }
  ]
  tree.addChildrenToRootNode(nodes)
  ok tree.getNode('pNode'), 'New node has been added'
  equal view.$('.fancytree-folder').length, 3, 'An extra folder node has been added to root node'
  tree.set('checkbox', true)
  tree.set('selectMode', 'heirMultiSelect')
  tree.selectAll()
  equal Application.stateSelection.length, 5, 'selection has 5 elements'
  equal Application.stateSelection[4], 'newValue', 'programmatically added value' 

test 'Tent.Tree remove children', ->
  initializeTree()
  arr = tree.get('content')
  tree.set('checkbox', true)
  tree.selectAll()
  equal Application.stateSelection.length, 4, 'Before deletion we had 4 elements in the selection'
  equal view.$('.fancytree-folder').length, 2, 'Before deletion we had 2 folders in the root node'
  tree.get('content').removeObject(arr[0])
  equal Application.stateSelection.length, 2, 'Selection now has 2 elements as the removed node had 2 children'
  equal view.$('.fancytree-folder').length, 1, 'One folder has been removed'
  tree.get('content').clear()
  equal Application.stateSelection.length, 0, 'Selection cleared after all the node deletion'
  equal view.$('.fancytree-node').length, 0, 'All the nodes removed'

test 'Tent.Tree dealing with clearing the content', ->
  initializeTree()
  tree.set('checkbox', true)
  tree.selectAll()
  tree.set('content', [])
  equal view.$('.fancytree-node').length, 0, 'All nodes removed'
  equal tree.get('selection.length'), 0, 'Selection emptied'
  tree.get('content').pushObjects([{title: 'New Node',key: 'newNode', folder: true, children: [{title: 'new child'}]}])
  equal view.$('.fancytree-folder').length, 1, 'One folder node added'
  equal tree.getNode('newNode').children.length, 1, 'New folder node has one child'
  tree.set('content', [{title: 'normal child node 1'}, {title: 'normal child node 2'}])
  equal view.$('.fancytree-folder').length, 0, 'No folder nodes as we did not add any'
  equal view.$('.fancytree-node').length, 2, "2 child nodes"


test 'ContentIsValid', ->
  initializeTree()

  ok tree.contentIsValid(), 'Valid content'

  tree.set('content.isLoadable', true)
  tree.set('content.isLoaded', false)
  ok not tree.contentIsValid(), 'Loadable and not loaded'  

  tree.set('content.isLoadable', true)
  tree.set('content.isLoaded', true)
  ok tree.contentIsValid(), 'loadable and loaded'  

  tree.set('content', null)
  ok not tree.contentIsValid(), 'null content'    

