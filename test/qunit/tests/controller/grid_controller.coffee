#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->

	Tent.Mock = Tent.Mock || Ember.Namespace.create()
	Tent.Mock.DSModel = Ember.Object.extend
		toJSON: () ->
			return @content

	Tent.Mock.RecordArray = Ember.Object.extend
		toArray: ->
			return @content
		removeArrayObserver: ->
			console.log 'removeArrayObserver'
		addArrayObserver: ->
			console.log 'addArrayObserver'
	

	@controller = Tent.Controllers.GridController.create()
	@emptyRecordArray = DS.RecordArray.create({
		content: []
	})

	model1 = Tent.Mock.DSModel.create({content: {title:"account123"}})
	model2 = Tent.Mock.DSModel.create({content: {title:"account321"}})
	records = [model1, model2]
	@recordArray = Tent.Mock.RecordArray.create({content: records})

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

