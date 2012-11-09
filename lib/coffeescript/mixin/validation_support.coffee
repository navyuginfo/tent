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
  * @property validations A list of custom validations which should be applied to the widget
  ###
  validations: ""
  isValid: true
  validationErrors: []
  
  init: ->
    @_super()

  validate: ->
    @flushValidationErrors()
    valid = @executeCustomValidations()
    @set('isValid', valid)
    return valid

  executeCustomValidations: ->
    valid = true
    if @get('validations')
      for vName in @get('validations').split(',')
        validator = Tent.Validations.get(vName)
        options = @parseCustomValidationOptions(vName)
        valid = valid and validator.validate(@get('formattedValue'), options)
        @addValidationError(validator.getErrorMessage(@get('formattedValue'), options)) unless valid
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

  updateErrorPanel: ->
    message = Tent.Message.create
      messages: $.merge([], @get('validationErrors'))
      type: Tent.Message.ERROR_TYPE
      sourceId: @get('elementId')
      label: @get('label')
    $.publish("/message", [message]);

  hasErrors: (->
    return not @get('isValid')
  ).property('isValid') 

  observesErrors: (->
    classNames = @get('classNames')
    if classNames?
      if @get('hasErrors')
        classNames[classNames.length] = 'error' unless classNames.contains('error')
      else
        classNames.removeObject 'error'
  ).observes('hasErrors')

  flushValidationErrors: ->
    @set('validationErrors', [])
    @set('isValid', true)
    
  addValidationError: (error) ->
    # Do we need more than one error?
    @get('validationErrors').pushObject(error)
    @set('isValid', false)


 

 


