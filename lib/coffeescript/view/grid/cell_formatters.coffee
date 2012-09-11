
Tent.Formatters = Ember.Namespace.create
	Date: (row, cell, value, columnDef, dataContext) ->
    	return value.toDateString() if value? 