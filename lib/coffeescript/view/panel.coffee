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

  hideHeaderWhenExpanded: false

  collapsedClass: (->
    "collapse " + if not @get('collapsed') then "in" else ""
  ).property('collapsed')

  href: (->
    "#" + @get('elementId') + " .collapse"
  ).property("elementId")

  didInsertElement: ->
    if @get('collapsible')
      @$('.collapse').on('hide', ()=>
        @set('collapsed', true)
      )
      @$('.collapse').on('show', ()=>
        @set('collapsed', false)
      )

  show: ->
    @$('.collapse').collapse('show')
    @set('collapsed', false)

  hide: ->
    @$('.collapse').collapse('hide')
    @set('collapsed', true)



###*
* @class Tent.PanelHead
* Used in the case where a custom header is required for a panel
###
Tent.PanelHead = Ember.View.extend
  classNames: ['accordion-heading']

  didInsertElement: ->
    if @$('.panel-link').length > 0
      @set('hasLink', true)

  hideHeaderContent: (->
    @get('parentView.hideHeaderWhenExpanded') and not @get('parentView.collapsed')
  ).property('parentView.collapsed')

  layout: Ember.Handlebars.compile '<div class="panel-header clearfix">
        <span class="content">{{#unless view.hideHeaderContent}}{{yield}}{{/unless}}</span>
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
* @class Tent.PanelSlider
*
* Used where the content is expected to slide down (rather than be revealed down)
* Effectively, the bottom row of the content becomes the header content when the 
* panel is collapsed
*
* Usage: 
*           {{#view Tent.Panel span="10" collapsible=true collapsed=false hasChildViews=true }}
              {{#view Tent.PanelSlider minHeight=40}}
               
                ... content here ...
              {{/view}}
            {{/view}}
* 
###
Tent.PanelSlider = Ember.View.extend
  layout: Ember.Handlebars.compile '<div class="panel-slider panel-header clearfix">
        <span class="content"><span>{{yield}}</span></span>
        <a class="pull-right">
          <span class="caret" ></span>
        </a>
      </div>'
  minHeight: 30

  didInsertElement: ->
    content = @$('.content')
    @set('height', @$('.content').outerHeight())
    @$('.content').css('min-height', '30px').css('position', 'absolute').css('bottom','0px')

    @$('a').click(=>
      if @get('parentView.collapsed')
        @$('.panel-slider').animate({height: @get('height') + 'px'})
        @set('parentView.collapsed', false)
      else
        @$('.panel-slider').animate({height: @get('minHeight') + 'px'})
        @set('parentView.collapsed', true)
    )

    if not @get('parentView.collapsed')
      @$('.panel-slider').css('height', @get('height') + 'px')


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
  layout: Ember.Handlebars.compile '{{#if view.legendName}}<legend>{{loc view.legendName}}</legend>{{/if}}{{yield}}'
  tagName: 'fieldset'
