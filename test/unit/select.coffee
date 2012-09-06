#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->
  @TemplateTests = Ember.Namespace.create()
  @application = Ember.Namespace.create()
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
  @application = null

module "Tent.Select", setup, teardown


test 'Ensure Tent.Select renders for list', ->
  application.set("content", [
      Ember.Object.create({stateName: 'Georgia', stateCode: 'GA'}),
      Ember.Object.create({stateName: 'Florida',  stateCode: 'FL'}),
      Ember.Object.create({stateName: 'Arkansas',  stateCode: 'AR'})
    ])

  application.stateSelection = Ember.Object.create()  

  view = Ember.View.create
    app: application
    template: Ember.Handlebars.compile '{{view Tent.Select 
                          listBinding="app.content" 
                          optionLabelPath="content.stateName"  
                          optionValuePath="content.stateCode"
                          selectionBinding="application.stateSelection"}}'

  appendView()

  ok view.$().length, 'Select was rendered'
  equal view.$('option').length, application.content.length + 1,  'Options were rendered'
  equal view.$().text().trim(), "Please Select...GeorgiaFloridaArkansas", 'Option values were rendered'
  equal view.get('selection'), null, 'Nothing has been selected'

  # add a new object to the list and see if the select holds that object 
  Ember.run -> application.content.pushObject(Ember.Object.create({stateName: 'Alaska', stateCode: 'AK'}))
  equal view.$('option').length, application.content.length + 1,  'New option was added'  


test 'Ensure binding for content allows content to be null initially', ->
  view = Ember.View.create
    app: application
    template: Ember.Handlebars.compile '{{view Tent.Select 
                          listBinding="app.content" 
                          optionLabelPath="content.stateName"  
                          optionValuePath="content.stateCode"
                          selectionBinding="application.stateSelection"}}'
  appendView()
  ok view.$().length, 'Select was rendered'  
  equal view.$('option').length, 1,  'zero options rendered'

  Ember.run ->
    application.set("content", [
      Ember.Object.create({stateName: 'Georgia', stateCode: 'GA'}),
      Ember.Object.create({stateName: 'Florida',  stateCode: 'FL'}),
      Ember.Object.create({stateName: 'Arkansas',  stateCode: 'AR'})
    ])
  
  equal view.$('option').length, 4,  'Options were created'  


test 'test for Radio presentation', ->
  application.set("content", [
    Ember.Object.create({stateName: 'Georgia', stateCode: 'GA'}),
    Ember.Object.create({stateName: 'Florida',  stateCode: 'FL'}),
    Ember.Object.create({stateName: 'Arkansas',  stateCode: 'AR'})
  ])
  view = Ember.View.create
    app: application
    template: Ember.Handlebars.compile '{{view Tent.Select 
                          listBinding="app.content" 
                          optionLabelPath="content.stateName"  
                          optionValuePath="content.stateCode"
                          selectionBinding="app.stateSelection"
                          isRadioGroup=true}}'
                          
  appendView()

  equal view.$('input[type=radio]').length, 3,  '3 radio buttons were created'
  
  Ember.run ->
    view.$('.tent-radio-group label').eq(0).click()
  equal application.get('stateSelection').stateCode, 'GA', 'Selected the correct item'

  Ember.run ->
    view.$('.tent-radio-group label').eq(2).click()
  equal application.get('stateSelection').stateCode, 'AR', 'Selected the correct 3rd item'


test 'Ensure tooltip gets displayed', ->
  view = Ember.View.create
    app: application
    template: Ember.Handlebars.compile '{{view Tent.Select 
                          listBinding="app.content" 
                          optionLabelPath="content.stateName"  
                          optionValuePath="content.stateCode"
                          selectionBinding="application.stateSelection"
                          tooltip="tooltip here.."
                          }}'
  appendView()

  ok view.$('a[rel=tooltip]')?, 'Tooltip anchor exists'
  equal view.$('a[rel=tooltip]').attr('data-original-title'), "tooltip here..", 'Tooltip text'
  ok typeof view.$("a[rel=tooltip]").tooltip, "function", 'tooltip plugin has been applied'


