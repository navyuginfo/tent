#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
 * @class Tent.SpanSupport
 * Some docs here...
###

Tent.SpanSupport = Ember.Mixin.create
  estimateSpan: ->
    currentView = this
    while (currentView)
      span = Number(currentView.get('span'))
      unless (span == 0) || isNaN(span)
        return span
      currentView = currentView.get('parentView')
    12

  spanClass: (-> 'span' + @get('span') if @get('span')).property('span')

  rspanClass: (-> 'rspan' + @get('rspan') if @get('rspan')).property('rspan')

  ###*
  * @property {Number} span The horizontal span which should be allocated to this widget
  ###

  ###*
  * @property {Number} rspan The vertical span which should be allocated to this widget
  ###
