view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->
	Tent.Date.getAbbreviatedTZFromDate = (date)->
		return "TMP"
	
	@origFormat = Tent.Formatting.date.format
	Tent.Formatting.date.format = ->
		"01/01/2013"

	Date.CultureInfo={name:"en-US",englishName:"English (United States)",nativeName:"English (United States)",dayNames:["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"],abbreviatedDayNames:["Sun","Mon","Tue","Wed","Thu","Fri","Sat"],shortestDayNames:["Su","Mo","Tu","We","Th","Fr","Sa"],firstLetterDayNames:["S","M","T","W","T","F","S"],monthNames:["January","February","March","April","May","June","July","August","September","October","November","December"],abbreviatedMonthNames:["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],amDesignator:"AM",pmDesignator:"PM",firstDayOfWeek:0,twoDigitYearMax:2029,dateElementOrder:"mdy",formatPatterns:{shortDate:"M/d/yyyy",longDate:"dddd, MMMM dd, yyyy",shortTime:"h:mm tt",longTime:"h:mm:ss tt",fullDateTime:"dddd, MMMM dd, yyyy h:mm:ss tt",sortableDateTime:"yyyy-MM-ddTHH:mm:ss",universalSortableDateTime:"yyyy-MM-dd HH:mm:ssZ",rfc1123:"ddd, dd MMM yyyy HH:mm:ss GMT",monthDay:"MMMM dd",yearMonth:"MMMM, yyyy"},regexPatterns:{jan:/^jan(uary)?/i,feb:/^feb(ruary)?/i,mar:/^mar(ch)?/i,apr:/^apr(il)?/i,may:/^may/i,jun:/^jun(e)?/i,jul:/^jul(y)?/i,aug:/^aug(ust)?/i,sep:/^sep(t(ember)?)?/i,oct:/^oct(ober)?/i,nov:/^nov(ember)?/i,dec:/^dec(ember)?/i,sun:/^su(n(day)?)?/i,mon:/^mo(n(day)?)?/i,tue:/^tu(e(s(day)?)?)?/i,wed:/^we(d(nesday)?)?/i,thu:/^th(u(r(s(day)?)?)?)?/i,fri:/^fr(i(day)?)?/i,sat:/^sa(t(urday)?)?/i,future:/^next/i,past:/^last|past|prev(ious)?/i,add:/^(\+|after|from)/i,subtract:/^(\-|before|ago)/i,yesterday:/^yesterday/i,today:/^t(oday)?/i,tomorrow:/^tomorrow/i,now:/^n(ow)?/i,millisecond:/^ms|milli(second)?s?/i,second:/^sec(ond)?s?/i,minute:/^min(ute)?s?/i,hour:/^h(ou)?rs?/i,week:/^w(ee)?k/i,month:/^m(o(nth)?s?)?/i,day:/^d(ays?)?/i,year:/^y((ea)?rs?)?/i,shortMeridian:/^(a|p)/i,longMeridian:/^(a\.?m?\.?|p\.?m?\.?)/i,timezone:/^((e(s|d)t|c(s|d)t|m(s|d)t|p(s|d)t)|((gmt)?\s*(\+|\-)\s*\d\d\d\d?)|gmt)/i,ordinalSuffix:/^\s*(st|nd|rd|th)/i,timeContext:/^\s*(\:|a|p)/i},abbreviatedTimeZoneStandard:{GMT:"-000",EST:"-0400",CST:"-0500",MST:"-0600",PST:"-0700"},abbreviatedTimeZoneDST:{GMT:"-000",EDT:"-0500",CDT:"-0600",MDT:"-0700",PDT:"-0800"}};
	
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
		personalizable: true
		goToPage: ->
		sort: ->
		getURL: ->
		clearGrouping: ->
		goToGroupPage: ->
		columnsDescriptor: column_data
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
			hidden: {}
			widths:
				id: 20
				title: 80
			order: {}
		groupingInfo: {}
		

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
	Tent.Formatting.date.format = @origFormat

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
		columns: []
	grid.isRowCurrentlyEditing = ->
		return false

	equal grid.get('selectedIds').length, 2, "Should be 2 selectedIds"
	grid.clearSelection()
	equal grid.get('selection').length, 0, "Selection should be empty"
	equal grid.get('selectedIds').length, 0, "selectedids should be empty"

	grid.get('selection').pushObject(Ember.Object.create(id: 52,title: 't2'))
	equal grid.get('selectedIds').length, 1, "selectedids should have one entry"
	grid.deselectItem('52')
	equal grid.get('selectedIds').length, 0, "selectedids should be empty"


###test 'Validate on Selection', ->
	mockCollection = Ember.Object.create()
	selection = [Ember.Object.create(id: 51,title: 't1'),Ember.Object.create(id: 52,title: 't2')]

	grid = Tent.JqGrid.create
		collection: mockCollection

	didValidate = false
	grid.validate = ->
		didValidate = true

	grid.set('selection', selection)
	ok didValidate, 'Should have validated'
###

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
	          collectionBinding="collection"
	          columnsBinding="columns"
	          multiSelect=true
	          required=true
	          selection=selection
	    }}'
	    collection: collection
		columns: column_data
		selection: []

	appendView()
	gridView = Ember.View.views[view.$('.tent-jqgrid').attr('id')]

	gridView.markErrorCell(52, 2)
	ok gridView.getCell(52,2).hasClass('error'), 'Error class added'
	gridView.unmarkErrorCell(52, 2)
	ok not gridView.getCell(52,2).hasClass('error'), 'Error class removed'


