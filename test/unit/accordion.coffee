
view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '
			{{#view Tent.Accordion}}
	          {{#view Tent.AccordionGroup title="Title1"}}
	            
	          {{/view}}
	          {{#view Tent.AccordionGroup title="Title2"}}
	            
	          {{/view}}
	         {{/view}}'

teardown = ->
  Em.run -> 
    view.destroy() if view
    
module 'Tent.Accordion', setup, teardown

test 'Ensure markup is correct', ->
	appendView()
	equal view.$('.accordion').length, 1, 'Accordion root has been created'
	equal view.$('.accordion-group').length, 2, '2 accordion groups created'
	ok view.$('.accordion-heading a').eq(0).attr("href").split(" ").contains(".accordion-body"),  'Href for anchor 1'

test 'Ensure clicking applies the correct classes', ->
	appendView()
	ok view.$('.accordion-body').eq(0).hasClass("collapse"), 'first body has "collapse" attribute'
	equal view.$('.accordion-body').eq(0).hasClass("in"), false, 'first body has no "in" attribute initially'
	view.$('.accordion-heading a').eq(0).trigger("click")
	equal view.$('.accordion-body').eq(0).hasClass("in"), true, 'after click, body should have "in" attribute'