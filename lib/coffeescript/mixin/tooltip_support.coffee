Tent.TooltipSupport = Ember.Mixin.create
	didInsertElement: ->
		@_super()
		@$("a[rel=tooltip]").tooltip()