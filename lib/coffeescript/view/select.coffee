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

  init: ->
    @_super()

  didInsertElement: ->
    @_super(arguments)
    @set('inputIdentifier', @$('select').attr('id'))

  valueForMandatoryValidation: (->
    if @get('multiple')
      @get('selection')
    else
      @get('value')
  ).property('value', 'selection')

  selectionDidChange: (->
    @set('content', @get('selection'))
  ).observes('selected')

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
    if !@get('multiple')
      if prompt = @get('prompt') then prompt else "Please Select..." 
  ).property('prompt')
  
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
      return Tent.I18n.loc(Ember.get(this, labelPath))
    ).property(labelPath).cacheable())
  , 'parentView.optionLabelPath')



