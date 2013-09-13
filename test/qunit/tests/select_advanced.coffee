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

module "Tent.SelectAdvanced", setup, teardown


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
                          selectionBinding="application.stateSelection"
                          advanced=true
                        }}'

  appendView()

  ok view.$().length, 'Select was rendered'