test 'Paging data collection binding', ->
	# Hack to get the date formatting working
	# For some reason the Date prototype is being reset somewhere.

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
	          collectionBinding="collection"
	          columnsBinding="columns"
	          multiSelect=true
	          required=true
	          selection=selection
	          paged=true
              pageSize=6
	    }}'
		collection: collection
		columns: column_data
		selection: []

	collection.set('columnInfo.hidden.title', true)
	collection.set('columnInfo.hidden.id', false)
	collection.set('columnsDescriptor', column_data)

	appendView()
	gridView = Ember.View.views[view.$('.tent-jqgrid').attr('id')]

	# Title Renaming
	equal gridView.columnInfo.titles.title, 'New Title', 'Title read from controller'
	equal gridView.get('colNames')[1], 'New Title', 'Columns Descriptor has been updated with new title'

	gridView.renameColumnHeader('title', 'jabberwocky', gridView.$())
	equal collection.get('columnInfo.titles.title'), 'jabberwocky', 'Changed column title propagated to collection'
	gridView.renameColumnHeader('id', '6655', gridView.$())
	equal collection.get('columnInfo.titles.id'), '6655', 'Changed column id propagated to collection'

	# Column Visibility
	equal gridView.get('columnModel')[1].hidden, true, 'Title should be hidden initially'
	equal gridView.get('columnModel')[0].hidden, false, 'ID should be not hidden initially'

	gridView.getColModel()[2].hidden = false
	gridView.columnsDidChange()
	equal collection.get('columnInfo.hidden.title'), false, 'Title should no longer be hidden'


###
These are tests for client-side grouping
test 'Grouping info bound to collection', ->
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

	collection.set('groupingInfo.columnName', 'title')
	collection.set('groupingInfo.type', 'exact')
	appendView()
	gridView = Ember.View.views[view.$('.tent-jqgrid').attr('id')]

	equal gridView.groupingInfo.columnName, 'title','Collection column name has been reflected in the grid'
	equal gridView.groupingInfo.type, 'exact','Collection id has been reflected in the grid'
	equal gridView.getTableDom().get(0).p.groupingView.groupField, 'title','Grid grouping column name has been set on load'

	Ember.run ->
		# Click id/none
		gridView.$('.group.dropdown-submenu').eq(0).find('li:first a').click()

	equal collection.get('groupingInfo.columnName'), null, 'Changing the grouping column name reflects in the collection: no grouping'
	equal collection.get('groupingInfo.type'), null, 'Changing the grouping type reflects in the collection: no grouping'

	Ember.run ->
		# Click title/exact
		gridView.$('.group.dropdown-submenu').eq(0).find('li:eq(1) a').click()

	equal collection.get('groupingInfo.columnName'), 'id', 'Changing the grouping column name reflects in the collection: no grouping'
	equal collection.get('groupingInfo.type'), 'exact', 'Changing the grouping type reflects in the collection: no grouping'

###

test 'Column Width info bound to collection', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.JqGrid
	          label="Tasks"
	          collectionBinding="collection"
	          columnsBinding="columns"
	          multiSelect=true
	          required=true
	          selection=selection
	          paged=true
              pageSize=6
	    }}'
		collection: collection
		columns: column_data
		selection: []

	debugger;
	appendView()
	gridView = Ember.View.views[view.$('.tent-jqgrid').attr('id')]

	#equal gridView.columnInfo.widths.title, '80','Collection width has been bound in the grid'
	equal gridView.get('columnModel')[0].width, '20', 'Collection width values have been applied to the columns: id'
	equal gridView.get('columnModel')[1].width, '80', 'Collection width values have been applied to the columns: title'

	# Change width and see if it gets copied to the collection
	gridView.getTableDom().get(0).p.colModel[1].width = 40
	gridView.columnsDidChange()

	equal collection.get('columnInfo.widths.id'), 40, 'Changed width on grid'

test 'Column Ordering bound to collection', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.JqGrid
	          label="Tasks"
	          collectionBinding="collection"
	          columnsBinding="columns"
	          multiSelect=true
	          required=true
	          selection=selection
	          paged=true
              pageSize=6
	    }}'
		collection: collection
		columns: column_data
		selection: []

	collection.get('columnInfo.order')[1] = 2
	collection.get('columnInfo.order')[2] = 1
	appendView()
	gridView = Ember.View.views[view.$('.tent-jqgrid').attr('id')]
	
	equal gridView.getTableDom().get(0).p.colModel[1].name, 'title', 'values made it to the grid colmodel'
	equal gridView.getTableDom().get(0).p.colModel[2].name, 'id', 'values made it to the grid colmodel'
	
	# Change ordering
	gridView.getTableDom().remapColumns([0,1,2], true, false)
		# the remap defines the position of the item that was at the current index previously
	equal gridView.getTableDom().get(0).p.colModel[1].name, 'title', 'remap title'
	equal gridView.getTableDom().get(0).p.colModel[2].name, 'id', 'remap id'

	# Change ordering
	gridView.getTableDom().remapColumns([0,2,1], true, false)
	equal gridView.getTableDom().get(0).p.colModel[1].name, 'id', 'remap title to id'
	equal gridView.getTableDom().get(0).p.colModel[2].name, 'title', 'remap id to title'

	# Change ordering
	gridView.getTableDom().remapColumns([0,2,1], true, false)
	equal gridView.getTableDom().get(0).p.colModel[1].name, 'title', 'remap title back'
	equal gridView.getTableDom().get(0).p.colModel[2].name, 'id', 'remap id back'
	 

