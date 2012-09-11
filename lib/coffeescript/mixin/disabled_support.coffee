Tent.DisabledSupport = Ember.Mixin.create
	attributeBindings: ['disabled']
	disabledBinding: 'parentView.disabled'
	 