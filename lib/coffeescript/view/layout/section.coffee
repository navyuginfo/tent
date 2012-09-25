

###*
* @class Tent.Section
*
* ## Usage
*
*		{{#view Tent.Section span="5" rspan="12"}}
*		{{/view}}
*
###

Tent.Section = Ember.View.extend Tent.SpanSupport,
	tagName: 'section'
	classNameBindings: ['spanClass', 'vspanClass']
	classNames: ['tent-section']
	layout: Ember.Handlebars.compile '{{yield}}'
 

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