require './pager'
require './sorter'

Tent.Data.Collection = Ember.ArrayController.extend Tent.Data.Pager, Tent.Data.Sorter,
	content: null
	dataType: null
	data: []
	serverPaging: false
	liveStreaming: false
	store: null
	REQUEST_TYPE: {'ALL': 'all'}

	columnsDescriptor: [
		{id: "id", name: "ID", field: "id", sortable: true},
		{id: "title", name: "Title", field: "title", sortable: true},
		{id: "duration", name: "Duration", field: "duration", sortable: true},
		{id: "%", name: "% Complete", field: "percentComplete"},
		{id: "start", name: "Start", field: "start"},
		{id: "finish", name: "Finish", field: "finish"},
		{id: "effort-driven", name: "Effort Driven", field: "effortDriven"}
	]

	init: ->
		@_super()
		@update(@REQUEST_TYPE)

	update: (requestType)->
		if @get('dataType')? && @get('store')? 
			query = $.extend({}, 
				{type: requestType}, 
				{paging: @getPagingInfo()})
			@set('data', @get('store').findQuery(eval(@get('dataType')), query))
