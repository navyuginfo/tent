Tent.RadioOption = Ember.SelectOption.extend
 	tagName: "div"
 	classNames: ['tent-radio-option']
 	attributeBindings: ['type','value', 'checked', 'name']
 	type: "radio"
 	layout: Ember.Handlebars.compile '<input type="radio" class="tent-radio-option"
 			{{bindAttr value="view.value"}}
 			{{bindAttr name="view.name"}}
 			{{bindAttr checked="view.checked"}}/>
	 		{{#if view.label}}{{loc view.label}}{{/if}}'
 	
 	name: (->
 		@get('parentView.elementId')
 	).property()

 	label: (->
 		Tent.I18n.loc(@get('content').get(@get('parentView.optionLabelPath')))
 	).property()

 	radioId: (->
 		@get('elementId')
 	).property()

 	change: ->
 		@get('parentView').set('selection', @get('content'))

	didInsertElement: ->
		@_super()
		@set('inputIdentifier', @$('input[type="radio"]').attr('id'))

	labelPathDidChange: Ember.observer(-> 
		labelPath = Ember.get(@, 'parentView.optionLabelPath')
		if !labelPath
			return
		Ember.defineProperty(@, 'label', Ember.computed(->
			return Tent.I18n.loc(Ember.get(this, labelPath))
		).property(labelPath).cacheable())
	, 'parentView.optionLabelPath')
		