###*
 * @class Tent.Html5Support
 * Some docs here...
###

Tent.Html5Support = Ember.Mixin.create
	attributeBindings: ['required']
	required: (->
		@get('parentView.required')
	).property('parentView.required')