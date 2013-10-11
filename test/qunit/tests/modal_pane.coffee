#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

#
# This module specifically tests UI Widgets part of the tent library.
#
module "Tent.ModalPane", ->
    @TemplateTests = Ember.Namespace.create()
  , ->
    if view
      Ember.run -> view.destroy() 
      view = null
    @TemplateTests = undefined

test 'Ensure ModalPane renders ', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.ModalPane textBinding="text" headerBinding="header" 
    primaryLabelBinding="primary" secondaryLabelBinding="secondary"}}'
    text: 'Do you want to perform this action!!!'
    header: 'My Heading'
    primary: 'OK'
    secondary: 'Cancel'

  appendView()

  ok view.$('div')?, 'modal div gets rendered'
  ok view.$('div').hasClass('modal-header'), 'modal-header class gets applied'
  ok view.$('div').hasClass('modal-body'), 'modal-body class gets applied'  
  ok view.$('div').hasClass('modal-footer'), 'modal-footer class gets applied'  

  ok view.$("div.modal-header:contains('"+view.get('header')+"')").length > 0 , 'header rendered' 
  equal view.$('.modal-body').text().trim(), view.get('text'), 'body is rendered' 

  ok view.$(".modal-footer .btn-primary").length > 0, 'footer rendered primary'
  ok view.$(".modal-footer .btn-secondary").length > 0, 'footer rendered primary'

test 'Auto Launch: label and true', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.ModalPane 
      label="Click Me"
      autoLaunch=true
    }}'
  appendView()
  modalView = Ember.View.views[view.$('.tent-modal').attr('id')]
  ok not modalView.get('hidden'), "label and true"

test 'Auto Launch: label and false', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.ModalPane 
      label="Click Me"
      autoLaunch=false
    }}'
  appendView()
  modalView = Ember.View.views[view.$('.tent-modal').attr('id')]
  equal modalView.get('hidden'), true, "label and false"

test 'Auto Launch: no label and true', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.ModalPane 
      autoLaunch=true
    }}'
  appendView()
  modalView = Ember.View.views[view.$('.tent-modal').attr('id')]
  equal modalView.get('hidden'), false, "no label and true"

test 'Auto Launch: no label and false', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.ModalPane 
      autoLaunch=false
    }}'
  appendView()
  modalView = Ember.View.views[view.$('.tent-modal').attr('id')]
  equal modalView.get('hidden'), true, "no label and false"

test 'Auto Launch: label and null', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.ModalPane 
      label="Click Me"
    }}'
  appendView()
  modalView = Ember.View.views[view.$('.tent-modal').attr('id')]
  equal modalView.get('hidden'), true, "label and null"

test 'Auto Launch: no label and null', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.ModalPane 
      
    }}'
  appendView()
  modalView = Ember.View.views[view.$('.tent-modal').attr('id')]
  equal modalView.get('hidden'), false, "no label and null"

test 'Primary and secondary types', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.ModalPane textBinding="text" headerBinding="header" 
      primaryLabelBinding="primary" 
      secondaryLabelBinding="secondary"
      primaryType="success"
      secondaryType="warning"
    }}'
    text: 'Do you want to perform this action!!!'
    header: 'My Heading'
    primary: 'OK'
    secondary: 'Cancel'

  appendView()

  equal view.$('.btn-success').length, 1, 'success button rendered'
  equal view.$('.btn-warning').length, 1, 'warning button rendered'
  equal view.$('.btn-primary').length, 0, 'primary button not rendered'
  equal view.$('.btn-secondary').length, 0, 'secondary button not rendered'

test 'Ensure close button defaults to secondary action', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.ModalPane textBinding="text" headerBinding="header" 
    primaryLabelBinding="primary" secondaryLabelBinding="secondary" secondaryAction="saction"}}'
    text: 'Do you want to perform this action!!!'
    header: 'My Heading'
    primary: 'OK'
    secondary: 'Cancel'

  appendView()
  modalView = Ember.View.views[view.$('.tent-modal').attr('id')]
  equal modalView.get('closeAction'), "saction", "Action has been transferred."
   

test 'Ensure cancel action is triggered on hide', ->
  didHide = false
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.ModalPane secondaryLabelBinding="secondary" secondaryAction="hide" secondaryTargetBinding="view"}}'
    text: 'Do you want to perform this action!!!'
    header: 'My Heading'
    primary: 'OK'
    secondary: 'Cancel'
    hide: ->
      didHide = true

  appendView()
  view.$(".modal").trigger('hidden')
  
  ok didHide, 'hide action was called'

test 'customContent blank', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.ModalPane 
    }}'
  appendView()
  modalView = Ember.View.views[view.$('.tent-modal').attr('id')]
  equal modalView.$('.modal-footer').length, 1, 'Footer exists'

  Ember.run ->
    modalView.set('customContent', true)
  equal modalView.$('.modal-footer').length, 0, 'Standard Footer removed'

