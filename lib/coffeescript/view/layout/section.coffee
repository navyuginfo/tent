
###*
* @class Tent.Section
*
* ## Usage
*
*		{{#view Tent.Section span="5" vspan="12" title="_menu"}}
*		{{/view}}
*
* A Section typically will contain three subsections {@link Tent.Header}, {@link Tent.Content} and
* {@link Tent.Footer}.
* 
* If you provide a {@link #title}, then a {@link Tent.Header} will be generated automatically, so you
* should **not** provide your own {@link Tent.Header} in addition to this.
*   
###

Tent.Section = Ember.View.extend Tent.SpanSupport,
	tagName: 'section'
	classNameBindings: ['spanClass', 'vspanClass', 'hClass']
	classNames: ['tent-section']
	
	###*
	* @property {String} title The title to display in the header. If title is provided, a header section will
	* be generated automatically.
	###
	title: null
	
	###*
	* @property {String} hLevel The header size to use if a title property is provided. e.g. '1', '2' etc
	###
	hLevel: '2'
	
	hClass: (->
		"hlevel" + @get('hLevel')
	).property('hLevel')
	formattedTitle: (->
		#Refactor this. Couldn't get <h2> as a parameter into a template
		switch @get('hLevel')
			when "1" then '{{#if view.title}}{{#view Tent.Header}}<h1>{{loc view.parentView.title}}</h1>{{/view}}{{/if}}{{yield}}'
			when "2" then '{{#if view.title}}{{#view Tent.Header}}<h2>{{loc view.parentView.title}}</h2>{{/view}}{{/if}}{{yield}}'
			when "3" then '{{#if view.title}}{{#view Tent.Header}}<h3>{{loc view.parentView.title}}</h3>{{/view}}{{/if}}{{yield}}'
			when "4" then '{{#if view.title}}{{#view Tent.Header}}<h4>{{loc view.parentView.title}}</h4>{{/view}}{{/if}}{{yield}}'
			when "5" then '{{#if view.title}}{{#view Tent.Header}}<h5>{{loc view.parentView.title}}</h5>{{/view}}{{/if}}{{yield}}'
			else '{{#if view.title}}{{#view Tent.Header}}<h2>{{loc view.parentView.title}}</h2>{{/view}}{{/if}}{{yield}}'
	).property('title')
	layout: (->
		Ember.Handlebars.compile(@get('formattedTitle'))
	).property('formattedTitle')

###*
* @class Tent.Header
*
* ## Usage
*
*		{{#view Tent.Header span="5" class="program-header"}}
*		{{/view}}
*
* A Header panel will typically be used within a {@link Tent.Section}. 
*
* The Header may consist of a single header area, populated with a title or other nested content, or it 
* can contain a header area (displaying a title) with a further section beneath. This arrangement is usually
* used to provide an expanding/contracting header. If expand/contract is not required, it is standard to use a simple
* header and put the main body in the {@link Tent.Content} widget
###

Tent.Header = Ember.View.extend Tent.SpanSupport,
	tagName: 'header'
	classNameBindings: ['spanClass', 'collapsible']

	###*
	* @property {Boolean} collapsible A boolean which determines whether the header is collapsible.
	* If set to true, then a {@link #title} should be provided so that there is a meaningful header 
	* area when collapsed.
	###
	collapsible: false

	collapsed: false

	###*
	* @property {String} title The title to be displayed in the header.
	* You may provide a title explicitly using the title property. You may also nest content
	* in the Header view and that will appear below the title header.
	* If nested content is provided, but no title provided, the nested content will appear in the header section
	###
	title: null

	formattedTitle: (->
		#Refactor this. Couldn't get <h2> as a parameter into a template
		switch @get('hLevel')
			when "1" then '<h1 class="clickarea">{{loc view.title}}</h1>'
			when "2" then '<h2 class="clickarea">{{loc view.title}}</h2>'
			when "3" then '<h3 class="clickarea">{{loc view.title}}</h3>'
			when "4" then '<h4 class="clickarea">{{loc view.title}}</h4>'
			when "5" then '<h5 class="clickarea">{{loc view.title}}</h5>'
			else '<h2 class="clickarea">{{loc view.title}}</h2>'
	).property('title')
	
	layout: (->
		if @get('collapsible')
			if @get('title')
				Ember.Handlebars.compile('<div class="header">' + @get('formattedTitle') + '<b class="caret"/></div>{{yield}}')
			else 
				Ember.Handlebars.compile('<div class="header">You must provide a title for a collapsed header</div>')
		else
			if @get('title')
				Ember.Handlebars.compile('<div class="header">' + @get('formattedTitle') + '</div>{{yield}}')
			else 
				Ember.Handlebars.compile('<div class="header">{{yield}}</div>')
	).property('formattedTitle')

	didInsertElement: ->
		if @get('collapsible') and Modernizr.csstransitions
			widget = @
			@$('').bind('webkitTransitionEnd oTransitionEnd transitionend msTransitionEnd', ->
				widget.set('collapsed', widget.$('').hasClass('collapsed'))
				$.publish("/ui/refresh", ['resize'])
			)

	click: (e)->
		if $(e.target).hasClass('caret')
			if @get('collapsible')
				@$('').toggleClass('collapsed')
				if not Modernizr.csstransitions
					@set('collapsed', @$('').hasClass('collapsed'))
					$.publish("/ui/refresh", ['resize'])


###*
* @class Tent.Content
*
* ## Usage
*
*		{{#view Tent.Content span="5"}}
*		{{/view}}
* A Content panel will typically be used within a {@link Tent.Section}. The panel height will change to
* fill the available space within the Section
###

Tent.Content = Ember.View.extend Tent.SpanSupport,
	classNameBindings: ['spanClass']
	classNames: ['content']
	layout: Ember.Handlebars.compile '{{yield}}'

	didInsertElement: ->
		@resize()
		section = @.$().parent('section')
		header = section.children('header')
		@set('headerView', Ember.View.views[header.attr('id')])

	resize: ->
		section = @.$().parent('section')
		header = section.children('header')
		footer = section.children('footer')
		@set('headerView', Ember.View.views[header.attr('id')])
		headerOffset = if header.length > 0 then header.outerHeight(true) else 0
		@.$().css('top', headerOffset + "px")
		footerOffset = if footer.length > 0 then footer.outerHeight(true) else 0
		@.$().css('bottom', footerOffset + "px")

	headerDidCollapse: (->
		@resize()
	).observes('headerView.collapsed')

###*
* @class Tent.Footer
*
* ## Usage
*
*		{{#view Tent.Footer span="5"}}
*		{{/view}}
*
* A Footer panel will typically be used within a {@link Tent.Section}. 
*
###

Tent.Footer = Ember.View.extend Tent.SpanSupport,
	tagName: 'footer' 
	classNameBindings: ['spanClass']
	layout: Ember.Handlebars.compile '{{yield}}'