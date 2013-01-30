view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->
	@TemplateTests = Ember.Namespace.create()
	Ember.run ->
		@dispatcher = Ember.EventDispatcher.create()
		@dispatcher.setup()

	@row_data = [
		Ember.Object.create(id: 51,title: "Task 1"),
		Ember.Object.create(id: 52,title: "Task 2"),
		Ember.Object.create(id: 53,title: "Task 3")
	]

	@column_data = [
		{id: "id", name: "id", title: "_hID", field: "id", sortable: true},
		{id: "title", name: "title", title: "_hTitle", field: "title", sortable: true}
	]

	@collection = Ember.ArrayController.create
		paged: true
		content: row_data
		goToPage: ->
		pagingInfo: 
			pageSize: 1
			page: 1
			totalPages: 3
		sortingInfo: 
			field: 'title'
			asc: 'desc'
		columnInfo: 
			titles: 
				'title': 'New Title'
			
		getURL: ->

teardown = ->
	
	if view
		gridView = Ember.View.views[view.$('.tent-jqgrid').attr('id')]
		Ember.run -> 
			view.destroy()
			gridView.destroy()
		view = null
		gridView = null
	 
	@TemplateTests = undefined
	@dispatcher.destroy()
	@row_data = null
	@column_data = null
	@collection = null

module 'Tent.JqGrid', setup, teardown

###test 'Collection required', ->
	mockCollection = Ember.Object.create()

	raises ->
			Tent.JqGrid.create()
		,
		'Should throw an exception'

	grid = Tent.JqGrid.create
		collection: mockCollection

	equal grid.get('selectedIds').length, 0, 'No selectedIds'
###

test 'Collection data set up', ->

	grid = Tent.JqGrid.create
		collection: collection

	equal grid.pagingInfo.page, 1, 'Paging data'

test 'Collection not provided', ->
	grid = Tent.JqGrid.create()
	equal grid.pagingInfo, undefined, 'No paging info'


test 'Initial Selection should be populated', ->
	#mockCollection = Ember.Object.create()
	selection = [Ember.Object.create(id: 51,title: 't1'),Ember.Object.create(id: 52,title: 't2')]

	grid = Tent.JqGrid.create
		selection: selection

	equal grid.get('selectedIds').length, 2, 'Should be 2 selected IDs'

test 'Retrieve column model', ->
	mockCollection = Ember.Object.create
		columnsDescriptor: [
			{id: "id", name: "id", title: "_hID", field: "id", sortable: true},
			{id: "title", name: "title", title: "_hTitle", field: "title", sortable: true},
			{id: "amount", name: "amount", title: "_hAmount", field: "amount", sortable: true, formatter: "amount",  align: 'right'},
		]
		toArray: ->
			[
				Ember.Object.create(id: 51,title: 't1', amount: 23.4)
				Ember.Object.create(id: 52,title: 't2', amount: 24.4)
				Ember.Object.create(id: 53,title: 't3', amount: 25.4)
				Ember.Object.create(id: 54,title: 't4', amount: 26.4)
			]

	grid = Tent.JqGrid.create
		collection: mockCollection

	colModel = grid.get('columnModel')
	equal colModel.length, 3, 'Should be 3 columns'
	equal colModel[0].name, "id", 'name field'
	equal colModel[0].index, "id", 'index field'
	equal colModel[2].align, "right", 'align field'
	equal colModel[2].formatter, "amount", 'formatter field'

	gridData = grid.get('gridData')
	equal gridData.length, 4, 'Row data: 4 items'
	equal gridData[0].id, 51, 'Row data: ID field of row'
	equal gridData[0].cell[0], 51, 'Row data: Id is added to the cell'
	equal gridData[0].cell[1], 't1', 'Row data: Title is added to the cell'
	equal gridData[0].cell[2], 23.4, 'Row data: Amount is added to the cell'

test 'selectedIds should track selection', ->
	selection = [Ember.Object.create(id: 51,title: 't1'),Ember.Object.create(id: 52,title: 't2')]

	grid = Tent.JqGrid.create
		selection: selection

	equal grid.get('selectedIds').length, 2, "Should be 2 selectedIds"
	grid.clearSelection()
	equal grid.get('selection').length, 0, "Selection should be empty"
	equal grid.get('selectedIds').length, 0, "selectedids should be empty"

	grid.get('selection').pushObject(Ember.Object.create(id: 52,title: 't2'))
	equal grid.get('selectedIds').length, 1, "selectedids should have one entry"

	grid.deselectItem('52')
	equal grid.get('selectedIds').length, 0, "selectedids should be empty"


