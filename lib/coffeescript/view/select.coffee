#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../template/select'
require '../template/radio_group'
require '../mixin/tooltip_support'
require '../mixin/aria_support'

Tent.Select = Ember.View.extend Tent.FieldSupport, Tent.TooltipSupport,
  templateName: 'select'
  classNames: ['tent-select', 'control-group']
  
  forId: (->
    @get('inputIdentifier')
  ).property('inputIdentifier')

  init: ->
    @_super()

  didInsertElement: ->
    @set('inputIdentifier', @$('select').attr('id'))

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


Tent.SelectElement = Ember.Select.extend Tent.AriaSupport, Tent.Html5Support
