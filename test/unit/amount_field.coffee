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
  
  ok view.$('span.tent-mandatory').length, 1, 'required icon displayed' 

test 'Test for readonly attribute', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.AmountField readOnly=true}}'
  appendView()

  equal view.$('input').attr('readonly'), 'readonly', 'readonly attribute detected'

test 'Test for disabled', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.AmountField disabled=true}}'
  appendView()

  equal view.$('input').attr('disabled'), 'disabled', 'disabled attribute detected'

test 'Ensure aria attributes are applied ', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.AmountField isMandatory=true}}'
  appendView()
  equal view.$('input[required=required]').length, 1, 'required html5 attribute'
  equal view.$('input[aria-required=true]').length, 1, 'Aria-required'

test 'Ensure formatting help is displayed', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.AmountField valueBinding="name" 
        labelBinding="label" currencyBinding="currency"}}'
    name: '111111'
    label: 'FooBar'
    currency: 'USD'
  appendView()
  amountView = Ember.View.views[view.$('.tent-text-field').attr('id')]
  equal view.$('.help-block').text(), amountView.getFormatPattern(), 'Format pattern was displayed'


test 'Formatting tests', ->
  amount = Tent.AmountField.create()
  equal amount.format(123), '123.00', '123'
  equal amount.format('123'), '123.00', '123'
  equal amount.format('123,2.3'), '1,232.30', '123,2'

  ok not (amount.unFormat('123' == '123.00')), 'amount is a number not a string'
  ok amount.unFormat('123') == 123.00, '123 number unformat'
  ok amount.unFormat('abc') == 0.00, 'Invalid string returns 0.00'

