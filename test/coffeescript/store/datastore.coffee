Pad.DataStore = Ember.Object.extend
	findAll: (dataType) ->
		@getArrayFromRecordArray(Pad.store.findAll(dataType))
	findQuery: (modelType, query) ->
		@getArrayFromRecordArray(Pad.store.findQuery(modelType, query))

	getArrayFromRecordArray: (recordArray)-> 
		_list = []
		for item in recordArray.toArray()
			if item?
				# TO REMOVE: this is here to show that the sort is being applied
				#json = item.toJSON()
				#json.title += Math.round(Math.random() * 100)
				#_list.push json
				_list.push item.toJSON()
		return _list
