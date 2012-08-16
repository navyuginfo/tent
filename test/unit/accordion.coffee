require 'tent'

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '
			{{#view Tent.Accordion id="testaccordion"}}
	          {{#view Tent.AccordionGroup}}
	            {{view Tent.AccordionHeader title="Title1" target="collapsible1"}}
	            {{#view Tent.AccordionBody id="collapsible1"}}
	            {{/view}}
	          {{/view}}
	          {{#view Tent.AccordionGroup}}
	            {{view Tent.AccordionHeader title="Title2" target="collapsible2"}}
	            {{#view Tent.AccordionBody id="collapsible2"}}
	            {{/view}}
	          {{/view}}
	         {{/view}}'

teardown = ->

module 'Tent.Accordion', setup, teardown

test 'Ensure markup is correct', ->
	appendView()
	equal view.$('.accordion').length, 1, 'Accordion root has been created'
	equal view.$('.accordion-group').length, 2, '2 accordion groups created'
	equal view.$('.accordion-heading a').eq(0).attr("href"), '#collapsible1', 'Href for anchor 1'
	equal view.$('.accordion-heading a').eq(0).attr("data-parent"), '#testaccordion', 'data-parent for anchor 1'

test 'Ensure clicking applies the correct classes', ->
	appendView()
	ok view.$('.accordion-body').eq(0).hasClass("collapse"), 'first body has "collapse" attribute'
	equal view.$('.accordion-body').eq(0).hasClass("in"), false, 'first body has no "in" attribute initially'
	view.$('.accordion-heading a').eq(0).trigger("click")
	equal view.$('.accordion-body').eq(0).hasClass("in"), true, 'after click, body should have "in" attribute'