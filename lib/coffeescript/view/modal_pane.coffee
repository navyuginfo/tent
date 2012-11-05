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
* ##Usage
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
###
require '../template/modal_pane'


Tent.ModalPane = Ember.View.extend
  layoutName: 'modal_pane'
  classNames: ['tent-widget', 'control-group', 'tent-form']
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

  ###*
  * @property {String} primaryIcon An icon to display in the primary button
  ###
  primaryIcon: null

  ###*
  * @property {String} secondaryIcon An icon to display in the secondary button
  ###
  secondaryIcon: null
  
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

  init: ->
    @_super(arguments)
    if not @get('closeAction')?
      @set('closeAction', @get('secondaryAction'))
    if not @get('closeTarget')?
      @set('closeTarget', @get('secondaryTarget'))

  didInsertElement: ->
    if not (@get('label')? || @get('customButton')?)
      @launch()

    if @get('customButton')?
      widget = @
      $("#" + @.get("customButton")).click( ->
        widget.launch()
      )
  
    @$(".modal").on("hidden", (e)=>
      if @targetIsMessagePanel(e.target)
        @triggerCancelAction(e)
    )

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
    panel.clearAll()
    primaryPanel.setActive(true) if primaryPanel?
    panel.setActive(false)  if panel?

  getPrimaryMessagePanelView: ->
    Ember.View.views[$('.tent-message-panel.primary').attr('id')]

  getMessagePanelView: ->
    Ember.View.views[@$('.tent-message-panel').attr('id')]

  triggerCancelAction: (e)->
    cancelButton = @$('.modal-footer .btn-secondary.close-dialog')
    if cancelButton.length > 0
      id = cancelButton.parent('.tent-button').attr('id')
      buttonView = Ember.View.views[id]
      buttonView.triggerAction()

  willDestroyElement: ->
    @hide()

  click: (event)->
    target = event.target
    if $(target).hasClass('close-dialog')
      @hide()

  launch: ->
     @.$('.modal').modal(@get('options'))
     @enableMessagePanel()

  hide: ->
    @.$('.modal').modal('hide')
    @disableMessagePanel()


Tent.ModalHeader = Ember.View.extend
  tagName: 'h3'
  defaultTemplate: Ember.Handlebars.compile '{{loc view.parentView.header}}'

Tent.ModalBody = Ember.View.extend
  tagName: 'p'
  defaultTemplate: Ember.Handlebars.compile '{{loc view.parentView.text}}'  
