###*
* @class Tent.Accordion
* Usage
*   {{#view Tent.Accordion}}
	      {{#view Tent.AccordionGroup title="Title1"}}
	        {{view Tent.Button label="Button with options only" type="info" optionsBinding="Pad.btnOptions"}}
	      {{/view}}
	      {{#view Tent.AccordionGroup title="Title2"}}
	          {{view Tent.TextField valueBinding="Pad.appName" label="Killer Input"}}
	          {{view Tent.Checkbox label="Self Destruct now" checkedBinding="Pad.privacyPolicy"}}
	      {{/view}}
	      {{#view Tent.AccordionGroup title="Title3"}}
	          Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid.
	      {{/view}}
	      {{#view Tent.AccordionGroup title="Title4"}}
	          Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid.
	      {{/view}}
	    {{/view}}
###

require '../template/accordion_group'

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


