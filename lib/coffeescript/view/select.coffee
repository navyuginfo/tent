#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../template/select'
require '../template/radio_group'
require '../mixin/tooltip_support'
require '../mixin/aria_support'
require '../mixin/readonly_support'

Tent.Select = Ember.View.extend Tent.FieldSupport, Tent.TooltipSupport,
  templateName: 'select'
  classNames: ['tent-select', 'control-group']
  contentBinding: 'selection'
  
  forId: (->
    @get('inputIdentifier')
  ).property('inputIdentifier')

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

  isTextDisplay: (->
    @get('textDisplay') or (not @get('isEditable'))
  ).property('textDisplay', 'isEditable')

  selectionDidChange: (->
    @set('content', @get('selection'))
  ).observes('selected')

  currentSelectedLabel: (->
    content = @get('selection')
    if content? 
      if content instanceof Array
        labels = []
        for item in content 
          labels.push(@getLabelForContent({content: item}))
        return labels.join()
      else
        return @getLabelForContent(@, @get('optionLabelPath'))
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



