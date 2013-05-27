setup = ->
	Collection = Ember.Object.extend Tent.Data.GroupingSupport,
		REQUEST_TYPE: {}
		update: ->

	@collection = Collection.create()


teardown = ->
	@collection = null

module 'Tent.Data.GroupingSupport', setup, teardown

test 'Test that', ->
	equal collection.REQUEST_TYPE.GROUP, 'group', 'Set up type'
	equal collection.get('currentGroupPage'), 1, 'current group page'
	
test "go to group page", ->
	sinon.spy(collection, "update")

	collection.goToGroupPage()
	equal collection.get('groupingInfo.currentGroupId'), null, 'current group id set to null'
	ok collection.update.calledOnce, 'Called update'

	collection.goToGroupPage(2)
	equal collection.get('groupingInfo.page'), 2, 'page 2'
	equal collection.get('currentGroupPage'), 2, 'current group page 2'

	gi = {page: 5}
	collection.goToGroupPage(null, gi)
	equal collection.get('groupingInfo.page'), 5, 'grouping info copied'

test "setCurrentGroupId", ->
	collection.setCurrentGroupId(56)
	equal collection.get('currentGroupId'), 56, '56'
	equal collection.get('groupingInfo.currentGroupId'), 56, '56'

	collection.clearGrouping()
	equal collection.get('groupingInfo.columnName'), null, 'clear column name'
	equal collection.get('groupingInfo.type'), null, 'clear type'
	

	
	
	
