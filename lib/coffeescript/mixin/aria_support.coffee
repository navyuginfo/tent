Tent.AriaSupport = Ember.Mixin.create
	attributeBindings: ['ariaRequired:aria-required']
	ariaRequired: (->
		return if @get('parentView.isMandatory') then 'true' else 'false'
	).property('parentView.isMandatory')  