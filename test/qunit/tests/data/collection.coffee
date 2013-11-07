
setup = ->

teardown = ->


module 'Tent.Data.Collection', setup, teardown	

test 'Total pages', ->
	collection = Tent.Data.Collection.create
		dataType: "Pad.Models.TaskModel"
		store: 
			fetchPersonalizationsWithQuery: ->
			getColumnsForType: ->
				[
					Ember.Object.create {id: "id", name: "id", type:"number", title: "_hID", field: "id", width:5, sortable: true, hidden: true, formatter: "action", formatoptions: {action: "showInvoiceDetails"}, hideable: true, groupable: false, filterable:true},
					Ember.Object.create {id: "title", name: "title", type:"string", title: "_hTitle", field: "title", width:5, sortable: true, hideable: false},
					Ember.Object.create {id: "duration", name: "duration", type:"string", title: "_hDuration",field: "duration", width:10, sortable: true, groupable:true, align: 'right'},
				]

	equal collection.getColumnByField('duration').get('title'), '_hDuration', 'The correct field was returned'
	