#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
* @class Tent.Select
* @mixins Tent.FieldSupport
* @mixins Tent.TooltipSupport
*
* Usage
*        {{view Tent.Select 
            listBinding="" 
            selectionBinding="" 
            label="" 
            optionLabelPath="" 
            optionValuePath="" 
            multiple=true 
          }}
###

require '../template/select'
require '../template/radio_group'
require '../mixin/filtering_support'
require '../mixin/tooltip_support'
require '../mixin/aria_support'
require '../mixin/readonly_support'

Tent.Select = Ember.View.extend Tent.FieldSupport, Tent.TooltipSupport, Tent.FilteringSupport,
  templateName: 'select'
  classNames: ['tent-select', 'control-group']
  contentBinding: 'selection'
  value: null

  ###*
  * @property {Array} list An array of objects to be presented as the dropdown options. Each item of
  * the array should be a hash of two values, representing the text to display, and the value of that option
  ###
  list: null

  ###*
  * @property {Object} selection A property to which the selected item(s) from the field is bound
  ###
  selection: null

  ###*
  * @property {String} optionLabelPath The name of the property of the list which is to 
  * be used as the label for the option
  ###
  optionLabelPath: null

  ###*
  * @property {String} optionValuePath The name of the property of the list which is to 
  * be used as the value for the option
  ###
  optionValuePath: null

  ###*
  * @property {Boolean} [multiple=false] A boolean property indicating whether multiple values may be selected.
  ###
  multiple: false

  ###*
  * @property {Boolean} isRadioGroup A boolean property to indicate that the presentation should be a group of radio buttons
  ###
  isRadioGroup: false

  ###*
  * @property {Boolean} [showPrompt=true] A boolean property to indicate whether a prompt should be displayed in
  * the select dropdown. 
  * If no 'prompt' property is set, the prompt will default to a message similar to 'Please Select ...' 
  ###
  showPrompt: true

  ###*
  * @property {Boolean} [preselectSingleElement=false] A boolean property to indicate whether a prompt 
  * should be displayed in the select dropdown if the list has only one option available. If set to true, the only option 
  * in the list will be preselected. If false, the prompt will be displayed.
  * 
  ###
  preselectSingleElement: false

  ###*
   * @property {Boolean} isLoading A boolean to indicate that the content for the control has not yet loaded.
   * This will usually be represented in the UI by a spinning icon.
  ###
  isLoading: null

  isLoaded: null

  ###*
  * @property {Boolean} advanced This attached Select2 behavior to the widget, allowing such features as autocomplete,
  * option formatting and tag management.
  ###
  advanced: false

  init: ->
    @_super()
    if @get('list.length') is 1 and @get('preselectSingleElement')
      @set 'showPrompt', false
  
  didInsertElement: ->
    @_super(arguments)
    @set('inputIdentifier', @$('select').attr('id'))

    @setupAdvancedMode()
    
    # Handle select box expansion issues in ie8
    if Tent.Browsers.isIE()
      @$('.ember-select').bind('focus mouseover', ->
        $(this).removeClass('clicked mouseout').addClass('expand')
      ).bind('click', ->
        $(this).toggleClass 'clicked'
        if $(this).hasClass 'mouseout' then $(this).removeClass 'expand'
      ).bind('mouseout', ->
        if $(this).hasClass('clicked') then $(this).addClass 'mouseout' else $(this).removeClass 'expand'
      ).bind 'blur', ->
        $(this).removeClass 'expand clicked mouseout'

    # Ensure that supplying an initial value will defaul the dropdown at the correct option 
    @valueDidChange()
            
  valueForMandatoryValidation: (->
    if @get('multiple')
      @get('selection')
    else
      @get('value')
  ).property('value', 'selection')

  # A widget is expected to have a formatted value to apply to validation checks etc
  formattedValue: (->
    @get('currentSelectedLabel')
  ).property('currentSelectedLabel')

  selectionDidChange: (->
    @set('content', @get('selection'))
  ).observes('selected')

  # Ensure that the correct operator is selected in the operators dropdown
  valueDidChange: (->
    value = @get('value')
    if value?
      valuePath = @get('optionValuePath').replace(/^content\.?/, '')
      selectedValueObject = @get('list').filter((item)=>
        value == if valuePath? then Ember.get(item, valuePath) else item
      )
      @set('selection', selectedValueObject[0]) if selectedValueObject.length == 1
  ).observes('value')
  

  listObserver: (->
    if @get 'preselectSingleElement'
      if @get("list.length") is 1
        @set "showPrompt", false
        @set "selection", @get("list").toArray()[0]
      else
        @set "selection", null
        Ember.run =>
          @set "showPrompt", true
  ).observes("list", "list.length", "list@each")

  currentSelectedLabel: (->
    content = @get('selection')
    if content? 
      if content instanceof Array
        labels = []
        for item in content 
          labels.push(Tent.I18n.loc(@getLabelForContent({content: item})))
        return labels.join()
      else
        return Tent.I18n.loc(@getLabelForContent(@))
  ).property('selection')

  getLabelForContent: (item)->
    Ember.get(item, @get('optionLabelPath'))

  _prompt: (-> 
    if !@get('multiple') and @get('showPrompt')
      if prompt = Tent.I18n.loc(@get('prompt')) then prompt else Tent.I18n.loc 'tent.pleaseSelect'
  ).property('prompt','showPrompt')
  
  change: ->
      @_super(arguments)
      @set('isValid', @validate())

  showSpinner: (->
    if @get('isLoaded')?
      return not @get('isLoaded')
    if @get('isLoading')?
      return @get('isLoading')
  ).property('isLoaded', 'isLoading')

  setupAdvancedMode: ->
    if @get('advanced') and not @get('isRadioGroup')
      @$('.primary-class').select2({
        placeholder: @get('_prompt')
        allowClear: true if not @get('multiple')
        dropdownAutoWidth: true
      })

Tent.SelectElement = Ember.Select.extend Tent.AriaSupport, Tent.Html5Support, Tent.DisabledSupport,
  defaultTemplate: Ember.Handlebars.compile('
    {{#if view.prompt}}
      {{#if view.advanced}}
        <option></option>
      {{else}}
        <option value>{{view.prompt}}</option>
      {{/if}}
    {{/if}}
    {{#each view.content}}{{view Tent.SelectOption contentBinding="this"}}{{/each}}'
  )

Tent.SelectOption = Ember.SelectOption.extend
  labelPathDidChange: Ember.observer(-> 
    labelPath = Ember.get(@, 'parentView.optionLabelPath')
    if !labelPath
      return
    Ember.defineProperty(@, 'label', Ember.computed(->
      return Tent.I18n.loc(Ember.get(this, labelPath)) if Ember.get(this, labelPath) != ""
    ).property(labelPath).cacheable())
  , 'parentView.optionLabelPath')



