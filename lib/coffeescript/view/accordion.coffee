###*
* @class Tent.Accordion
* 
* ##Usage 1
* 
* This format can be used when simple text links can be used in the headers
*   	{{#view Tent.Accordion}}
*	      {{#view Tent.AccordionGroup title="Title1"}}
*	        {{view Tent.Button label="Button with options only" type="info" optionsBinding="Pad.btnOptions"}}
*	      {{/view}}
*	      {{#view Tent.AccordionGroup title="Title2"}}
*	          {{view Tent.TextField valueBinding="Pad.appName" label="Killer Input"}}
*	          {{view Tent.Checkbox label="Self Destruct now" checkedBinding="Pad.privacyPolicy"}}
*	      {{/view}}
*	      {{#view Tent.AccordionGroup title="Title3"}}
*	          Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid.
*	      {{/view}}
*	      {{#view Tent.AccordionGroup title="Title4"}}
*	          Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid.
*	      {{/view}}
*	    {{/view}}
*
* Where more complex content needs to go in the headers, this format may be used:
        {{#view Tent.Accordion}}
          {{#view Tent.AccordionGroup }}
            {{#view Tent.AccordionHeading title="Title1"}}
              <b>Some header content</b>  
            {{/view}}
            {{#view Tent.AccordionBody}}
              body content
            {{/view}}
          {{/view}}
           ...
        {{/view}}

* Or where the title needs to be located other than in the default position:
        {{#view Tent.Accordion}}
          {{#view Tent.AccordionGroup }}
            {{#view Tent.AccordionHeading}}
              <b>more content</b>  <span class="pull-right">{{view Tent.AccordionTitle title="x"}}</span>
            {{/view}}
            {{#view Tent.AccordionBody}}
              body content
            {{/view}}
          {{/view}}
           ...
        {{/view}}
###

require '../template/accordion_group'
require '../template/accordion_heading'

Tent.Accordion = Ember.View.extend
	classNames: ['accordion']


###*
* @class Tent.AccordionGroup
* 
* ##Usage
* 		{{#view Tent.AccordionGroup title="_Title1"}}
*	        ...
*	  	  {{/view}}
* 
###
Tent.AccordionGroup = Ember.View.extend
	classNames: ['accordion-group']
	layoutName: 'accordion_group'
	dataParent: (->
		"#" + @get("parentView.elementId")
	).property("elementId")

	href: (->
		"#" + @get('elementId') + " .accordion-body"
	).property("elementId")


Tent.AccordionHeading = Ember.View.extend
	classNames: ['accordion-heading']
	layoutName: 'accordion_heading'
	dataParent: (->
		"#" + @get("parentView.parentView.elementId")
	).property("elementId")

	href: (->
		"#" + @get('parentView.elementId') + " .accordion-body"
	).property("elementId")

Tent.AccordionTitle = Ember.View.extend
	tagName: 'span'
	layout: Ember.Handlebars.compile('<a class="accordion-toggle" data-toggle="collapse" 
		{{bindAttr data-parent="view.dataParent"}}
		{{bindAttr href="view.href"}}>
		{{loc view.title}}
	</a>')
	dataParent: (->
		"#" + @get("parentView.parentView.parentView.elementId")
	).property("elementId")
	href: (->
		"#" + @get('parentView.parentView.elementId') + " .accordion-body"
	).property("elementId")

Tent.AccordionBody = Ember.View.extend
	classNames: ['accordion-body','collapse']
	layout: Ember.Handlebars.compile('<div class="accordion-inner">{{yield}}</div>')

	 

