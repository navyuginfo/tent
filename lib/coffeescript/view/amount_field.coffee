#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
* @class Tent.AmountField
* @extends Tent.TextField
* 
* ##Usage
*
*       {{view Tent.AmountField valueBinding="" 
          label="" 
          currency="" 
          required=false
          readOnly=false
          disabled=false 
          textDisplayBinding=false
          tooltip=""
        }}
###

require '../mixin/currency_support'
require '../template/text_field'
require '../mixin/filtering_range_support'
require '../mixin/serializer_support'

Tent.AmountField = Tent.TextField.extend Tent.CurrencySupport, Tent.FilteringRangeSupport, Tent.SerializerSupport, 
  hasPrefix: true
  hasHelpBlock: false
  placeholder: accounting.settings.number.pattern
  validAmountExp: /^(\-|\+)?(\d+\,?\d+)*\.?\d+$/
  validations: 'positive'
  ###*
  * @property serializer An object which implements serialize() and deserialize(). It will be applied
  * to the value and available on the {@link serializedValue} property
  ###
  serializer: null

  prefix: (->
    if @get('currency') then Tent.I18n.loc(this.get('currency')) else '...'
  ).property('currency')

  tooltipT: (->
    toolTip = Tent.I18n.loc(@get('tooltip'))
    if Tent.Browsers.isIE()
      toolTip + ' - ' + @get('placeholder')
    else
      toolTip
  ).property('tooltip', 'placeholder')
 
  validate: -> 
    @set('formattedValue', Tent.Formatting.amount.cleanup(@get('formattedValue')))
    didOtherValidationPass = @_super()
   
    formattedValue = @get('formattedValue')
    isValidCurrency = @get('isValidCurrency')
    @addValidationError(Tent.messages.CURRENCY_ERROR) unless isValidCurrency   
    @validateWarnings() if (isValidCurrency and didOtherValidationPass)
    (isValidCurrency and didOtherValidationPass)

  validateWarnings: ->
    @_super()

  #Format for display
  format: (value)->
    # Convert from a number to a string
    return Tent.Formatting.amount.format(value, @get('centesimalValue'))

  # Format for binding
  unFormat: (value)->
    return Tent.Formatting.amount.unformat(value)

  observeCurrencyForValidationAndFormatting: (->
    # remove the error always and check add again if required
    @get('validationErrors').removeObject(Tent.I18n.loc (Tent.messages.CURRENCY_ERROR))
    if @get 'isValidCurrency'
      @set('isValid', true) unless @get('validationErrors').length
      @set('formattedValue', @format(@get('formattedValue')))
      @set 'value', @unFormat(@get('formattedValue'))
    else
      @addValidationError(Tent.messages.CURRENCY_ERROR)  
  ).observes('currency')

  inputSizeClass: (->
    return Tent.AmountField.SIZE_CLASSES[@estimateSpan() - 1]
  ).property()

Tent.AmountField.SIZE_CLASSES = [
  'input-mini',
  'input-mini',
  'input-mini',
  'input-small',
  'input-medium',
  'input-large',
  'input-xlarge',
  'input-xlarge',
  'input-xlarge',
  'input-xxlarge',
  'input-xxlarge',
  'input-xxlarge',
]
