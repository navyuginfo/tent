require '../template/accordion_group'
require 'bootstrap-sass/bootstrap-collapse'

Tent.Accordion = Ember.View.extend
	classNames: ['accordion']

Tent.AccordionGroup = Ember.View.extend
	classNames: ['accordion-group']
	layoutName: 'accordion_group'
	dataParent: (->
		"#" + @get("parentView.elementId")
	).property("elementId")

	href: (->
		"#" + @get('elementId') + " .accordion-body"
	).property("elementId")


