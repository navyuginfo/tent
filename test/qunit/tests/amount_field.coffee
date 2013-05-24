#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

#
# This module specifically tests AmountField UI Widget part of the tent library.
#
module "Tent.AmountField", ->
    @TemplateTests = Ember.Namespace.create()
  , ->
    if view
      Ember.run -> view.destroy()
      view = null
    @TemplateTests = undefined

test 'Ensure currency is appended and has numeric only', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.AmountField valueBinding="name" 
        labelBinding="label" currencyBinding="currency"}}'
    name: '111111'
    label: 'FooBar'
    currency: 'USD'

  appendView()

  equal view.$('.add-on').text(), view.get('currency'), 'currency is rendered'
  equal view.$('.error').length, 0, 'error class gets applied'


test 'required behaviour', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.AmountField required=true}}'
  appendView()
  
  ok view.$('span.tent-required').length, 1, 'required icon displayed' 

test 'Test for readonly attribute', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.AmountField readOnly=true}}'
  appendView()

  equal view.$('input').attr('readonly'), 'readonly', 'readonly attribute detected'
  equal view.$('input').attr('aria-readonly'), 'true', 'aria-readonly attribute detected'

test 'Test for disabled', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.AmountField disabled=true}}'
  appendView()

  equal view.$('input').attr('disabled'), 'disabled', 'disabled attribute detected'
  equal view.$('input').attr('aria-disabled'), 'true', 'aria-disabled attribute detected'
  
test 'Ensure aria attributes are applied ', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.AmountField required=true  hasErrors=true hasHelpBlock=true}}'
  appendView()
  equal view.$('input[required=required]').length, 1, 'required html5 attribute'
  equal view.$('input[aria-required=true]').length, 1, 'Aria-required'
  debugger;
  viewId = view.$('input').parents('.tent-text-field:first').attr('id')
  equal view.$('input[aria-describedby]').length, 1, 'described-by'
  equal view.$('input').attr('aria-describedby'), viewId+"_error " + viewId + "_help", 'described by value'
  equal $("#" + viewId+"_error").length, 1, 'error field id exists for'
  equal $("#" + viewId+"_help").length, 1, 'help field id exists for'
  
test 'Ensure formatting takes place as per currency', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.AmountField valueBinding="name" 
        labelBinding="label" currencyBinding="currency"}}'
    name: '111111'
    label: 'FooBar'
    currency: 'IQD'
  appendView()
  amountView = Ember.View.views[view.$('.tent-text-field').attr('id')]
  equal view.$('input')[0].value, '111,111.000', 'formatted to 2 decimal places for IQD'

test 'Formatting tests', ->
  amount = Tent.AmountField.create()
  equal amount.format(123), '123.00', '123'
  equal amount.format('123'), '123.00', '123'
  equal amount.format('123,2.3'), '1,232.30', '123,2'

  ok not (amount.unFormat('123' == '123.00')), 'amount is a number not a string'
  ok amount.unFormat('123') == 123.00, '123 number unformat'
  ok amount.unFormat('abc') == 0.00, 'Invalid string returns 0.00'

test 'Currency validation tests', ->
  amount = Tent.AmountField.create()
  amount.set 'currency', 'XXX'
  equal amount.get('isValidCurrency'), false, 'Invalid currency'
  amount.set 'currency', 'JPY'
  equal amount.get('isValidCurrency'), true, 'valid currency'


test 'operators', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.AmountField valueBinding="value" isFilter=true labelBinding="label"}}'
    value: 1
    label: 'FooBar'

  appendView()
  amount = Ember.View.views[view.$('.tent-text-field').attr('id')] 

  Ember.run ->
      view.$('input').eq(0).val('1')
      view.$('input').eq(0).trigger('change')
  equal amount.get('rangeValue'), '1', 'Single value'

  Ember.run ->
      view.$('input').eq(0).val('1')
      view.$('input').eq(0).trigger('change')
      view.$('input').eq(1).val('9')
      view.$('input').eq(1).trigger('change')
  equal amount.get('rangeValue'), '1', 'Single value'

  
###  Ember.run ->
      amount.set('filterOp', 'range')
  Ember.run ->
      view.$('input').eq(0).val('1')
      view.$('input').eq(0).trigger('change')
      view.$('input').eq(1).val('9')
      view.$('input').eq(1).trigger('change')
  equal amount.get('rangeValue')[0], 1, 'Range value is an array [0]'
  equal amount.get('rangeValue')[1], 9, 'Range value is an array [1]'

  Ember.run ->
    amount.set('filterOp', 'lthan')
  equal amount.get('rangeValue'), '1', 'Range value with non-range operator'
###






