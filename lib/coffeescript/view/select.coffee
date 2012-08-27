#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../template/select'

Tent.Select = Ember.View.extend Tent.FieldSupport,
  templateName: 'select'
  classNames: ['tent-select', 'control-group']

  init: ->
    @_super()

  selectionDidChange: (->
    @set('selection', @get('selected'))
  ).observes('selected')   

  _prompt: (-> 
    if !@get('multiple')
      if prompt = @get('prompt') then prompt else "Please Select..." 
  ).property('prompt')
  