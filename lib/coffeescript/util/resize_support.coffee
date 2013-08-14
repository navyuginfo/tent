
Tent.ResizeSupport = Ember.Mixin.create
  resize: ->
  	# Propagate the event down the tree. This is the only even that trickles down as opposed to bubbling up
  	@get('childViews')?.forEach (child) -> 
      child.resize?()

Ember.$(document).ready -> 
	lastWindowHeightForResize = $(window).height()
	lastWindowWidthForResize = $(window).width()
	$(window).resize((e)->
		# In Internet Explorer, the onresize event is fired when the size of the browser window or an element is changed.
		# In Firefox, Opera, Google Chrome and Safari, the onresize event is fired only when the size of the browser window is changed
		if ($(window).height()!=lastWindowHeightForResize) || ($(window).width()!=lastWindowWidthForResize)
			lastWindowHeightForResize = $(window).height()
			lastWindowWidthForResize = $(window).width()
			$.publish('/window/resize')
	)