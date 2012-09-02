#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

#
# This module specifically tests UI Widgets part of the tent library.
#
module "Tent.TextField", ->
    @TemplateTests = Ember.Namespace.create()
    Ember.run ->
      @dispatcher = Ember.EventDispatcher.create()
      @dispatcher.setup()
  , ->
    if view
      Ember.run -> view.destroy()
      view = null
    @TemplateTests = undefined
    @dispatcher.destroy()

test 'Ensure TextField renders for text', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.TextField valueBinding="name" labelBinding="label"}}'
    name: 'foobar'
    label: 'FooBar'

  appendView()

  ok view.$('input')?, 'text input field gets rendered'
  equal view.$('.tent-text-field').length, 1, 'tent-text-field class gets applied'
  equal view.$('label').text(), view.get('label'), 'label is rendered'

test 'Ensure Textfield renders Span if isEditable=false', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.TextField valueBinding="name" labelBinding="label" isEditable=false}}'
    name: 'foobar'
    label: 'FooBar'

  appendView()
  
  ok view.$('span')?, 'span gets rendered'
  equal $('.controls span').text(), view.get('name') , 'value is set to span'
  equal view.$('.uneditable-input').length, 1, 'uneditable-input class gets applied'

test 'Ensure value is propagated back from DOM to controller', ->

  TemplateTests.controller = Ember.Object.create
    content: 'foobar'

  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.TextField
      valueBinding="TemplateTests.controller.content"
      labelBinding="label"
      isEditable=true}}'
    label: 'FooBar'

  appendView()
  
  equal view.$('input').val(), 'foobar', 'Initial DOM value'
  equal TemplateTests.controller.get('content'), 'foobar', 'Initial controller value"'

  Ember.run ->
    view.$('input').val('newValue')
    view.$('input').trigger('change')
  equal view.$('input').val(), 'newValue', 'Dom value changed'
  equal TemplateTests.controller.get('content'), 'newValue', 'Controller value is set to "newValue"'

  Ember.run ->
    TemplateTests.controller.set('content', 'resetValue') 
  equal view.$('input').val(), 'resetValue', 'DOM value is reset'
  
