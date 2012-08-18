require '../template/accordion_header'
require '../template/accordion_body'
require 'bootstrap-sass/bootstrap-collapse'

Tent.Accordion = Ember.View.extend
	classNames: ['accordion'] 
	getIDSelector: ->
		'#' + @.$().attr("id")

Tent.AccordionGroup = Ember.View.extend
	classNames: ['accordion-group']

Tent.AccordionHeader = Ember.View.extend
	classNames: ['accordion-heading']
	templateName: 'accordion_header'
	targetSelector: (->
		'#' + @get("target")
	).property("target")

	didInsertElement: ->
		# Can't access the id property so we'll look it up in the DOM
		@set('dataParent', @getRootIDSelector())

	getRootIDSelector: ->
		@get("parentView.parentView").getIDSelector()

Tent.AccordionBody = Ember.View.extend
	classNames: ['accordion-body', 'collapse']
	idBinding: 'id'
	layout: Ember.Handlebars.compile '<div class="accordion-inner">{{yield}}</div>'
	didInsertElement: ->
		console.log 'breaker'

