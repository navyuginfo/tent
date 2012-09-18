Tent.RadioOption = Ember.SelectOption.extend
 	tagName: "input"
 	classNames: ['tent-radio-option']
 	attributeBindings: ['type','value', 'checked', 'name']
 	type: "radio"
 	
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
		