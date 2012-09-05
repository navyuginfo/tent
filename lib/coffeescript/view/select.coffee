#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../template/select'
require '../mixin/tooltip_support'

Tent.Select = Ember.View.extend Tent.FieldSupport, Tent.TooltipSupport,
  templateName: 'select'
  classNames: ['tent-select', 'control-group']

  init: ->
    @_super()

  valueForMandatoryValidation: (->
    if @get('multiple')
      @get('selection')
    else
      @get('value')
  ).property('value', 'selection')

  selectionDidChange: (->
    if @get('selected') 
      @set('selection', @get('selected'))
    else 
      @set('selection', null) 
  ).observes('selected')

  _prompt: (-> 
    if !@get('multiple')
      if prompt = @get('prompt') then prompt else "Please Select..." 
  ).property('prompt')
  
  change: ->
      @_super()
      @set('isValid', @validate())
