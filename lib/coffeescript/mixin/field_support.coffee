#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
* @class Tent.FieldSupport
* @mixins Tent.SpanSupport
* @mixins Tent.ValidationSupport
* @mixins Tent.VisibilitySupport
* @mixins Tent.MandatorySupport
* 
* This mixin provides all of the basic properties and behaviors for a form field view
###

require '../i18n/translation_support'
require './visibility_support'
require './validation_support'
require './mandatory_support'
require './span_support'
require './serializer_support'

Tent.FieldSupport = Ember.Mixin.create Tent.SpanSupport, Tent.ValidationSupport, Tent.VisibilitySupport, Tent.MandatorySupport, 

  ###*
  * @property {Boolean} [textDisplay=false]
  * When set to true, the formatted value of the widget will be displayed, 
  * rather than the widget itself.
  ###
  textDisplay: false

  ###*
  * @property {String} label The label for the field.
  ###
  label: ""

  ###*
  * @property {String} value The current value of the field.
  ###
  value: null

  ###*
  * @property {String} formattedValue The current value of the field in its formatted form.
  ###
  formattedValue: null

  ###*
  * @property serializedValue If a {@link serializer} has been defined, this will contain the serialized
  * value. If this value is set, a deserialized version of it will be set on the 'value' property
  ###
  serializedValue: null

  ###*
    * @property {String} [readOnly=false] A boolean indicating that the field is read-only.
    * Although this allows the user to interact with the field (highlight, copy etc), they are not able to change
    * its value.
    ###
  readOnly: false

  ###*
    * @property {String} [disabled=false] A boolean indicating that the field is disabled.
    * When disabled, the user is prevented from interacting with the field. In addition, if the field 
    * is tied to a form, its value will not be included in the form submission
    ###
  disabled: false

  ###*
    * @property {String} placeholder A block of descriptive text to display in the field, usually hint as to the expected content.
    * The placeholder will not be recognised as a value, and will be hidden when text is entered into the field.
    ###
  placeholder: null

  ###*
  * @property {String} helpBlock A block of text which provides additional help for completing the field
  ###
  helpBlock: null

  fieldClass: 'field'
  mixinClasses: 'control-group'
  classNames: ['tent-widget']
  classNameBindings: [
    'mixinClasses',
    'requiredAsBoolean:required',
    'isHidden:hidden',
    'isViewOnly:view-only',
    'hasErrors:error',
    'spanClass'
  ]
  
  ###*
  * @property {Boolean} [isEditable=true] A boolean value indicating whether the field is editable
  ###
  isEditable: true
  isEditableAsBoolean: Tent.computed.boolCoerceGently 'isEditable'
  isViewOnly: Ember.computed.not 'isEditableAsBoolean'

  ###*
  * @property {Boolean} [hasPrefix=false] A boolean indicating whether a prefix should be displayed before the value
  ###
  hasPrefix: false  

  ###*
  * @property {String} prefix A string value to display as the prefix
  ###
  prefix: null

  translatedPlaceholder: (->
    placeholderText = Tent.I18n.loc(@get('placeholder'))
    if Tent.Browsers.isIE()
      @addPlaceholder(placeholderText)
    placeholderText
  ).property('placeholder')
  
  isTextDisplay: (->
    @get('textDisplay') or (not @get('isEditable'))
  ).property('textDisplay', 'isEditable')

  forId: (->
    @get('inputIdentifier')
  ).property('inputIdentifier')

  errorId: (->
    @get('elementId') + "_error"
  ).property('elementId')

  helpId: (->
    @get('elementId') + "_help"
  ).property('elementId')
  
  inputSizeClass: (->
    #return Tent.FieldSupport.SIZE_CLASSES[@estimateSpan() - 1]
    'input-medium'
  ).property()

  widthExpectation: (->
    formStyle = @get('form.formStyle')
    fieldSize = Tent.FieldSupport.SIZE_MAP[@get('inputSizeClass')]
    if formStyle == 'horizontal' then fieldSize + 150 else Math.max(fieldSize, 150) 
  ).property('form')
  		
  form: (->
    if @$()?
      Ember.View.views[@$().closest('form').attr('id')]
  ).property()

  enableWarningProcessing: (->
    # For all widget, if the value triggers a warning messages, and if the warning message is closed, 
    # we dont turn warning evaluation on until the value of the widget changes again.
    @set('processWarnings', true)
  ).observes('value')

  focus: ->
    $('#' + @get('inputIdentifier')).focus()

  resize: ->
  	@_super()
  	@estimateFormStyle()

  clear: ->
    @set('value', null)
  	
  didInsertElement: ->
    @_super()
    @estimateFormStyle()
  	
  addPlaceholder: (placeholderText) ->
    Ember.run.next =>
      field = $('#' + @get('inputIdentifier'))
      field.addClass('placeholder').val(placeholderText)
      field.focus (->
        if field.val() == placeholderText
          field.val('').removeClass('placeholder')
      )

  estimateFormStyle: ->
  	#form.set('formStyle', if @get('widthExpectation') > form.$().width() then 'vertical' else 'horizontal') if (form = @get('form'))

  unEditableClass: (-> 'uneditable-input' unless @get('isEditable')).property('isEditable')

Tent.FieldSupport.SIZE_CLASSES = [
  'input-mini',
  'input-small',
  'input-mini',
  'input-medium',
  'input-large',
  'input-xlarge',
  'input-xlarge',
  'input-xlarge',
  'input-xxlarge',
  'input-xxlarge',
  'input-xxlarge',
  'input-xxlarge',
]

Tent.FieldSupport.SIZE_MAP =
  'input-mini': 60
  'input-small': 90
  'input-medium': 150
  'input-large': 210
  'input-xlarge': 270
  'input-xxlarge': 530