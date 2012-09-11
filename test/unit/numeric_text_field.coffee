#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

#
# This module specifically tests NumericTextField UI Widget part of the tent library.
#
module "Tent.NumericTextField", ->
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

test 'Ensure it gives error for non numeric values', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.NumericTextField valueBinding="name" labelBinding="label"}}'
    name: 'foobar'
    label: 'FooBar'

  appendView()
  equal view.$('.error').length, 0, 'error class does not get applied on insertion'

  Ember.run ->
      view.$('input').val('newValue')
      view.$('input').trigger('change')
  equal view.$('.error').length, 1, 'Error reported for non-numeric value'
  equal view.$('.help-inline').text(), Tent.messages.NUMERIC_ERROR, 'Received Tent.messages.NUMERIC_ERROR'  

test 'Ensure it gives no error for numeric values', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.NumericTextField valueBinding="name" labelBinding="label"}}'
    name: '1234'
    label: 'FooBar'

  appendView()

  Ember.run ->
      view.$('input').val('123.456')
      view.$('input').trigger('change')
  equal view.$('.error').length, 0, 'no error class applied'
  equal view.$('.help-inline').text(), '', 'no error received'


test 'Check for formatting', ->
  view = Tent.NumericTextField.create()
  
  equal view.format(123.456), "123.456", 'Convert string to number'
  equal view.format(-123.456), "-123.456", 'Convert string to negative number'
  equal view.format(+123.456), "123.456", 'Convert string to positive number'
  equal view.format(1e3), "1000", 'Exponent'
  equal view.format("abc"), "abc", 'Dont convert a non-number'
  equal view.format(""), "", 'Empty string'
  equal view.format(null), null, 'Dont convert a null'

test 'Check for unformatting', ->
  view = Tent.NumericTextField.create()
  equal view.unFormat("123.456"), 123.456, 'Convert number to string'
  equal view.unFormat("-123.456"), -123.456, 'Convert negative number to string'
  equal view.unFormat("abc"), "abc", 'Dont convert a non-number'
  equal view.unFormat(""), null, 'Empty string should return null'

test 'Formatting is actually called', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.NumericTextField valueBinding="name" labelBinding="label"}}'
    name: +1234
    label: 'FooBar'

  appendView()
  equal view.$('input').val(), '1234', 'Initial DOM value'

  Ember.run ->
      view.$('input').val('newValue')
      view.$('input').trigger('change')
  equal view.get('name'), '1234', 'Controller value is set to 1234'

  Ember.run ->
      view.$('input').val('')
      view.$('input').trigger('change')
  equal view.get('name'), null, 'Controller value is set to null'

test 'Formatting of read-only', ->
  view = Ember.View.create
      template: Ember.Handlebars.compile '{{view Tent.NumericTextField valueBinding="name" 
          labelBinding="label"
          isEditable=false}}'
      name: +1234
      label: 'FooBar'

    appendView()
    equal view.$('.text-display').text(), '1234', 'Initial DOM value'

test 'Mandatory behaviour', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.NumericTextField isMandatory=true}}'
  appendView()
  
  ok view.$('span.tent-mandatory').length, 1, 'mandatory icon displayed' 

test 'Ensure tooltip gets displayed', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.NumericTextField valueBinding="name" 
      labelBinding="label"
      tooltip="tooltip here.."
      }}'
    name: 'foobar'
    label: 'FooBar'
  appendView()

  ok view.$('a[rel=tooltip]')?, 'Tooltip anchor exists'
  equal view.$('a[rel=tooltip]').attr('data-original-title'), "tooltip here..", 'Tooltip text'
  ok typeof view.$("a[rel=tooltip]").tooltip, "function", 'tooltip plugin has been applied'

test 'Ensure aria attributes are applied ', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.NumericTextField isMandatory=true}}'
  appendView()
  equal view.$('input[required=required]').length, 1, 'required html5 attribute'
  equal view.$('input[aria-required=true]').length, 1, 'Aria-required'
