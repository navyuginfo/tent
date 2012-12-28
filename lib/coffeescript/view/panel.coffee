#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
* @class Tent.Panel
* A container for content which can specify a span and a title. 
* A panel can also be collapsible, in {@link #collapsible} is set to true, 
* and in that case, the initial collapsed state can be specified by {@link #collapsed}.
*
* Usage 
* 		{{#view Tent.Panel span="10" title=""}}
*			...
*		  {{/view}}
###
require '../mixin/span_support'
require '../template/panel'

Tent.Panel = Ember.View.extend Tent.SpanSupport,
  #layout: Ember.Handlebars.compile '{{#if view.name}}<h3>{{loc view.name}}</h3>{{/if}}{{yield}}'
  layoutName: 'panel'
  classNames: ['tent-panel']
  classNameBindings: ['spanClass', 'collapsible', 'collapsed']
  nameBinding: 'title'

  ###*
  * @property {Number} span The horizontal span which should be allocated to this widget
  ###

  ###*
  * @property {String} title The title to display at the top of the panel.
  ###
  title: ""

  ###*
  * @property collapsible Boolean to indicate that the panel is collapsible
  ###
  collapsible: false

  ###*
  * @property collapsed Boolean to indicate that the panel is collapsed initially
  ###
  collapsed: false

  collapsedClass: (->
    "collapse " + if not @get('collapsed') then "in" else ""
  ).property('collapsed')

  href: (->
    "#" + @get('elementId') + " .collapse"
  ).property("elementId")

  didInsertElement: ->
    if @get('collapsible')
      @$('.collapse').on('hidden', ()=>
        @set('collapsed', true)
      )
      @$('.collapse').on('shown', ()=>
        @set('collapsed', false)
      )

###*
* @class Tent.PanelHead
* Used in the case where a custom header is required for a panel
###
Tent.PanelHead = Ember.View.extend
  classNames: ['accordion-heading']

  didInsertElement: ->
    if @$('.panel-link').length > 0
      @set('hasLink', true)

  layout: Ember.Handlebars.compile '<div class="panel-header clearfix">
        <span class="content">{{yield}}</span>
        {{#unless view.hasLink}}
        <a class="pull-right" data-toggle="collapse" {{bindAttr href="view.parentView.href"}}>
          <span class="caret" ></span>
        </a>
        {{/unless}}
      </div>'


Tent.PanelBody = Ember.View.extend
  layout: Ember.Handlebars.compile '<div {{bindAttr class="view.parentView.collapsedClass"}}>
        <div class="panel-content">
          {{yield}}
        </div>
      </div>'


###*
* @class Tent.PanelLink
* Generates a link for use within the body of a header. This link will expand and 
* contract the group 
###
Tent.PanelLink = Ember.View.extend
  tagName: 'span'
  classNames: ['panel-link']
  classNameBindings: ['hidden']

  collapsedDidChange: (->
    @calculateVisibility()
  ).observes('parentView.parentView.collapsed')

  didInsertElement: ->
    @set('hidden', @get('parentView.parentView.collapsed'))
    @calculateVisibility()

  calculateVisibility: ->
    hidden = false
    if @get('whenCollapsed')?
       hidden = true if @get('whenCollapsed') != @get('parentView.parentView.collapsed') 
    @set('hidden', hidden)

  layout: Ember.Handlebars.compile('<a class="accordion-toggle" data-toggle="collapse" 
    {{bindAttr href="view.parentView.parentView.href"}}>
    {{#if view.title}}{{loc view.title}}{{/if}}{{yield}}
  </a>')
  ###*
  * @property {String} title A title to display which acts as the link text to expand the group
  ###
  title: ""


Tent.Form = Tent.Panel.extend
  tagName: 'form'
  staticClasses: ''
  classNameBindings: ['spanClass', 'staticClasses', 'formClass']
  classNames: ['tent-form']
  formStyle: 'horizontal'
  formClass: (-> 'form-' + @get('formStyle')).property('formStyle')


Tent.Fieldset = Tent.Panel.extend
  layout: Ember.Handlebars.compile '{{#if view.name}}<legend>{{loc view.name}}</legend>{{/if}}{{yield}}'
  tagName: 'fieldset'