test 'Validate on Selection', ->
	mockCollection = Ember.Object.create()
	selection = [Ember.Object.create(id: 51,title: 't1'),Ember.Object.create(id: 52,title: 't2')]

	grid = Tent.JqGrid.create
		collection: mockCollection

	didValidate = false
	grid.validate = ->
		didValidate = true

	grid.set('selection', selection)
	ok didValidate, 'Should have validated'


test 'Insert into dom. Single-select, non-paged', ->
	selection = [Ember.Object.create(id: 52,title: "Task 2")]

	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.JqGrid
	          label="Tasks"
	          columnsBinding="columns"
	          contentBinding="row_data"
	          selectionBinding="selection"
	          multiSelect=false
	          required=true
	    }}'
		row_data: row_data
		columns: column_data
		selection: selection

	appendView()
	gridView = Ember.View.views[view.$('.tent-jqgrid').attr('id')]
	equal gridView.getTableDom().jqGrid('getDataIDs').length, 3 ,'There should be 3 rows'
	equal gridView.get('selection').length, 1, 'One item selected'
	equal gridView.get('selectedIds').length, 1, 'One id selected'
	equal gridView.get('selectedIds')[0], 52, '52'

	equal gridView.$('[role="columnheader"]').length, 2, '2 columns'
	equal gridView.$('[role="row"]').length, 4, '4 rows (one hidden by jqgrid)'

	ok gridView.$('#52').hasClass('ui-state-highlight'), 'correct item selected' 

test 'Select Row', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.JqGrid
	          label="Tasks"
	          columnsBinding="columns"
	          contentBinding="row_data"
	          multiSelect=false
	          required=true
	    }}'
		row_data: row_data
		columns: column_data
	
	appendView()
	gridView = Ember.View.views[view.$('.tent-jqgrid').attr('id')]
	equal gridView.get('selection').length, 0, 'No items selected'

	gridView.didSelectRow('51')
	equal gridView.get('selection').length, 1, '1 item selected'
	equal gridView.get('selectedIds').length, 1, 'One id selected'
	equal gridView.get('selectedIds')[0], 51, '51 selected'
	ok gridView.$('#51').hasClass('ui-state-highlight'), 'correct item selected' 

	gridView.didSelectRow('52')
	equal gridView.get('selection').length, 1, '1 item selected'
	equal gridView.get('selectedIds').length, 1, 'One id selected'
	equal gridView.get('selectedIds')[0], 52, '52 selected'
	ok gridView.$('#52').hasClass('ui-state-highlight'), 'correct item selected' 
	ok not gridView.$('#51').hasClass('ui-state-highlight'), 'previous item deselected' 


test 'ClearAction, and set selection to empty', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.JqGrid
	          label="Tasks"
	          columnsBinding="columns"
	          contentBinding="row_data"
	          multiSelect=false
	          required=true
	    }}'
		row_data: row_data
		columns: column_data

	appendView()
	gridView = Ember.View.views[view.$('.tent-jqgrid').attr('id')]

	gridView.didSelectRow('52')
	equal gridView.get('selection').length, 1, '1 item selected'
	ok gridView.$('#52').hasClass('ui-state-highlight'), 'correct item selected' 
	gridView.set('clearAction', true)
	ok not gridView.$('#52').hasClass('ui-state-highlight'), 'item deselected' 
	gridView.didSelectRow('53')
	equal gridView.get('selection').length, 1, '1 item selected'
	ok gridView.$('#53').hasClass('ui-state-highlight'), 'correct item selected' 
	gridView.set('selection', [])
	equal gridView.get('selectedIds').length, 0, '0 ids selected'
	

