#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
 * @class Tent.ValidationSupport
 * Some docs here...
###

Tent.ValidationSupport = Ember.Mixin.create  
  isValid: true
  
  validate: ->
    @flushValidationErrors()
    true

  errorsDidChange: (->
    console.log('validation errors did change')
    
  ).property('validationErrors.@each')

  updateErrorPanel: (->
    message = Tent.Message.create
      messages: $.merge([], @get('validationErrors'))
      type: Tent.Message.ERROR_TYPE
      sourceId: @get('elementId')
      label: @get('label')

    $.publish("/message", [message]);
  ).observes('errorsDidChange')

  hasErrors: (->
    #(!@validate() if @validate?) || false
    return not @get('isValid')
  ).property('isValid') 

  observesErrors: (->
    classNames = @get('classNames')
    if @get('hasErrors')
      classNames[classNames.length] = 'error' unless classNames.contains('error')
    else
      classNames.removeObject 'error'
  ).observes('hasErrors')

  flushValidationErrors: ->
    @set('validationErrors', [])
    
  addValidationError: (error) ->
    # Do we need more than one error?
    @get('validationErrors').pushObject(error)
    @set('isValid', false)


 

 


