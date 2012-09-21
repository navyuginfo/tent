#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
* @class Tent.ModalPane
* Display a model popup panel.
* 
* A button will be displayed to allow the popup to be launched. You provide a {#label}
* and optionally a {#type} for the button.
* Text to go into the header of the popup is provided using the {#header} property.
* The body of the popup may be provided either by the {#text} property, or by nesting 
* content within the view (using {{#view}} rather than {{view}}).
* Labels for the button in the popup are provided by the {#primary} and {#secondary} properties.
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
            }}
              <h5>Some more content</h5>
        {{/view}}
*
###
require '../template/modal_pane'

jQuery = window.jQuery
modalPaneBackdrop = '<div class="modal-backdrop"></div>'

Tent.ModalPane = Ember.View.extend
  layoutName: 'modal_pane'

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
  * @property {String} primary The label for the primary button
  ###
  primary:null

  ###*
  * @property {String} secondary The label for the secondary button
  ###
  secondary:null

  showBackdrop:false

  click: (event)->
    target = event.target
    #targetClick = target.getAttribute('click')
    #(@destroy(); false) if targetClick == 'close' || 'primary' || 'secondary'

  launch: ->
     @.$('.modal').modal(@get('options'))

  didInsertElement: -> 
    #@_appendBackdrop() if @showBackdrop   

  willDestroyElement: ->
    #@_backdrop.remove()   

  _appendBackdrop: ->
    #@_backdrop = jQuery(modalPaneBackdrop).appendTo(@$().parent())  


Tent.ModalHeader = Ember.View.extend
  tagName: 'h3'
  defaultTemplate: Ember.Handlebars.compile '{{loc view.parentView.header}}'

Tent.ModalBody = Ember.View.extend
  tagName: 'p'
  defaultTemplate: Ember.Handlebars.compile '{{loc view.parentView.text}}'  