test 'Multiselect', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.JqGrid
	          label="Tasks"
	          columnsBinding="columns"
	          contentBinding="row_data"
	          multiSelect=true
	          required=true
	          selection=selection
	    }}'
		row_data: row_data
		columns: column_data
		selection: []

	appendView()
	gridView = Ember.View.views[view.$('.tent-jqgrid').attr('id')]
	 
	gridView.didSelectRow('51')
	equal gridView.get('selection').length, 1, '1 item selected'
	gridView.didSelectRow('52')
	equal gridView.get('selection').length, 2, '2 items selected'
	ok gridView.$('#51').hasClass('ui-state-highlight'), '51 selected' 
	ok gridView.$('#52').hasClass('ui-state-highlight'), '52 selected' 
	gridView.deselectItem('52')
	ok not gridView.$('#52').hasClass('ui-state-highlight'), 'deselected 52' 
	gridView.clearSelection()
	ok not gridView.$('#51').hasClass('ui-state-highlight'), 'clear selection' 
	gridView.didSelectAll([51,52,53])
	equal gridView.get('selection').length, 3, 'All items selected'
	ok gridView.$('#51').hasClass('ui-state-highlight'), 'Select all' 
	ok gridView.$('#52').hasClass('ui-state-highlight'), '52 select all' 
	ok gridView.$('#53').hasClass('ui-state-highlight'), '53 select all' 
	gridView.didSelectAll([51,52,53], false)
	equal gridView.get('selection').length, 0, 'No items selected'
	ok not gridView.$('#51').hasClass('ui-state-highlight'), '51 not selected' 
	ok not gridView.$('#52').hasClass('ui-state-highlight'), '52 not selected' 
	ok not gridView.$('#53').hasClass('ui-state-highlight'), '53 not selected' 


test 'Error Cell', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.JqGrid
	          label="Tasks"
	          columnsBinding="columns"
	          contentBinding="row_data"
	          multiSelect=true
	          required=true
	          selection=selection
	    }}'
		row_data: row_data
		columns: column_data
		selection: []

	appendView()
	gridView = Ember.View.views[view.$('.tent-jqgrid').attr('id')]

	gridView.markErrorCell(52, 2)
	ok gridView.getCell(52,2).hasClass('error'), 'Error class added'
	gridView.unmarkErrorCell(52, 2)
	ok not gridView.getCell(52,2).hasClass('error'), 'Error class removed'


test 'Paging data collection binding', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.JqGrid
	          label="Tasks"
	          columnsBinding="columns"
	          collectionBinding="collection"
	          multiSelect=true
	          required=true
	          selection=selection
	    }}'
		collection: collection
		columns: column_data
		selection: []
	appendView()

	gridView = Ember.View.views[view.$('.tent-jqgrid').attr('id')]

	equal gridView.pagingInfo.pageSize, 1, 'PageSize should be 1 - from the controller'
	equal gridView.pagingInfo.page, 1, 'Page should be 1 - from the controller'
	equal gridView.pagingInfo.totalPages, 3, 'Total pages should be 3 - from the controller'

test 'Paging data collection binding: no data on collection', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.JqGrid
	          label="Tasks"
	          columnsBinding="columns"
	          collectionBinding="collection"
	          multiSelect=true
	          required=true
	          selection=selection
	          paged=true
              pageSize=6
	    }}'
		collection: collection
		columns: column_data
		selection: []

	collection.set('pagingInfo.pageSize', null) 
	appendView()
	gridView = Ember.View.views[view.$('.tent-jqgrid').attr('id')]
	equal gridView.pagingInfo.pageSize, 6, 'PageSize should be 6 - from the view'


test 'Sorting data collection binding', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.JqGrid
	          label="Tasks"
	          columnsBinding="columns"
	          collectionBinding="collection"
	          multiSelect=true
	          required=true
	          selection=selection
	          paged=true
              pageSize=6
	    }}'
		collection: collection
		columns: column_data
		selection: []

	appendView()
	gridView = Ember.View.views[view.$('.tent-jqgrid').attr('id')]

	equal gridView.sortingInfo.field, 'title', 'sorting field is title on the controller'
	equal gridView.sortingInfo.asc, 'desc', 'sorting dir is desc on the controller'

	 
test 'Column info bound to collection', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.JqGrid
	          label="Tasks"
	          columnsBinding="columns"
	          collectionBinding="collection"
	          multiSelect=true
	          required=true
	          selection=selection
	          paged=true
              pageSize=6
	    }}'
		collection: collection
		columns: column_data
		selection: []

	appendView()
	gridView = Ember.View.views[view.$('.tent-jqgrid').attr('id')]

	equal gridView.columnInfo.titles.title, 'New Title', 'Title read from controller'
	equal gridView.get('columns')[1].title, 'New Title', 'Columns Descriptor has been updated with new title'

	gridView.renameColumnHeader('title', 'jabberwocky', gridView.$())
	equal collection.get('columnInfo.titles.title'), 'jabberwocky', 'Changed column title propagated to collection'
	gridView.renameColumnHeader('id', '6655', gridView.$())
	equal collection.get('columnInfo.titles.id'), '6655', 'Changed column id propagated to collection'


###
test 'Export', ->
test 'Collection Support', ->
###


