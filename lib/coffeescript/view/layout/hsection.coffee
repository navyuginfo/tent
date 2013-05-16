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

	didInsertElement: ->
		$left = @$().children('.left-panel:first')
		@set('left-panel', Ember.View.views[$left.attr('id')]) if $left?
		$right = @$().children('.right-panel:first')
		@set('right-panel', Ember.View.views[$right.attr('id')]) if $right?
		@listenForEvents()

	willDestroyElement: ->
		$.unsubscribe('ui/h-collapse-left')
		$.unsubscribe('ui/h-collapse-right')

	expandAll: ->
		@get('left-panel').expand()
		@get('right-panel').expand()

	collapseAll: ->
		@get('left-panel').collapse()
		@get('right-panel').collapse()

	# The collapsible can be toggled using pub/sub
	# We expect the publish to be of the form
	#   $.publish('ui/h-collapse-dir', {source: $source})	
	# The collapsible will be triggered if it is the first collapsible parent of the source object
	listenForEvents: ->
		$.subscribe('ui/h-collapse-left', (e, params)=>
			if params.source?.closest('.tent-hsection')?.get(0) == @$('')?.get(0)
				@get('left-panel').collapse()
		)
		$.subscribe('ui/h-expand-left', (e, params)=>
			if params.source?.closest('.tent-hsection')?.get(0) == @$('')?.get(0)
				@get('left-panel').expand()
		)

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
	classNameBindings: ['spanClass','useTransition']
	classNames: ['left-panel']
	collapsible: true
	horizontalSlide: true
	slideDirection: "left"
	useTransition: false
	layout: Ember.Handlebars.compile '<div class="drag-bar clickarea"><i class="icon-caret-left"></i></div><div class="panel-content">{{yield}}</div>'
	onExpandEnd: ->
		@_super()
		@$('.drag-bar').css({'left': @get('width') - 20, 'visibility':'visible'})
	
	onCollapseEnd: ->
		@_super()
		@$('.drag-bar').css({'left': @get('width'), 'visibility':'visible'})
		
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
	classNameBindings: ['spanClass', 'leftCollapsed', 'rightCollapsed']
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
		$.subscribe("/ui/horizontalSlide", (a, data)=>
			@resize(data)
		)
		$.subscribe("/ui/refresh", (a, data)=>
			@resize()
		)

	resize: (data)->
		if @$()?
			section = @.$().parent('section')
			left = section.children('.left-panel')
			leftOffset = if left.length > 0 then (left.outerWidth(true) + left.offset().left - section.offset().left) else 0
			@.$().css('left', leftOffset + "px") if @.$().css('left') != leftOffset + "px"
			right = section.children('.right-panel')
			rightOffset = if right.length > 0 then (right.outerWidth(true) - ((right.offset().left + right.outerWidth()) - (section.offset().left + section.width()))) else 0
			@.$().css('right', rightOffset + "px") if @.$().css('right') != rightOffset + "px"

	siblingDidChange: (->
		@set('leftCollapsed', @get('leftView.collapsed'))
		@set('rightCollapsed', @get('rightView.collapsed'))
		@resize()
	).observes('leftView.collapsed', 'rightView.collapsed')

	willDestroyElement: ->
		$.unsubscribe("/ui/refresh")

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
	classNameBindings: ['spanClass','useTransition']
	classNames: ['right-panel']
	collapsible: true
	collapsed: false
	horizontalSlide: true
	slideDirection: "right"
	useTransition: false
	layout: Ember.Handlebars.compile '<div class="drag-bar clickarea"><i class="icon-caret-right"></i></div><div class="panel-content">{{yield}}</div>'

	didInsertElement: ->
		$.subscribe("/ui/horizontalSlide", (a, data)=>
			@keepAlignedWithRight(data)
		)

	# Compensate for shrinking of this section due to a parent section expanding
	keepAlignedWithRight: (data)->
		if @$()?
			if @get('collapsed') and not @sourceIsInMySection(data)
				@$().css('right', "-" + @$().width() + 'px')

	sourceIsInMySection: (data)->
		data? and (data.source?.parent('section').get(0) == @.$()?.parent('section').get(0))

	onExpandEnd: ->
		@_super()
		@$('.drag-bar').css({'left': 0, 'visibility': 'visible'})

	onCollapseEnd: ->
		@_super()
		@$('.drag-bar').css({'left': 0 - 20, 'visibility': 'visible'})

			

