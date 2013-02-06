###
This mixin allows UI state to be stored by the user, and restored automatically the next time the user uses
the same collection


The json data we expect is:

paging: {
	pageSize: 12
}
sorting: {
	field: 'title'
	asc: 'desc'
}
column: {
	titles: {
		duration: 'Time Elapsed'
	}
	widths: {
		id: 5
		title: 35
		duration: 10
		percentcomplete: 10
		effortdriven: 10
		start: 10
		finish: 10
		completed: 10
	}
	order: {
		id: 1
		title: 3
		duration: 2
		percentcomplete: 4
		effortdriven: 5
		start: 6
		finish: 7
		completed: 8
	}
	hidden: {
		start: true
		finish: true
	}
}
grouping: {
	columnName: 'duration'
	type: 'exact'
}

###

Tent.Data.Customizable = Ember.Mixin.create
	isCustomizable: true  #Allows the user to storer and retrieve the current state of the collection (and UI properties such as grouping/column visibility etc)
	customizationName: null

	init: ->
		@_super()
		@set('customizationName', null)

	saveUIState: (name)->
		if name?
			@set('customizationName', name)
		uiState = @gatherGridData(@get('customizationName'))
		response = @get('store').findQuery(eval(@get('dataType')), uiState)

	gatherGridData: (name)->
		state = $.extend(
			{customizationName: name},
			{paging: @get('pagingInfo')},
			{sorting: @get('sortingInfo')},
			{filtering: @getFilteringInfo()}
			{columns: @get('columnInfo')}
			{grouping: @get('groupingInfo')}
		)

	restoreUIState: ->
		uiState = @get('store').findQuery(eval(@get('dataType')), 'collectionUIState')
		@set('customizationName', uiState.customizationName)
		@set('pagingInfo', uiState.paging)
		@set('sortingInfo', uiState.sorting)
		@set(filteringInfo, uiState.filtering)
		@set('columnInfo', uiState.columns)
		@set('groupingInfo', uiState.grouping)
		