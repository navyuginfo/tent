#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
* @class Tent.ModalPane
* A modal popup panel which displays a header and text with buttons available for progressing or cancelling the message  
*
* Usage
*       {{view Tent.ModalPane text="_modalText" header="_modalHeader" primary="_ok" secondary="_cancel"}}
###

require '../template/modal_pane'

jQuery = window.jQuery
modalPaneBackdrop = '<div class="modal-backdrop"></div>'

Tent.ModalPane = Ember.View.extend
  templateName: 'modal_pane'
  classNames: ['modal']

  ###*
  * @property {String} header The heading to display on the popup
  ###
  header:null

  ###*
  * @property {String} text The text to display within the popup
  ###
  text:null

  ###*
  * @property {String} primary The label for the primary button in the popup
  ###
  primary:null

  ###*
  * @property {String} secondary The label for the secondary button in the popup
  ###
  secondary:null

  ###*
  * @property {Boolean} showBackdrop A boolean to determine whether to hide the background page with a visual mask. 
  ###
  showBackdrop:true

  click: (event)->
    target = event.target
    targetClick = target.getAttribute('click')
    (@destroy(); false) if targetClick == 'close' || 'primary' || 'secondary'

  didInsertElement: -> 
    @_appendBackdrop() if @showBackdrop   

  willDestroyElement: ->
    @_backdrop.remove() if @showBackdrop 

  _appendBackdrop: ->
    @_backdrop = jQuery(modalPaneBackdrop).appendTo(@$().parent())  


Tent.ModalHeader = Ember.View.extend
  tagName: 'h3'
  defaultTemplate: Ember.Handlebars.compile '{{loc view.parentView.header}}'

Tent.ModalBody = Ember.View.extend
  tagName: 'p'
  defaultTemplate: Ember.Handlebars.compile '{{loc view.parentView.text}}'  