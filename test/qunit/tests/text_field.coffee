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

  equal view.$('input').length, 1, 'text input field gets rendered'
  equal view.$('.tent-text-field').length, 1, 'tent-text-field class gets applied'
  equal view.$('label').text().trim(), view.get('label'), 'label is rendered'
  equal view.$('label').attr('for'), view.$('input').attr('id'), 'label has the correct "for" attribute'

test 'Ensure Textfield renders Span if isEditable=false', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.TextField valueBinding="name" 
      labelBinding="label" isEditable=false}}'
    name: 'foobar'
    label: 'FooBar'

  appendView()
  
  equal view.$('span.text-display').length, 1, 'span gets rendered'
  equal $('.controls span').text(), view.get('name') , 'value is set to span'
  

test 'Ensure Textfield renders Span if textDisplay=true', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.TextField valueBinding="name" 
      labelBinding="label" textDisplay=true}}'
    name: 'foobar'
    label: 'FooBar'

  appendView()
  
  equal view.$('span.text-display').length, 1, 'span gets rendered'
  equal $('.controls span').text(), view.get('name') , 'value is set to span'
 

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

test 'Ensure required check', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.TextField valueBinding="name" 
      labelBinding="label"
      required=true
      isValidBinding="isValid"}}'
    name: 'foobar'
    label: 'FooBar'

  appendView()

  ok view.$('span.tent-required').length, 1, 'required icon displayed' 

  Ember.run ->
    view.$('input').val('newValue')
    view.$('input').trigger('change')
  ok view.get('isValid')

  Ember.run ->
    view.$('input').val('')
    view.$('input').trigger('change')
  ok not view.get('isValid')  

test 'Test for readonly', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.TextField valueBinding="name" 
      labelBinding="label"
      isMandatory=true
      readOnly=true
      isValidBinding="isValid"}}'
    name: 'foobar'
    label: 'FooBar'
  appendView()

  equal view.$('input').attr('readonly'), 'readonly', 'readonly attribute detected'
  equal view.$('input').attr('aria-readonly'), 'true', 'aria-readonly attribute detected'

test 'Test for disabled', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.TextField disabled=true}}'
  appendView()

  equal view.$('input').attr('disabled'), 'disabled', 'disabled attribute detected'
  equal view.$('input').attr('aria-disabled'), 'true', 'aria-disabled attribute detected'
 

test 'Ensure tooltip gets displayed', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.TextField valueBinding="name" 
      labelBinding="label"
      isMandatory=true
      isValidBinding="isValid"
      tooltip="tooltip here.."
      }}'
    name: 'foobar'
    label: 'FooBar'
  appendView()

  equal view.$('a[rel=tooltip]').length, 1, 'Tooltip anchor exists'
  equal view.$('a[rel=tooltip]').attr('data-original-title'), "tooltip here..", 'Tooltip text'
  ok typeof view.$("a[rel=tooltip]").tooltip, "function", 'tooltip plugin has been applied'

test 'Ensure aria attributes are applied ', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.TextField required=true hasErrors=true hasHelpBlock=true}}'
  appendView()
  equal view.$('input[required=required]').length, 1, 'required html5 attribute'
  equal view.$('input[aria-required=true]').length, 1, 'Aria-required'

  viewId = view.$('input').parents('.tent-text-field:first').attr('id')
  equal view.$('input[aria-describedby]').length, 1, 'described-by'
  equal view.$('input').attr('aria-describedby'), viewId+"_error " + viewId + "_help", 'described by value'
  equal $("#" + viewId+"_error").length, 1, 'error field id exists for'
  equal $("#" + viewId+"_help").length, 1, 'help field id exists for'

test 'Ensure that the text entered gets trimmed value check', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.TextField valueBinding="name"
              labelBinding="label"
              required=true}}'
    name: 'foobar'
    label: 'FooBar'

  appendView()

  Ember.run ->
    view.$('input').val('   newValue   ')
    view.$('input').trigger('change')
  ok view.$('input').val() is 'newValue'
