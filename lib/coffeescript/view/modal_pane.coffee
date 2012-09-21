#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
* @class Tent.ModalPane
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