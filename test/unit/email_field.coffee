#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

#
# This module specifically tests EmailTextField UI Widget part of the tent library.
#
module "Tent.EmailTextField", ->
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


test 'Ensure the email format error gets applied', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.EmailTextField valueBinding="name" }}'
    name: '.com@foobar'

  appendView()
  equal view.$('.error').length, 0, 'error class should not get applied initially'

  Ember.run ->
    view.$('input').val('test@test.com')
    view.$('input').trigger('change')
  equal view.$('.error').length, 0, 'error class should not get applied initially'

  Ember.run ->
    view.$('input').val('invalidemail')
    view.$('input').trigger('change')
  equal view.$('.error').length, 1, 'error class should now get applied'

  #equal view.$('.help-inline').text(), Tent.messages.EMAIL_FORMAT_ERROR, 'Received Tent.messages.EMAIL_FORMAT_ERROR'   

test 'Ensure the email text field accepts emails', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.EmailTextField valueBinding="name" }}'
    name: 'foobar@foobar.org'

  appendView()

  equal view.$('.error').length, 0, 'no error class applied'
  equal view.$('.help-inline').text(), '', 'no error received'

test 'Required behaviour', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.EmailTextField required=true}}'
  appendView()
  
  ok view.$('span.tent-required').length, 1, 'required icon displayed' 

test 'Test for readonly attribute', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.EmailTextField readOnly=true}}'
  appendView()

  equal view.$('input').attr('readonly'), 'readonly', 'readonly attribute detected'
  equal view.$('input').attr('aria-readonly'), 'true', 'aria-readonly attribute detected'

test 'Test for disabled', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.EmailTextField disabled=true}}'
  appendView()

  equal view.$('input').attr('disabled'), 'disabled', 'disabled attribute detected'
  equal view.$('input').attr('aria-disabled'), 'true', 'aria-disabled attribute detected'
  
test 'Ensure aria attributes are applied ', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.EmailTextField required=true  hasErrors=true hasHelpBlock=true}}'
  appendView()
  equal view.$('input[required=required]').length, 1, 'required html5 attribute'
  equal view.$('input[aria-required=true]').length, 1, 'Aria-required'  

  viewId = view.$('input').parents('.tent-text-field:first').attr('id')
  equal view.$('input[aria-describedby]').length, 1, 'described-by'
  equal view.$('input').attr('aria-describedby'), viewId+"_error " + viewId + "_help", 'described by value'
  equal $("#" + viewId+"_error").length, 1, 'error field id exists for'
  equal $("#" + viewId+"_help").length, 1, 'help field id exists for'