#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

#
# This module specifically tests AmountField UI Widget part of the tent library.
#
module "Tent.AmountField Widget", ->
    @TemplateTests = Ember.Namespace.create()
  , ->
    if view
      Ember.run -> view.destroy()
      view = null
    @TemplateTests = undefined

test 'Ensure currency is appended and has numeric only', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.AmountField valueBinding="name" labelBinding="label" currencyBinding="currency"}}'
    name: '111111'
    label: 'FooBar'
    currency: 'USD'

  appendView()

  equal view.$('.add-on').text(), view.get('currency'), 'currency is rendered'
  equal view.$('.error').length, 0, 'error class gets applied'

test 'Mandatory behaviour', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.AmountField isMandatory=true}}'
  appendView()
  
  ok view.$('span.tent-mandatory').length, 1, 'mandatory icon displayed' 

test 'Ensure aria attributes are applied ', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.AmountField isMandatory=true}}'
  appendView()
  equal view.$('input[required=required]').length, 1, 'required html5 attribute'
  equal view.$('input[aria-required=true]').length, 1, 'Aria-required'