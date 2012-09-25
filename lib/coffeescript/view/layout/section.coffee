

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
	title: null
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
###

Tent.Header = Ember.View.extend Tent.SpanSupport,
	tagName: 'header'
	classNameBindings: ['spanClass']
	layout: Ember.Handlebars.compile '{{yield}}'

###*
* @class Tent.Content
*
* ## Usage
*
*		{{#view Tent.Content span="5"}}
*		{{/view}}
*
###

Tent.Content = Ember.View.extend Tent.SpanSupport,
	classNameBindings: ['spanClass']
	classNames: ['content']
	layout: Ember.Handlebars.compile '{{yield}}'

	didInsertElement: ->
		section = @.$().parent('section')
		header = section.children('header')
		footer = section.children('footer')
		headerOffset = if header.length > 0 then header.css('height') else "0px"
		@.$().css('top', headerOffset)
		footerOffset = if footer.length > 0 then footer.css('height') else "0px"
		@.$().css('bottom', footerOffset)

###*
* @class Tent.Footer
*
* ## Usage
*
*		{{#view Tent.Footer span="5"}}
*		{{/view}}
*
###

Tent.Footer = Ember.View.extend Tent.SpanSupport,
	tagName: 'footer' 
	classNameBindings: ['spanClass']
	layout: Ember.Handlebars.compile '{{yield}}'