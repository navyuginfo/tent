###*
 * @class Tent.DisabledSupport
 * Some docs here...
###

Tent.DisabledSupport = Ember.Mixin.create
	attributeBindings: ['disabled']
	disabledBinding: 'parentView.disabled'
	 