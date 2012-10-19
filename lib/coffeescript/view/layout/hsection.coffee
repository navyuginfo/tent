

###*
* @class Tent.HSection
*
* ## Usage
*
*		{{#view Tent.HSection vspan="12"}}
*		{{/view}}
*
* A Section typically will contain three subsections {@link Tent.Left}, {@link Tent.Center} and
* {@link Tent.Right}.
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
###

Tent.Left = Ember.View.extend Tent.SpanSupport,
	tagName: 'section'
	classNameBindings: ['spanClass']
	classNames: ['left-panel']
	collapsed: false
	layout: Ember.Handlebars.compile '<div class="drag-bar"></div><div class="panel-content">{{yield}}</div>'

	didInsertElement: ->
		if Modernizr.csstransitions
			widget = @
			@$('').bind('webkitTransitionEnd oTransitionEnd transitionend msTransitionEnd', ->
				widget.set('collapsed', widget.$('').hasClass('collapsed'))
				$.publish("/ui/refresh", ['resize'])
			)

	click: (e)->
		if $(e.target).hasClass('drag-bar')
			@$('').toggleClass('collapsed')
			if not Modernizr.csstransitions
				@set('collapsed', @$('').hasClass('collapsed'))
				$.publish("/ui/refresh", ['resize'])
		
###*	
* @class Tent.Center
*
* ## Usage
*
*		{{#view Tent.Center}}
*		{{/view}}
*
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
###

Tent.Right = Ember.View.extend Tent.SpanSupport,
	tagName: 'section' 
	classNameBindings: ['spanClass']
	classNames: ['right-panel']
	collapsed: false
	layout: Ember.Handlebars.compile '<div class="drag-bar"></div><div class="panel-content">{{yield}}</div>'

	didInsertElement: ->
		if Modernizr.csstransitions
			widget = @
			@$('').bind('webkitTransitionEnd oTransitionEnd transitionend msTransitionEnd', ->
				widget.set('collapsed', widget.$('').hasClass('collapsed'))
				$.publish("/ui/refresh", ['resize'])
			)

	click: (e)->
		if $(e.target).hasClass('drag-bar')
			@$('').toggleClass('collapsed')
			$.publish("/ui/refresh", ['resize'])
			if not Modernizr.csstransitions
				@set('collapsed', @$('').hasClass('collapsed'))
				$.publish("/ui/refresh", ['resize'])
			

