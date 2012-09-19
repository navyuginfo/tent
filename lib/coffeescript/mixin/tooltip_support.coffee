Tent.TooltipSupport = Ember.Mixin.create
	didInsertElement: ->
		@_super()
		@$("a[rel=tooltip]").tooltip()
	tooltipT: (->
		Tent.I18n.loc(@get('tooltip'))
	).property('tooltip')