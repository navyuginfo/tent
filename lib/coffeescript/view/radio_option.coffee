Tent.RadioOption = Ember.SelectOption.extend
 	tagName: "input"
 	classNames: ['tent-radio-option']
 	attributeBindings: ['type','value', 'checked', 'name']
 	type: "radio"
 	defaultTemplate: Ember.Handlebars.compile('<label {{bindAttr for="view.radioId"}}>{{view.label}}</label>')
 	
 	name: (->
 		@get('parentView.elementId')
 	).property()

 	label: (->
 		@get('content').get(@get('parentView.optionLabelPath'))
 	).property()

 	radioId: (->
 		@get('elementId')
 	).property()

 	change: ->
 		@get('parentView').set('selection', @get('content'))

	didInsertElement: ->
		console.log('debugging..')	