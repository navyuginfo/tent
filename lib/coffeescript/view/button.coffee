#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
* @class Tent.Button
*
* ##Usage
* 
*       {{view Tent.Button label="_buttonClickMe" type="primary" action="clickEvent" target="Pad"}}
###

require '../template/button'

Tent.Button = Ember.View.extend Ember.TargetActionSupport,
  classNames: ['tent-button']
  classNameBindings:['hasOptions:tent-button-group button-group']
  templateName: 'button'

  ###*
  * @property {String} label The label for the button
  ###
  label: 'Button'
  messagePanel: null

  localizedLabel: (->
    Tent.I18n.loc @get('label')
  ).property('label')

  ###*
  * @property {String} type The type of button.
  * Valid types are:
  *
  * - **primary**: Provides extra visual weight and identifies the primary action in a set of buttons
  * - **info**: Used as an alternative to the default styles
  * - **success**: Indicates a successful or positive action
  * - **warning**: Indicates caution should be taken with this action
  * - **danger**: Indicates a dangerous or potentially negative action
  * - **inverse**: Alternate dark gray button, not tied to a semantic action or use
  * - **link**: Deemphasize a button by making it look like a link while maintaining button behavior
  *
  ###
  type: 'primary'

  isDisabled: false

  ###*
  * @property disabled {Boolean} A boolean to indicate that the button is disabled
  ###
  disabled: null

  ###*
  * @property enabled {Boolean} A boolean to indicate that the button is enabled
  * This is used as a convenience property for avoiding having to use negative handlebars bindings
  ###
  enabled: null
  
  ###*
  * @property {String} action The action to be invoked on the target when the button is clicked
  ###
  action: null

  ###*  
  * @property {Object} target The target which hosts the action function.
  ###
  target: null

  ###*
  * @property {Boolean} validate If validate is set to true, all fields on the current form
  * need to be valid before the action will be executed. The Button will execute a form validation
  * if it has not happened already.
  ###
  validate: false

  ###*
  * @property {Boolean} warn If warn is set to true, a dialog will be presented if there are any 
  * warnings pending on the page. The user will be asked to either procede, ignoring the warnings, or to 
  * cancel the button action and fix the warnings. {@link #validate} must also be set to true to 
  * enable this property.
  ###
  warn: false

  ###*
  * @property {String} iconClass The css class to assign an icon to the button e.g. 'icon-remove icon-white'
  ###
  iconClass: null

  optionLabelPath: 'label'
  optionTargetPath: 'target'
  optionActionPath: 'action'

  init: ->
    @_super()
    @set('_options', Ember.ArrayProxy.create({content:  @get('optionList')}) || [] )
    if @get('disabled')?
      @set('isDisabled', @get('disabled'))
    if @get('enabled')?
      @set('isDisabled', not @get('enabled'))

  targetObject: (->
    target = @get('target')
    if Ember.typeOf(target) is "string"
      #value = Em.get(@get('context'), target)
      value = Em.get(this, target)
      value = Em.get(window, target) if value is `undefined`
      target = value
    target || @get('context.target') || @get('content') || @get('context') 
  ).property('target', 'content', 'context')

  triggerAction: (dontValidate)->
    if !@get('isDisabled') and @get('validate') and not dontValidate==false
      @doValidation()

    # validation may trigger change isDisabled
    if !@get('isDisabled')
      if !@get('hasOptions')
        if @get('warn')==true and @get('doWarningsExist')
          @showWarningPanel()
        else
          @_super() 
      else 
        return @.$().toggleClass('open')
    else 
      return false

  classes: (->
    classes = (if (type = @get("type")) isnt null and @BUTTON_CLASSES.indexOf(type.toLowerCase()) isnt -1 then "btn btn-" + type.toLowerCase() else "btn")
    classes = classes.concat(" dropdown-toggle") if @get("hasOptions")
    classes = classes.concat(" disabled") if @get("isDisabled")
    return classes
  ).property('type','hasOptions', 'isDisabled')   

  hasOptions: (->
    options = @get "optionList"
    options isnt `undefined` and options.get('length') isnt 0
  ).property('_options')

  BUTTON_CLASSES: [
    'primary',
    'secondary',
    'info', 
    'success',
    'warning',
    'danger',
    'inverse',
    'link'
    ]

  optionList: (->
    options = (options = @get('options'))
    options = content.get('options') if options == `undefined` and (content = @get('content')) isnt `undefined`
    options
  ).property('options','content').volatile()

  # Cause validation to be triggered on widgets in the current form
  doValidation: ->
    @setupMessageBind()
    
    form = @findParentForm()
    if form?
      @validateChildViews(form)

  validateChildViews: (parentView)->
    for view in parentView.get('childViews')
        view.validate() if typeof view.validate == 'function'
        @validateChildViews(view) if view.get('childViews')?

  findParentForm: ->
    $form = @$().parents('.tent-form:first')
    Ember.View.views[$form.attr('id')] if $form.length > 0

  setupMessageBind: ->
    mp = @getMessagePanel()
    if (mp)?
      @set('messagePanel', mp)

  getMessagePanel: ->
    mp = $('.tent-message-panel.active')
    return view = Ember.View.views[mp.attr('id')] if mp.length > 0
  
  disableButtonIfErrorsExist: (->
    mp = @get('messagePanel')
    if mp?
      @set('isDisabled', mp.get('hasErrors'))
  ).observes('messagePanel', 'messagePanel.hasErrors')

  disabledDidChange: (->
    @set('isDisabled', @get('disabled'))
  ).observes('disabled')

  enabledDidChange: (->
    @set('isDisabled', not @get('enabled'))
  ).observes('enabled')

  isDisabledDidChange: (->
    d = @get('isDisabled')
  ).observes('isDisabled')

  doWarningsExist: (->
     @get('messagePanel.hasSevereWarnings')
  ).property('messagePanel', 'messagePanel.hasSevereWarnings')

  ignoreWarnings: ->
    @get('messagePanel').clearWarnings()
    @hideWarningPanel()
    @triggerAction(false)

  showWarningPanel: ->
    modal = Ember.View.views[@$('.tent-modal').attr('id')]
    modal.launch()

  hideWarningPanel: ->
    modal = Ember.View.views[@$('.tent-modal').attr('id')]
    modal.hide()

Tent.ButtonOptions = Ember.View.extend Ember.TargetActionSupport,
  template: Ember.Handlebars.compile '<a href="#">{{view.label}}</a>'
  
  optionLabelBinding: 'parentView.parentView.optionLabelPath'
  optionTargetBinding: 'parentView.parentView.optionTargetPath'
  optionActionBinding: 'parentView.parentView.optionActionPath'

  click: ->
    button = @get('parentView.parentView')
    button.$().toggleClass('open')
    @triggerAction()
    
  label: (->
    content = @get('content')
    content.get(@get('optionLabel')) || content.get(@get('optionAction')).camelToWords()
  ).property('content')

  target: (->
    content = @get('content')
    content.get(@get('optionTarget')) || @get("parentView.parentView.context.target") || @get("parentView.parentView.content") || @get("parentView.parentView.context")
  ).property('content')

  action: (->
    content = @get('content')
    content.get(@get('optionAction'))
  ).property('content')


