#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
 * @class Tent.VisibilitySupport
 * Some docs here...
###

Tent.VisibilitySupport = Ember.Mixin.create 
  isVisible: true
  _widgetShowing: true
  isVisibleAsBoolean: Tent.computed.boolCoerceGently 'isVisible'
  isHidden: Ember.computed.not 'isVisibleAsBoolean'

  observesVisibility: (->
    if (@get('isVisibleAsBoolean'))
      unless @get('_widgetShowing')
        if (typeof @show is 'function') then @show() else @$().show()
      @set('_widgetShowing', true)
    else
      if @get('_widgetShowing')
        if (typeof @hide is 'function') then @hide() else @$().hide()
      @set('_widgetShowing', false)
  ).observes('isVisible')
