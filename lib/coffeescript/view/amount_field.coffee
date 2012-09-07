#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../mixin/field_support'
require '../template/text_field'

Tent.AmountField = Tent.TextField.extend
  hasPrefix: true
  placeholder: accounting.settings.number.pattern
  prefix: (->
    @get('currency')
  ).property('currency')
  
  validate: ->
    didOtherValidationPass = @_super()
    formattedValue = @get('formattedValue')
    isValidAmount = @isValidAmount(formattedValue)
    @addValidationError(Tent.messages.AMOUNT_ERROR) unless isValidAmount
    console.log('valid = ' + isValidAmount + '     value = ' + formattedValue + '    formattedValue = ' + accounting.formatNumber(formattedValue))
    didOtherValidationPass && isValidAmount

  isValidAmount: (value)->
    #(accounting.formatNumber(value) == value)
    true

  #Format for display
  format: (value)->
    # Convert from a number to a string
    formatted = accounting.formatNumber(value, {
        precision: 2
        thousand: ','
        decimal: '.'
    })
    console.log('formatting from ' + value + '   to ' + formatted)
    return formatted


  # Format for binding
  unFormat: (value)->
    unFormatted = accounting.toFixed(value)
    console.log('unformatting from ' + value + '   to ' + unFormatted)
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
