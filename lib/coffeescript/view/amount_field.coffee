#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../mixin/field_support'
require '../template/text_field'

Tent.AmountField = Tent.TextField.extend
  hasPrefix: true
  hasHelpBlock: true
  placeholder: accounting.settings.number.pattern
  prefix: (->
    @get('currency')
  ).property('currency')
  helpBlock: (->
    @getFormatPattern()
  ).property()

  getFormatPattern: ->
    '(' + (@get('formatPattern') or accounting.settings.number.pattern) + ')'
  
  validate: ->
    didOtherValidationPass = @_super()
    formattedValue = @get('formattedValue')
    isValidAmount = @isValidAmount(formattedValue)
    @addValidationError(Tent.messages.AMOUNT_ERROR) unless isValidAmount
    didOtherValidationPass && isValidAmount

  isValidAmount: (value)->
    # Let the formatter re-format the value for now
    true

  #Format for display
  format: (value)->
    # Convert from a number to a string
    formatted = accounting.formatNumber(value)
    return formatted


  # Format for binding
  unFormat: (value)->
    unFormatted = accounting.unformat(value)
    return unFormatted

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
