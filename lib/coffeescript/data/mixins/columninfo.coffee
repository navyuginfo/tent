Tent.Data.ColumnInfo = Ember.Mixin.create
	init: ->
		@_super()
		@set('columnInfo', 
			titles: {}
			widths: {}
			order: {}
			hidden: {}
		)
			
