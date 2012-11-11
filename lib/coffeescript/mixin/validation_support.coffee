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
  warnings=null
  
  init: ->
    @_super()

  validate: ->
    @flushValidationErrors()
    @flushValidationWarnings()
    valid = @executeCustomValidations()
    @executeCustomWarnings() if @get('processWarnings')
    @set('isValid', valid)
    return valid

  executeCustomValidations: ->
    valid = true
    if @get('validations')? and @get('validations') != ""
      for vName in @get('validations').split(',')
        validator = Tent.Validations.get(vName)
        if not validator?
          throw new Error('Validator ['+vName+'] cannot be found')
        options = @parseCustomValidationOptions(vName)
        valid = valid and validator.validate(@get('formattedValue'), options)
        @addValidationError(validator.getErrorMessage(@get('formattedValue'), options)) unless valid
    return valid

  executeCustomWarnings:->
    valid = true
    if @get('warnings')?  and @get('warnings') != ""
      for wName in @get('warnings').split(',')
        validator = Tent.Validations.get(wName)
        if not validator?
          throw new Error('Validator ['+wName+'] cannot be found')
        options = @parseCustomValidationOptions(wName)
        valid = valid and validator.validate(@get('formattedValue'), options)
        @addValidationWarning(validator.getErrorMessage(@get('formattedValue'), options)) unless valid

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
    @get('validationErrors').pushObject(error)
    @set('isValid', false)

  addValidationWarning: (warning) ->
    @get('validationWarnings').pushObject(warning)

 

 


