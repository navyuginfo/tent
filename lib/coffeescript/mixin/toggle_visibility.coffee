
###*
* @mixin Tent.ToggleVisibility 
* Mixes in the ability to show/hide a subcomponent by calling {@link #toggleVisibility}.
* The subcomponent will also be hidden by clicking outside of its area, or pressing the 'escape'
###
Tent.ToggleVisibility = Ember.Mixin.create
	isShowing: false

	###*
	* @method bindToggleVisibility Attach an event handle to an element to allow it to toggle the visibility of another element.
	* @param {Object} source The source jQuery object which triggers the toggle
	* @param {Object} dest The jQuery object to show and hide
	###
	bindToggleVisibility: (source, dest)->
		widget = @
		source.click((e)->
			widget.toggleVisibility(dest, source)
		)

	toggleVisibility: (component, source)->
		if component.css('display')=='none'
			@showComponent(component, source)
		else
			@hideComponent(component)

	###*
	* @method hideComponent Hides a toggleable component
	* @param {Object} component The jQuery object to hide
	###
	hideComponent: (component) ->
		@set('isShowing', false)
		component.css('display', 'none')
		$('body').get(0).removeEventListener('click', @get('hideHandler'), true)
		$('body').get(0).removeEventListener('keyup', @get('hideHandler'), true)

	###*
	* @method showComponent Shows a toggleable component
	* @param {Object} component The jQuery object to show
	###
	showComponent: (component, source)->
		@set('isShowing', true)
		component.css('display', 'block')
		@set('hideHandler', @get('generateHideHandler')(@, component, source))
		$('body').get(0).addEventListener('click', @get('hideHandler'), true)
		$('body').get(0).addEventListener('keyup', @get('hideHandler'), true)

	generateHideHandler: (widget, component, source) ->
		return (e)->
			if e.keyCode==27 or (($(e.target).closest(component).length == 0) and (e.target != source.get(0)))
				widget.hideComponent(component)
				e.stopPropagation()
				return


