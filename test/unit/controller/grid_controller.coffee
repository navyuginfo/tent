#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require 'tent'
require 'ember-data'

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->
	@controller = Tent.Controllers.GridController.create()
	@emptyRecordArray = DS.RecordArray.create({
		content: []
	})

	MockDSModel = (hash) ->
		this.hash = hash
		@toJSON = () ->
			return this.hash
		return true
	MockRecordArray = (array) ->
		this.array = array
		@toArray = ->
			return this.array
		return true

	model1 = new MockDSModel({title:"account123"})
	model2 = new MockDSModel({title:"account321"})
	records = [model1, model2]
	@recordArray = new MockRecordArray(records)

teardown = ->
	if view
		Ember.run -> view.destroy()
	view = null
	@controller = @emptyRecordArray = undefined

module "Tent.GridController", setup, teardown

test 'Converting a RecordArray to an Array: empty array', ->
	arr = controller.getArrayFromRecordArray(emptyRecordArray)
	equal arr.length, 0, 'should be an empty array'

test 'Converting a RecordArray to an Array: populated array', ->
	arr = controller.getArrayFromRecordArray(recordArray)
	equal arr.length, 2, 'should be 2 entries'