test 'customContent', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{#view Tent.ModalPane 
        customContent=true
    }}
      {{#view Tent.ModalBody text="_modalText"}}
        text goes here
      {{/view}}
      {{#view Tent.ModalFooter}}
        {{view Tent.Button buttonClass="close-dialog pull-left cancel" label="cancel"}}
        {{view Tent.Button buttonClass="" label="go" type="primary" validate=true}}
      {{/view}}
    {{/view}}'
  appendView()
  modalView = Ember.View.views[view.$('.tent-modal').attr('id')]
  equal modalView.$('.modal-body').length, 1, 'Body exists'
  equal modalView.$('.modal-footer').length, 1, 'Footer exists'
  equal modalView.get('hidden'), false, "Visible initially"
  
  Ember.run ->
    modalView.$('.cancel').click()
  
  equal modalView.get('hidden'), true, "Cancel should hide the panel"

test "Modal within modal", ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{#view Tent.ModalPane
      primaryLabel="_ok" 
      secondaryLabel="outerCancelButton"
      secondaryType="warning"
      primaryType="success"
    }}
       
        <a id = "inner_modalPane">launch inner modal</a>
        {{view Tent.ModalPane 
              customButton = "inner_modalPane"
              text="_modalText" 
              header="_modalHeaderInner" 
              primaryLabel="_ok" 
              secondaryLabel="innerCancelButton"
        }}
       
    {{/view}}'
  appendView()

  outerModalView = Ember.View.views[view.$('.tent-modal:first').attr('id')]
  innerModalView = Ember.View.views[outerModalView.$('.tent-modal').attr('id')]

  equal outerModalView.get('hidden'), false, "Outer modal is visible ["+outerModalView.get('elementId')+"]"
  equal outerModalView.$('.modal-backdrop:first').attr('data-hidden'), "false", 'backdrop should display'
  equal innerModalView.get('hidden'), true, "Inner modal is hidden  ["+innerModalView.get('elementId')+"]"
  equal innerModalView.$('.modal-backdrop:first').attr('data-hidden'), undefined, 'inner backdrop should be hidden'
  
  Ember.run ->
    $('#inner_modalPane').click()
  equal innerModalView.get('hidden'), false, "Inner modal is visible"
  equal outerModalView.$('.modal-backdrop:first').attr('data-hidden'), "true", 'outer backdrop hidden'
  equal innerModalView.$('.modal-backdrop:first').attr('data-hidden'), "false", 'inner backdrop should be visible'
  

  Ember.run ->
    innerModalView.$('.cancel').click()
  equal innerModalView.get('hidden'), true, "Inner modal is hidden again"
  equal outerModalView.get('hidden'), false, "Outer modal is still visible "
  equal outerModalView.$('.modal-backdrop:first').attr('data-hidden'), "false", 'outer backdrop hidden'
  equal innerModalView.$('.modal-backdrop:first').attr('data-hidden'), "true", 'inner backdrop should be visible'
  

  Ember.run ->
    outerModalView.$('.cancel.btn-warning').click()
  equal innerModalView.get('hidden'), true, "Inner modal is hidden after outer closed"
  equal outerModalView.get('hidden'), true, "Outer modal is now hidden "
  equal outerModalView.$('.modal-backdrop:first').attr('data-hidden'), "true", 'outer backdrop hidden'
  equal innerModalView.$('.modal-backdrop:first').attr('data-hidden'), "true", 'inner backdrop should be visible'
  
test "Modal contains form and flush validation errors within it", ->
  view = Ember.View.create
    template: Ember.Handlebars.compile("""
      {{#view Tent.ModalPane text="Modal text" buttonClass="left" type="secondary" header="Rejection Note"
        primaryLabel="Save" secondaryLabel="Cancel" primaryAction="reject"
        secondaryAction="cancel" closeAction="cancel" }}
        {{#view Tent.Panel span="10" }}
           {{#view Tent.Form id="form-section" formStyle="vertical"}}
              {{view Tent.Textarea label="note" inputSizeClass="enlarge"
                     valueBinding="note" required=true}}
              {{#view Tent.Section}}
                {{#view Tent.Content}}
                  {{view Tent.TextField valueBniding="value" required=true}}
                  {{view Tent.TextField value="text"}}
                {{/view}}
              {{/view}}
           {{/view}}
        {{/view}}
      {{/view}}
    """)
  note = ""
  text = ""
  appendView()
  modalView = Ember.View.views[view.$('.tent-modal:first').attr('id')]
  equal modalView.$('.modal-body').length, 1, 'Body exists'
  equal modalView.$('.modal-footer').length, 1, 'Footer exists'
  equal modalView.$('.btn:contains(Cancel)').length, 1, 'Cancel button exists'
  equal modalView.$('.tent-widget').length, 3, 'Modal body contains 3 form elements'
  equal modalView.$('.tent-section').length, 1, 'Modal body contains a section'
  equal modalView.$('.tent-section .tent-widget').length, 2, 'Section contains 2 form elements nested'

  textAreaView = modalView.get('childViews.3.childViews.0.childViews.0')
  ok textAreaView isnt null
  textFields = modalView.get('childViews.3.childViews.0.childViews.1.childViews.0.childViews')
  ok textFields isnt null
  textAreaView.validate()
  textFields.forEach (item) => item.validate()
  equal textAreaView.get('hasErrors'), true, 'Text area has validation error'
  equal textFields[0].get('hasErrors'), true, 'First text Field has validation error'
  equal textFields[1].get('hasErrors'), false, 'First text Field does not has validation error'

  Ember.run ->
    modalView.$('.btn:contains(Cancel)').click()

  textAreaView = modalView.get('childViews.3.childViews.0.childViews.0')
  ok textAreaView isnt null
  textFields = modalView.get('childViews.3.childViews.0.childViews.1.childViews.0.childViews')
  ok textFields isnt null
  equal textAreaView.get('hasErrors'), false, 'Text area does not has validation error'
  equal textFields[0].get('hasErrors'), false, 'First text Field does not has validation error'
  equal textFields[1].get('hasErrors'), false, 'First text Field does not has validation error'
  

