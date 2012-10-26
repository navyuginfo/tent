require '../../mixin/collapsible_support'

###*
* @class Tent.HSection
*
* ## Usage
*
*		{{#view Tent.HSection vspan="12"}}
*		{{/view}}
*
* A HSection typically will contain three subsections {@link Tent.Left}, {@link Tent.Center} and
* {@link Tent.Right}.
* 
* The main benefit to a HSection is that the Left and Right panels can be expanded and contracted, with
* the center panel adapting to fill the available space.
*   
###

Tent.HSection = Ember.View.extend Tent.SpanSupport,
	tagName: 'section'
	classNameBindings: ['spanClass', 'vspanClass', 'hClass']
	classNames: ['tent-hsection']
	layout: Ember.Handlebars.compile("{{yield}}")
	

###*
* @class Tent.Left
*
* ## Usage
*
*		{{#view Tent.Left span="5" class=""}}
*		{{/view}}
*
* This container should be used as part of a {@link Tent.HSection}
* Left will appear on the left-hand side of a Tent.HSection and is collapsible.
*
###

Tent.Left = Ember.View.extend Tent.SpanSupport, Tent.CollapsibleSupport,
	tagName: 'section'
	classNameBindings: ['spanClass']
	classNames: ['left-panel']
	collapsible: true
	layout: Ember.Handlebars.compile '<div class="drag-bar clickarea"></div><div class="panel-content">{{yield}}</div>'

		
###*	
* @class Tent.Center
*
* ## Usage
*
*		{{#view Tent.Center}}
*		{{/view}}
*
* This container should be used as part of a {@link Tent.HSection}
* Center will appear in the center of a Tent.HSection and will expand to fill the space available.
###

Tent.Center = Ember.View.extend Tent.SpanSupport,
	classNameBindings: ['spanClass']
	classNames: ['center-panel']
	layout: Ember.Handlebars.compile '{{yield}}'
	leftView: null

	didInsertElement: ->
		@resize()
		section = @.$().parent('section')
		left = section.children('.left-panel')
		right = section.children('.right-panel')
		@set('leftView', Ember.View.views[left.attr('id')])
		@set('rightView', Ember.View.views[right.attr('id')])

	resize: ->
		section = @.$().parent('section')
		left = section.children('.left-panel')
		right = section.children('.right-panel')
		leftOffset = if left.length > 0 then left.outerWidth(true) else 0
		@.$().css('left', leftOffset + "px")
		rightOffset = if right.length > 0 then right.outerWidth(true) else 0
		@.$().css('right', rightOffset + "px")

	siblingDidChange: (->
		console.log 'collapsed'
		@resize()
	).observes('leftView.collapsed', 'rightView.collapsed')

###*
* @class Tent.Right
*
* ## Usage
*
*		{{#view Tent.Right span="5"}}
*		{{/view}}
*
* This container should be used as part of a {@link Tent.HSection}
* Right will appear on the right-hand side of a Tent.HSection and is collapsible.
###

Tent.Right = Ember.View.extend Tent.SpanSupport, Tent.CollapsibleSupport,
	tagName: 'section' 
	classNameBindings: ['spanClass']
	classNames: ['right-panel']
	collapsible: true
	collapsed: false
	layout: Ember.Handlebars.compile '<div class="drag-bar clickarea"></div><div class="panel-content">{{yield}}</div>'

			

