require './pager'
require './sorter'

Tent.Data.Collection = Ember.ArrayController.extend Tent.Data.Pager, Tent.Data.Sorter,
	content: null
	dataType: null
	serverPaging: false
	liveStreaming: false
	store: null

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
		@update()

	update: ->
		if @get('dataType')? && @get('store')? 
			@set('content', @get('store').findAll(eval @get('dataType')))