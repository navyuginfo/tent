Tent.Html5Support = Ember.Mixin.create
	attributeBindings: ['required']
	required: (->
		@get('parentView.isMandatory')
	).property('parentView.isMandatory')