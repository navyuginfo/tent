#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
* @class Tent.ModalPane
* Display a model popup panel.
* 
* A button will be displayed to allow the popup to be launched. You provide a {@link #label}
* and optionally a {@link #type} for the button. If no label is provided, the button will not be displayed 
* and the popup will be displayed automatically.
* You may alternatively associate a separate element to launch the popup when clicked, by specifying a {@link #customButton}
* value, which should be the id of the element.
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
* The close button (located at the top right), is bound to the secondary action, unless a {@link #closeAction} is provided.
*
* When the dialog is closed by clicking outside the dialog, the secondary action will be called.
*
* ## Usage
*
*       {{#view Tent.ModalPane   
                text="_modalText" 
                buttonClass=""
                type="primary"
                header="_modalHeader" 
                primaryLabel="_ok" 
                secondaryLabel="_cancel"
                primaryAction="modalSubmit"
                primaryTargetBinding="Pad"
                secondaryAction="modalCancel"
                secondaryTargetBinding="Pad"
                closeAction="clearUp"
                closeTargetBinding="controller"
                primaryIcon=""
                secondaryIcon="icon-remove icon-white"
            }}
              <h5>Some more content</h5>
        {{/view}}
*
* <h4> Validation </h4>
* The primary button will by default have validation set to true. This means that widgets within the modal dialog
* will be validated on submission, and any errors that occur will be displayed in an error panel within the modal.
* The primary button will be disabled until all of the validation errors have been corrected. 
*
* ## Alternate Usage
*
* If you need more complex footer content, you can provide it with a dedicated {@link Tent.ModalFooter} view.
* In this instance, you also need to provide a {@link Tent.ModalBody} for the body content.
*
*
* Usage is like:

    {{#view Tent.ModalPane 
          label="Using Custom Footer" 
          header="_modalHeader" 
          customContent=true
    }}
      {{#view Tent.ModalBody}}
        body content goes here ...
      {{/view}}
      {{#view Tent.ModalFooter}}
        {{view Tent.Button buttonClass="close-dialog pull-left cancel" label="cancel" type="secondary"}}
        {{view Tent.Button buttonClass="" label="go" type="primary" validate=true}}
        ... other buttons ...
      {{/view}}
    {{/view}}

 - In order to use the ModalBody and ModalFooter views, you must set {@link #customContent} to true.
 - Any button that will close the dialog should have a css class of 'close-dialog'
 - The cancel button should be identified with a css class of 'cancel'. In the event that the Modal is 
 closed by this button, or the 'x' close button, or by clicking outside of the modal, then the action 
 associated with the cancel button will be executed.
*
###
require '../template/modal_pane'
require '../template/modal_body'
require '../template/modal_footer'

Tent.ModalPane = Ember.View.extend
  layoutName: 'modal_pane'
  classNames: ['tent-widget', 'control-group', 'tent-modal', 'tent-form']
  ###*
  * @property {String} label The label for the launch button
  ###
  label:null

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
  * @property {String} type The type of button used to launch the dialog. May be
  * one of {@link Tent.Button#type}
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

  ###*
  * @property {String} primaryIcon An icon to display in the primary button
  ###
  primaryIcon: null

  ###*
  * @property {String} secondaryIcon An icon to display in the secondary button
  ###
  secondaryIcon: null

  ###*
  * @property {String} secondaryType The type of button to display for the secondary button. May be
  * one of {@link Tent.Button#type}
  *
  ###
  secondaryType: 'secondary'

  ###*
  * @property {String} primaryType The type of button to display for the primary button. May be
  * one of {@link Tent.Button#type}
  *
  ###
  primaryType: 'primary'
  
  ###*
  * @property {String} closeAction The method to execute when the close button is clicked.
  * This will default to the {@link #secondaryAction}
  ###
  closeAction: null

  ###*
  * @property {String} closeTarget The target providing the action to call when the close button is clicked
  * This will default to the {@link #secondaryTarget}
  ###
  closeTarget: null

  ###*
  * @property {String} customButton will allow us to link the launch of modal pane with the html element whose id we provide.
  * This will default to null
  ###
  customButton: null

  ###*
  * @property {Boolean} customContent A boolean indicating that the ModalPane should not provide
  * its own body or footer. A Tent.ModalBody and Tent.ModalFooter may be provided in the nested content.
  ###
  customContent: false

  ###*
  * @property {Boolean} autoLaunch A boolean to indicate whether the modal panel will be displayed on entering the 
  * screen, regardless of any other property settings.
  ###
  autoLaunch: null

  ###*
  * @property {Boolean} validate Determines whether the primary button executes validations on 
  * the form widgets.
  ###
  validate: true

  ###*
  * @property {Boolean} warn A boolean to indicate that warning messages will be handled by the 
  * primary button. If warning messages of a certain severity exist, a popup will be displayed to 
  * allow the user to chose to ignore the warnings.
  ###
  warn: false

  hidden: true

  init: ->
    @_super(arguments)
    if not @get('closeAction')?
      @set('closeAction', @get('secondaryAction'))
    if not @get('closeTarget')?
      @set('closeTarget', @get('secondaryTarget'))

  didInsertElement: ->
    if @get('autoLaunch')
      @launch()
    else
      if (not @cancelAutoLaunch()) and not (@get('label')? or @get('customButton')?)
        @launch()

    if @get('customButton')?
      widget = @
      $("#" + @.get("customButton")).click( ->
        widget.launch()
      )
  
    @$(".modal:first").on("shown", (e)=>
      $.publish("/ui/refresh", ['resize'])
    )
    
    @$(".modal:first").on("hidden", (e)=>
      if not @get('hidden') and @targetIsMessagePanel(e.target)
        @triggerCancelAction(e)
        @hide()
    )

    modalId = @get('elementId')
    @$('.close-dialog').filter(->
      $(this).parents('.tent-modal:first').attr('id') == modalId
    ).click (event)=>
      if not $(event.target).attr('disabled')
        @hide()
      #event.stopPropagation()

  cancelAutoLaunch: ->
    @get('autoLaunch')? and @get('autoLaunch') == false

  targetIsMessagePanel: (source)->
    @$('.modal').get(0) == source

  enableMessagePanel: ->
    primaryPanel = @getPrimaryMessagePanelView()
    panel = @getMessagePanelView()
    primaryPanel.setActive(false) if primaryPanel?
    panel.setActive(true) if panel?

  disableMessagePanel: ->
    primaryPanel = @getPrimaryMessagePanelView()
    panel = @getMessagePanelView()
    panel.clearAll() if panel?
    primaryPanel.setActive(true) if primaryPanel?
    panel.setActive(false)  if panel?
  
  getPrimaryMessagePanelView: ->
    Ember.View.views[$('.tent-message-panel.primary').attr('id')]

  getMessagePanelView: ->
    Ember.View.views[@$('.tent-message-panel:first').attr('id')]

  triggerCancelAction: (e)->
    # Make sure to get the correct cancel button
    modal = this
    selectedCancel = null
    @$('.cancel').each(->
      if $(this).parents('.tent-modal:first').attr('id') == modal.get('elementId')
        selectedCancel = $(this)
    )

    if selectedCancel.length > 0
      id = selectedCancel.parent('.tent-button').attr('id')
      buttonView = Ember.View.views[id]
      buttonView.triggerAction()

  willDestroyElement: ->
    @hide()

  launch: ->
    @set('hidden', false)
    @.$('.modal:first').modal(@get('options'))
    @fadeParentModal()
    @enableMessagePanel()

  hide: ->
    @set('hidden', true)
    @restoreParentModal()
    @.$('.modal:first').modal('hide')
    @disableMessagePanel()

  # If this is a nested modal, fade out the parent modal
  fadeParentModal: ->
    parentBackdrop = @$().parents('.tent-modal:first').find('.modal-backdrop:first')
    parentBackdrop.hide().attr('data-hidden', true)
    if parentBackdrop.length > 0
      @$('.modal-backdrop:first').fadeIn(0).attr('data-hidden', false)
    else
      @$('.modal-backdrop:first').fadeIn(200).attr('data-hidden', false)

  restoreParentModal: ->
    parentBackdrop = @$().parents('.tent-modal:first').find('.modal-backdrop:first')
    parentBackdrop.show().attr('data-hidden', false)
    if parentBackdrop.length > 0
      @$('.modal-backdrop:first').fadeOut(0).attr('data-hidden', true)
    else
      @$('.modal-backdrop:first').fadeOut(200).attr('data-hidden', true)
    

Tent.ModalHeader = Ember.View.extend
  tagName: 'h3'
  defaultTemplate: Ember.Handlebars.compile '{{loc view.parentView.header}}'

###*
* @class Tent.ModalBody
* Add a body panel to a modal dialog.
*
* This view should be used only within a Tent.ModalPane which has its {@link Tent.ModalPane#customContent} property set to true
###
Tent.ModalBody = Ember.View.extend
  layoutName: 'modal_body'

###*
* @class Tent.ModalFooter
* Add a footer panel to a modal dialog.
*
* This view should be used only within a Tent.ModalPane which has its {@link Tent.ModalPane#customContent} property set to true
###
Tent.ModalFooter = Ember.View.extend
  layoutName: 'modal_footer'
