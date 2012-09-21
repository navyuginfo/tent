#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
* @class Tent.ModalPane
* Display a model popup panel.
* 
* A button will be displayed to allow the popup to be launched. You provide a {@link #label}
* and optionally a {@link #type} for the button.
*
* Text to go into the header of the popup is provided using the {@link #header} property.
*
* The body of the popup may be provided either by the {@link #text} property, or by nesting 
* content within the view (using {{#view}} rather than {{view}}).
*
* Labels for the button in the popup are provided by the {@link #primaryLabel} and {@link #secondaryLabel} properties.
*
* The primary button action is configured using the {@link #primaryAction} and {@link #primaryTarget} property pair.
* Similarly use {@link #secondaryAction} and {@link #secondaryTarget} for the secondary button.
*
* ##Usage
*
*       {{#view Tent.ModalPane   
                text="_modalText" 
                header="_modalHeader" 
                primary="_ok" 
                secondary="_cancel"
                buttonClass=""
                type="primary"
                primaryAction="modalSubmit"
                primaryTargetBinding="Pad"
                secondaryAction="modalCancel"
                secondaryTarget="Pad"
            }}
              <h5>Some more content</h5>
        {{/view}}
*
###
require '../template/modal_pane'


Tent.ModalPane = Ember.View.extend
  layoutName: 'modal_pane'
  classNames: ['tent-widget', 'control-group']
  ###*
  * @property {String} label The label for the launch button
  ###
  label:"_submit"

  ###*
  * @property {String} header The text to display in the header section of the modal dialog
  ###
  header:null

  ###*
  * @property {String} text The text to display in the body section.
  * The dialog will also display any nested content in the body section, so in that case the 
  * text property would be optional
  ###  
  text:null

  ###*
  * @property {String} type The type of button used to launch the dialog. See {@link Tent.Button}
  ###
  type: "primary" # button type

  ###*
  * @property {String} primaryLabel The label for the primary button
  ###
  primaryLabel:null

  ###*
  * @property {String} secondaryLabel The label for the secondary button
  ###
  secondaryLabel:null

  ###*
  * @property {String} primaryAction The method to execute when the primary button is clicked
  ###
  primaryAction:null

  ###*
  * @property {String} primaryTarget The target providing the action to call when the primary button is clicked
  ###
  primaryTarget:null

  ###*
  * @property {String} secondaryAction The method to execute when the secondary button is clicked
  ###
  secondaryAction: "hide"

  ###*
  * @property {String} secondaryTarget The target providing the action to call when the primary button is clicked
  ###
  secondaryTarget: "parentView"


  click: (event)->
    target = event.target
    if $(target).hasClass('close-dialog')
      @hide()

    #targetClick = target.getAttribute('click')
    #(@destroy(); false) if targetClick == 'close' || 'primary' || 'secondary'

  launch: ->
     @.$('.modal').modal(@get('options'))

  hide: ->
    @.$('.modal').modal('hide')    


Tent.ModalHeader = Ember.View.extend
  tagName: 'h3'
  defaultTemplate: Ember.Handlebars.compile '{{loc view.parentView.header}}'

Tent.ModalBody = Ember.View.extend
  tagName: 'p'
  defaultTemplate: Ember.Handlebars.compile '{{loc view.parentView.text}}'  