Pad.DataStore = Ember.Object.extend
	findAll: (dataType) ->
		Pad.store.findAll(dataType)
	findQuery: (modelType, query) ->
		Pad.store.findQuery(modelType, query)


