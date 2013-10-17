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
  equal view.$('.help-inline').text(), Tent.I18n.loc(Tent.messages.NUMERIC_ERROR), 'Received Tent.messages.NUMERIC_ERROR'

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
  equal view.format(null), "", 'Dont convert a null'

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
      view.$('input').trigger('focusout')
  equal view.get('name'), '1234', 'Controller value is set to 1234'

  Ember.run ->
      view.$('input').val('')
      view.$('input').trigger('focusout')
  equal view.get('name'), null, 'Controller value is set to null'

test 'Formatting of read-only', ->
  view = Ember.View.create
      template: Ember.Handlebars.compile '{{view Tent.NumericTextField valueBinding="name" 
          labelBinding="label"
          textDisplay=true}}'
      name: +1234
      label: 'FooBar'

    appendView()
    equal view.$('.text-display').text(), '1234', 'Initial DOM value'

test 'Required behaviour', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.NumericTextField required=true}}'
  appendView()
  
  ok view.$('span.tent-required').length, 1, 'required icon displayed' 

test 'Test for readonly attribute', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.NumericTextField readOnly=true}}'
  appendView()

  equal view.$('input').attr('readonly'), 'readonly', 'readonly attribute detected'
  equal view.$('input').attr('aria-readonly'), 'true', 'aria-readonly attribute detected'

test 'Test for disabled', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.NumericTextField disabled=true}}'
  appendView()

  equal view.$('input').attr('disabled'), 'disabled', 'disabled attribute detected'
  equal view.$('input').attr('aria-disabled'), 'true', 'aria-disabled attribute detected'
  
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
    template: Ember.Handlebars.compile '{{view Tent.NumericTextField required=true  hasErrors=true hasHelpBlock=true}}'
  appendView()
  equal view.$('input[required=required]').length, 1, 'required html5 attribute'
  equal view.$('input[aria-required=true]').length, 1, 'Aria-required'

  viewId = view.$('input').parents('.tent-text-field:first').attr('id')
  equal view.$('input[aria-describedby]').length, 1, 'described-by'
  equal view.$('input').attr('aria-describedby'), viewId+"_error " + viewId + "_help", 'described by value'
  equal $("#" + viewId+"_error").length, 1, 'error field id exists for'
  equal $("#" + viewId+"_help").length, 1, 'help field id exists for'

test 'operators', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.NumericTextField valueBinding="name" isFilter=true labelBinding="label"}}'
    value: 1
    label: 'FooBar'

  appendView()
  numeric = Ember.View.views[view.$('.tent-text-field').attr('id')] 

  Ember.run ->
      view.$('input').eq(0).val('1')
      view.$('input').eq(0).trigger('change')
  equal numeric.get('rangeValue'), '1', 'Single value'

  Ember.run ->
      view.$('input').eq(0).val('1')
      view.$('input').eq(0).trigger('change')
      view.$('input').eq(1).val('9')
      view.$('input').eq(1).trigger('change')
  equal numeric.get('rangeValue'), '1', 'Single value'

  
  Ember.run ->
      numeric.set('filterOp', 'range')
  Ember.run ->
      view.$('input').eq(0).val('1')
      view.$('input').eq(0).trigger('change')
      view.$('input').eq(1).val('9')
      view.$('input').eq(1).trigger('change')
  equal numeric.get('rangeValue').split(',')[0], 1, 'Range value is a comma-separated string'
  equal numeric.get('rangeValue').split(',')[1], 9, 'Range value is an array [1]'

  Ember.run ->
    numeric.set('filterOp', 'lthan')
  equal numeric.get('rangeValue'), '1', 'Range value with non-range operator'







