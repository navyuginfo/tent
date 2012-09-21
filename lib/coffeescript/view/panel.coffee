#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
* @class Tent.Panel
* A container for content which can specify a span and a title.
* Usage 
* 		{{#view Tent.Panel span="10" title=""}}
*			...
*		  {{/view}}
###
require '../mixin/span_support'

Tent.Panel = Ember.View.extend Tent.SpanSupport,
  layout: Ember.Handlebars.compile '{{#if view.name}}<h3>{{loc view.name}}</h3>{{/if}}{{yield}}'
  classNameBindings: ['spanClass']
  nameBinding: 'title'

  ###*
  * @property {Number} span The horizontal span which should be allocated to this widget
  ###

  ###*
  * @property {String} title The title to display at the top of the panel.
  ###
  title: ""

Tent.Form = Tent.Panel.extend
  tagName: 'form'
  staticClasses: ''
  classNameBindings: ['spanClass', 'staticClasses', 'formClass']
  formStyle: 'horizontal'
  formClass: (-> 'form-' + @get('formStyle')).property('formStyle')


Tent.Fieldset = Tent.Panel.extend
  layout: Ember.Handlebars.compile '{{#if view.name}}<legend>{{view.name}}</legend>{{/if}}{{yield}}'
  tagName: 'fieldset'
