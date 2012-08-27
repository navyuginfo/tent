#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require 'tent'

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