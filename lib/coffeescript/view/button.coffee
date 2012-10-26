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

  optionLabelPath: 'label'
  optionTargetPath: 'target'
  optionActionPath: 'action'

  init: ->
    @_super()
    @set('_options', Ember.ArrayProxy.create({content:  @get('optionList')}) || [] )

  targetObject: (->
    target = @get('target')
    if Ember.typeOf(target) is "string"
      #value = Em.get(@get('context'), target)
      value = Em.get(this, target)
      value = Em.get(window, target) if value is `undefined`
      target = value
    target || @get('context.target') || @get('content') || @get('context') 
  ).property('target', 'content', 'context')

  triggerAction: ->
    if @get('validate')
      @doValidation()
    if !@isDisabled 
      if !@get('hasOptions')
        @_super() 
      else 
        return @.$().toggleClass('open')

  classes: (->
    classes = (if (type = @get("type")) isnt null and @BUTTON_CLASSES.indexOf(type.toLowerCase()) isnt -1 then "btn btn-" + type.toLowerCase() else "btn")
    classes = classes.concat(" dropdown-toggle") if @get("hasOptions")
    classes = classes.concat(" disabled") if @get("isDisabled")
    return classes
  ).property('type','hasOptions')   

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
    'inverse'
    ]

  optionList: (->
    options = (options = @get('options'))
    options = content.get('options') if options == `undefined` and (content = @get('content')) isnt `undefined`
    options
  ).property('options','content').volatile()

  # Cause validation to be triggered on widgets in the current form
  doValidation: ->
    if not @get('messagePanel')?
      @setupMessageBind()
    
    form = @findParentForm()
    if form?
      @validateChildViews(form)

  validateChildViews: (parentView)->
    for view in parentView.get('childViews')
        view.validate() if typeof view.validate == 'function'
        @validateChildViews(view)

  findParentForm: ->
    $form = @$().parents('.tent-form:first')
    Ember.View.views[$form.attr('id')] if $form.length > 0

  setupMessageBind: ->
    mp = @getMessagePanel()
    if (mp)?
      @set('messagePanel', mp)

  getMessagePanel: ->
    mp = $('.tent-message-panel')
    return view = Ember.View.views[mp.attr('id')] if mp.length > 0
  
  disableButtonIfErrorsExist: (->
    mp = @get('messagePanel')
    if mp?
      @set('isDisabled', mp.get('hasErrors'))
  ).observes('messagePanel', 'messagePanel.hasErrors')


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


