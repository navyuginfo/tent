Tent.ReadonlySupport = Ember.Mixin.create
	attributeBindings: ['readOnly:readonly']
	readOnly: (->
		return if (@get('parentView.readOnly') or @get('parentView.isReadOnly')) then true else false
	).property('parentView.readOnly','parentView.isReadOnly')  