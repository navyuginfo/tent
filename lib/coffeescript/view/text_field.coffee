#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
 * @class Tent.TextField
 * @mixins Tent.FormattingSupport
 * @mixins Tent.FieldSupport
 * @mixins Tent.TooltipSupport
 * Usage 
 *       {{view Tent.TextField 
          valueBinding="Pad.appName" 
          label="Focused input" 
          placeholder="Type here.." 
          tooltip="Provide some information here" 
         }}
 * 
###

require '../mixin/field_support'
require '../mixin/formatting_support'
require '../mixin/tooltip_support'
require '../mixin/filtering_support'
require '../mixin/aria_support'
require '../mixin/readonly_support'
require '../mixin/disabled_support'
require '../mixin/html5_support'
require '../template/text_field'

Tent.TextField = Ember.View.extend Tent.FormattingSupport, Tent.FieldSupport, Tent.TooltipSupport, Tent.FilteringSupport,
  templateName: 'text_field'
  classNames: ['tent-text-field', 'control-group']
  operatorsIsValid: true


  ###*
  * @property {String} controlClass Additional classes to be added to the input field (not added to the wrapping elements)
  ###
  controlClass: ''

  ###*
  * @property {String} type The type of the input element ('text', 'password' etc)
  ###
  type: 'text'

  didInsertElement: ->
    @_super(arguments)
    @set('inputIdentifier', @$('input').attr('id'))

  valueForMandatoryValidation: (->
    @get('formattedValue')
  ).property('formattedValue')
    
  trimmedValue: (->
      @trimValue(@get('value'))
  ).property('value')

  # Validation of fields happens on focusout regardless if the field has changed 
  # This is so fields aren't missed when completing a form
  focusOut: ->  
    fieldValue = $('#' + @get('inputIdentifier')).val()
    if fieldValue == ''
        @validateField()
 
  # Validate on change
  change: ->
    @validateField()

Tent.TextFieldInput = Ember.TextField.extend Tent.AriaSupport, Tent.Html5Support, Tent.ReadonlySupport, Tent.DisabledSupport
