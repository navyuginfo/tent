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
require '../mixin/tooltip_support'
require '../mixin/aria_support'
require '../mixin/readonly_support'

Tent.Select = Ember.View.extend Tent.FieldSupport, Tent.TooltipSupport,
  templateName: 'select'
  classNames: ['tent-select', 'control-group']
  contentBinding: 'selection'

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
  * @property {boolean} isEnhanced Renders the select widget as a progressively enhanced, stylable control.
  * The control and options may be styled by css, and the options may be rendered using HTML rather than plain
  * text.
  ###
  isEnhanced: true

  ###*
  * @property {Number} menuWidth The width available for the option items.
  * This is used when it is likely that the options will be wider than the selection box when they are displayed.
  ###
  menuWidth: null

  init: ->
    @_super()
    if @get('list.length') is 1 and @get('preselectSingleElement')
      @set 'showPrompt', false
  
  didInsertElement: ->
    @_super(arguments)
    @set('inputIdentifier', @$('select').attr('id'))
    @convertToSelectMenu()
  
  # Apply the selectmenu plugin, which allows for styling and markup for <options>
  convertToSelectMenu: ->
    if not @get('isRadioGroup') and (@get('isEnhanced') or Tent.Browsers.isIE())   
      @$('select').selectmenu({
        menuWidth: @get('menuWidth') if @get('menuWidth')?
      })

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

  listObserver: (->    
    if @get 'preselectSingleElement'
      if @get("list.length") is 1
        @set "showPrompt", false
        @set "selection", @get("list").toArray()[0]
      else
        @set "selection", null
        Ember.run =>
          @set "showPrompt", true
    Ember.run.next =>
      # Create a runloop to ensure that this executes after the select DOM has been updated.
      @convertToSelectMenu() if @$()?
  ).observes("list", "list@each")

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


Tent.SelectElement = Ember.Select.extend Tent.AriaSupport, Tent.Html5Support, Tent.DisabledSupport,
  defaultTemplate: Ember.Handlebars.compile('{{#if view.prompt}}<option value>{{view.prompt}}</option>{{/if}}{{#each view.content}}{{view Tent.SelectOption contentBinding="this"}}{{/each}}')

Tent.SelectOption = Ember.SelectOption.extend
  labelPathDidChange: Ember.observer(-> 
    labelPath = Ember.get(@, 'parentView.optionLabelPath')
    if !labelPath
      return
    Ember.defineProperty(@, 'label', Ember.computed(->
      return Tent.I18n.loc(Ember.get(this, labelPath)) if Ember.get(this, labelPath) != ""
    ).property(labelPath).cacheable())
  , 'parentView.optionLabelPath')



