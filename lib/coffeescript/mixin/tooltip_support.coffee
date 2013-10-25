###*
 * @class Tent.TooltipSupport
 * Some docs here...
###

Tent.TooltipSupport = Ember.Mixin.create

	###*
	* @property {String} tooltip A detailed information message presented as a hover-icon beside the field
	###
	tooltip: null

	didInsertElement: ->
		@_super()
		@$("a[rel=tooltip]").tooltip()

	tooltipT: (->
		Tent.I18n.loc(@get('tooltip'))
	).property('tooltip')