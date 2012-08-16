this.MockDSModel = (hash) ->
	this.hash = hash
	@toJSON = () ->
		return this.hash
	return true

this.MockRecordArray = (array) ->
	this.array = array
	@toArray = ->
		return this.array
	return true