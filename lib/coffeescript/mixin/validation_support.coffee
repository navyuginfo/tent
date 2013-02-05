#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
 * @class Tent.ValidationSupport
 * Some docs here...
###

Tent.ValidationSupport = Ember.Mixin.create
  ###*
  * @property {String }validations A list of comma-separated custom validations which should be applied to the widget
  ###
  validations: null
  isValid: true
  validationErrors: []
  validationWarnings: []
  processWarnings: true

  ###*
  * @property {String} warnings A list of comma-separated custom validations which should be applied to the widget, but are interpreted
  * as warnings which may be ignored.
  ###
  warnings: null
  
  init: ->
    @_super()

  validate: ->
    @flushValidationErrors()
    @flushValidationWarnings()
    valid = @executeCustomValidations()
    # @executeCustomWarnings() if @get('processWarnings')
    @set('isValid', valid)
    return valid

  validateWarnings: ->
    @executeCustomValidations()
    @flushValidationWarnings()
    @executeCustomWarnings() if @get('processWarnings')

  executeCustomValidations: ->
    valid = true
    if @get('validations')? and @get('validations') != ""
      for vName in @get('validations').split(',')
        isValid = true
        validator = Tent.Validations.get(vName.trim())
        if not validator?
          throw new Error('Validator ['+vName+'] cannot be found')
        options = @parseCustomValidationOptions(vName)
        isValid = isValid and validator.validate(@get('formattedValue'), options, null, @)
        unless isValid
          @addValidationError(validator.getErrorMessage(@get('formattedValue'), options))
          valid =isValid
    return valid

  executeCustomWarnings:->
    valid = true
    if @get('warnings')?  and @get('warnings') != ""
      for wName in @get('warnings').split(',')
        isValid = true
        validator = Tent.Validations.get(wName.trim())
        if not validator?
          throw new Error('Validator ['+wName+'] cannot be found')
        options = @parseCustomValidationOptions(wName)
        isValid = isValid and validator.validate(@get('formattedValue'), options, null, @)
        unless isValid
          @addValidationWarning(validator.getErrorMessage(@get('formattedValue'), options))
          valid = isValid
    return valid

  parseCustomValidationOptions:(vName) ->
    if @get('validationOptions')? 
      if typeof @get('validationOptions') == 'string'
        return eval("(" + this.get('validationOptions') + ")")[vName]
      else
        return @get('validationOptions')[vName]
    null

  errorsDidChange: (->
    @updateErrorPanel()
  ).observes('validationErrors.@each')

  warningsDidChange: (->
    @updateWarningPanel()
  ).observes('validationWarnings.@each')


  updateErrorPanel: ->
    message = Tent.Message.create
      messages: $.merge([], @get('validationErrors'))
      type: Tent.Message.ERROR_TYPE
      sourceId: @get('elementId')
      label: @get('label')
    $.publish("/message", [message]);

  updateWarningPanel: ->
    message = Tent.Message.create
      messages: $.merge([], @get('validationWarnings'))
      type: Tent.Message.WARNING_TYPE
      sourceId: @get('elementId')
      label: @get('label')
      severity: @get('warningseverity')
    $.publish("/message", [message]);

  hasErrors: (->
    return not @get('isValid')
  ).property('isValid') 

  hasWarnings: (->
    return @get('validationWarnings').length > 0
  ).property('validationWarnings','validationWarnings.@each')

  observesErrors: (->
    classNames = @get('classNames')
    if classNames?
      if @get('hasErrors')
        classNames[classNames.length] = 'error' unless classNames.contains('error')
      else
        classNames.removeObject 'error'
  ).observes('hasErrors')

  observesWarnings: (->
    classNames = @get('classNames')
    if classNames?
      if @get('hasWarnings')
        # TODO : adding class explicitly since it would not work when adding to classNames.
        # investigate further
        @$('').addClass('warning') if @$('')?
        classNames[classNames.length] = 'warning' unless classNames.contains('warning')
      else
        @$('').removeClass('warning') if @$('')?
        classNames.removeObject 'warning'

  ).observes('validationWarnings','validationWarnings.@each')

  flushValidationErrors: ->
    @set('validationErrors', [])
    @set('isValid', true)
    
  flushValidationWarnings: ->
    @set('validationWarnings', [])

  addValidationError: (error) ->
    # Do we need more than one error?
    error =  Tent.I18n.loc(error) if (typeof error is "string")
    @get('validationErrors').pushObject(error)
    @set('isValid', false)

  addValidationWarning: (warning) ->
    warning =  Tent.I18n.loc(warning) if (typeof warning is "string")
    @get('validationWarnings').pushObject(warning)

 

 


