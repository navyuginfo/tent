#
# Copyright PrimeRevenue, Inc. 2013
# All rights reserved.
#

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

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
  node1 = {
    title: 'Node 1',
    folder: true,
    tooltip: "tooltip for node1",
    extraclasses: 'extra-class1 extra-class2',
    expanded: true,
    children:[
      {title: 'child-1 for node1', value: 'value-1'},
      {title: 'child-2 for node2', value: 100}
    ]
  }
  node2: {
    title: 'Node 2',
    folder: true,
    children:[{title: '<span>child with <b>html</b> title</span>', value: [1,2,3]}]
  }
  node3: {title: 'Just a node', value: {name: 'Tent'}}
  Application.set "content", [node1, node2, node3]