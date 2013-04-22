
Tent.ResizeSupport = Ember.Mixin.create
  resize: ->
  	# Propagate the event down the tree. This is the only even that trickles down as opposed to bubbling up
  	@get('childViews')?.forEach (child) -> 
      child.resize?()

Ember.$(document).ready -> 
  window.onresize = ->
    $.publish('/window/resize')
    

 