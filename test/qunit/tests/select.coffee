#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->
  @TemplateTests = Ember.Namespace.create()
  @Application = Ember.Namespace.create()
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
  @Application = null

module "Tent.Select", setup, teardown


test 'Ensure Tent.Select renders for list', ->
  Application.set("content", [
      Ember.Object.create({stateName: 'Georgia', stateCode: 'GA'}),
      Ember.Object.create({stateName: 'Florida',  stateCode: 'FL'}),
      Ember.Object.create({stateName: 'Arkansas',  stateCode: 'AR'})
    ])

  Application.stateSelection = Ember.Object.create()  

  view = Ember.View.create
    app: Application
    label: 'label1'
    template: Ember.Handlebars.compile '{{view Tent.Select 
                          labelBinding="view.label"
                          listBinding="app.content" 
                          optionLabelPath="content.stateName"  
                          optionValuePath="content.stateCode"
                          selectionBinding="application.stateSelection"}}'

  appendView()

  ok view.$().length, 'Select was rendered'
  equal view.$('option').length, Application.content.length + 1,  'Options were rendered'
  equal view.get('selection'), null, 'Nothing has been selected'
  equal view.$('label.control-label').text().trim(), view.get('label'), 'label is rendered'
  equal view.$('label.control-label').attr('for'), view.$('select').attr('id'), 'label has the correct "for" attribute'

  # add a new object to the list and see if the select holds that object 
  Ember.run -> Application.content.pushObject(Ember.Object.create({stateName: 'Alaska', stateCode: 'AK'}))
  equal view.$('option').length, Application.content.length + 1,  'New option was added'  


test 'Ensure binding for content allows content to be null initially', ->
  view = Ember.View.create
    app: Application
    template: Ember.Handlebars.compile '{{view Tent.Select 
                          listBinding="app.content" 
                          optionLabelPath="content.stateName"  
                          optionValuePath="content.stateCode"
                          selectionBinding="Application.stateSelection"}}'
  appendView()
  ok view.$().length, 'Select was rendered'  
  equal view.$('option').length, 1,  'zero options rendered'

  Ember.run ->
    Application.set("content", [
      Ember.Object.create({stateName: 'Georgia', stateCode: 'GA'}),
      Ember.Object.create({stateName: 'Florida',  stateCode: 'FL'}),
      Ember.Object.create({stateName: 'Arkansas',  stateCode: 'AR'})
    ])
  
  equal view.$('option').length, 4,  'Options were created'  


test 'test for Radio presentation', ->
  Application.set("content", [
    Ember.Object.create({stateName: 'Georgia', stateCode: 'GA'}),
    Ember.Object.create({stateName: 'Florida',  stateCode: 'FL'}),
    Ember.Object.create({stateName: 'Arkansas',  stateCode: 'AR'})
  ])
  view = Ember.View.create
    app: Application
    template: Ember.Handlebars.compile '{{view Tent.Select 
                          listBinding="app.content" 
                          optionLabelPath="content.stateName"  
                          optionValuePath="content.stateCode"
                          selectionBinding="Application.stateSelection"
                          isRadioGroup=true}}'
                          
  appendView()

  widget = Ember.View.views[view.$('.tent-select').attr('id')]

  equal view.$('input[type=radio]').length, 3,  '3 radio buttons were created'
  
  ###Ember.run ->
    view.$('.tent-radio-group label').eq(0).click()
  equal Application.get('stateSelection').stateCode, 'GA', 'Selected the correct item'

  Ember.run ->
    view.$('.tent-radio-group label').eq(2).click()
  equal Application.get('stateSelection').stateCode, 'AR', 'Selected the correct 3rd item'

  Ember.run ->
    widget.set('selection', Application.get('content')[0])
  equal view.$('input[type=radio]').eq(0).attr('checked'), 'checked', 'Changing selection changes the UI button selected'
  ###

test 'Required behaviour', ->
  view = Ember.View.create
    app: Application
    template: Ember.Handlebars.compile '{{view Tent.Select required=true}}'
  appendView()
  
  ok view.$('span.tent-required').length, 1, 'required icon displayed' 

test 'Test for readonly attribute', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Select readOnly=true}}'
  appendView()

  ok not view.$('select').attr('readonly')?, 'select does not support readonly'

test 'Test for disabled', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Select disabled=true}}'
  appendView()

  equal view.$('select').attr('disabled'), 'disabled', 'disabled attribute detected'
  equal view.$('select').attr('aria-disabled'), 'true', 'aria-disabled attribute detected'

test 'Test for textDisplay', ->
  Application.set("content", [
    Ember.Object.create({stateName: 'Georgia', stateCode: 'GA'}),
    Ember.Object.create({stateName: 'Florida',  stateCode: 'FL'}),
    Ember.Object.create({stateName: 'Arkansas',  stateCode: 'AR'})
  ])
  Application.set("stateSelection", Application.get('content')[1])

  view = Ember.View.create
    app: Application
    template: Ember.Handlebars.compile '{{view Tent.Select 
                          listBinding="app.content"
                          optionLabelPath="content.stateName"  
                          optionValuePath="content.stateCode"
                          selectionBinding="app.stateSelection"
                          textDisplay=true
                          }}'
  appendView()
  
  equal view.$('span.text-display').length, 1, 'span gets rendered'
  equal $('.controls span').text(), 'Florida' , 'value is set to florida'

test 'Ensure tooltip gets displayed', ->
  view = Ember.View.create 
    app: Application
    template: Ember.Handlebars.compile '{{view Tent.Select 
                          listBinding="app.content" 
                          optionLabelPath="content.stateName"  
                          optionValuePath="content.stateCode"
                          selectionBinding="Application.stateSelection"
                          tooltip="tooltip here.."
                          }}'
  appendView()

  ok view.$('a[rel=tooltip]')?, 'Tooltip anchor exists'
  equal view.$('a[rel=tooltip]').attr('data-original-title'), "tooltip here..", 'Tooltip text'
  ok typeof view.$("a[rel=tooltip]").tooltip, "function", 'tooltip plugin has been applied'


test 'Ensure aria attributes are applied ', ->
  view = Ember.View.create
    app: Application
    template: Ember.Handlebars.compile '{{view Tent.Select 
                          listBinding="app.content" 
                          required=true  hasErrors=true hasHelpBlock=true
                          }}'
  appendView()
  equal view.$('select[required=required]').length, 1, 'required html attribute'
  equal view.$('select[aria-required=true]').length, 1, 'Aria-required'

  viewId = view.$('select').parents('.tent-select:first').attr('id')
  equal view.$('select[aria-describedby]').length, 1, 'described-by'
  equal view.$('select').attr('aria-describedby'), viewId+"_error " + viewId + "_help", 'described by value'
  equal $("#" + viewId+"_error").length, 1, 'error field id exists for'
  equal $("#" + viewId+"_help").length, 1, 'help field id exists for'

