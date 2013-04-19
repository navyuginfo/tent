Tent.Data.GroupingSupport = Ember.Mixin.create
	groupingInfo: {}
	currentGroupPage: 1
	currentGroupId: null
	isShowingGroupsList: false

	init: ->
		@_super()
		@REQUEST_TYPE.GROUP = 'group'

	goToGroupPage: (page, groupingInfo) ->
		if groupingInfo?
			@set('groupingInfo', groupingInfo)

		if page?
			@set('groupingInfo.page', page)
			@set('currentGroupPage', page)
		
		@set('groupingInfo.currentGroupId', null)
		@update(@REQUEST_TYPE.GROUP)

	setCurrentGroupId: (id) ->
		@set('currentGroupId', id)
		@set('groupingInfo.currentGroupId', id)

	getGroupingInfo: ->
		@get('groupingInfo')

	clearGrouping: ->
		@set('groupingInfo', 
			columnName: null
			type: null
		)


