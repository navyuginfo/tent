

###*
* @class Tent.LPane
*
* ## Usage
*
*		{{#view Tent.LPane span="5" rspan="12"}}
*		{{/view}}
*
###

Tent.LPane = Ember.View.extend Tent.SpanSupport,
	classNameBindings: ['spanClass', 'rspanClass']
	classNames: ['panel']
	layout: Ember.Handlebars.compile '{{yield}}'
 

###*
* @class Tent.LTop
*
* ## Usage
*
*		{{#view Tent.LTop span="5" class="program-header"}}
*		{{/view}}
*
###

Tent.LTop = Ember.View.extend Tent.SpanSupport,
	classNameBindings: ['spanClass']
	classNames: ['top']
	layout: Ember.Handlebars.compile '{{yield}}'


###*
* @class Tent.LMiddle
*
* ## Usage
*
*		{{#view Tent.LMiddle span="5"}}
*		{{/view}}
*
###

Tent.LMiddle = Ember.View.extend Tent.SpanSupport,
	classNameBindings: ['spanClass']
	classNames: ['middle']
	layout: Ember.Handlebars.compile '{{yield}}'

	didInsertElement: ->
		panel = @.$().parent('.panel')
		top = panel.children('.top')
		bottom = panel.children('.bottom')
		topOffset = if top.length > 0 then top.css('height') else "0px"
		@.$().css('top', topOffset)
		bottomOffset = if bottom.length > 0 then bottom.css('height') else "0px"
		@.$().css('bottom', bottomOffset)


###*
* @class Tent.LBottom
*
* ## Usage
*
*		{{#view Tent.LBottom span="5"}}
*		{{/view}}
*
###

Tent.LBottom = Ember.View.extend Tent.SpanSupport,
	classNameBindings: ['spanClass']
	classNames: ['bottom']
	layout: Ember.Handlebars.compile '{{yield}}'