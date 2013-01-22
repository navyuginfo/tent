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

module 'Tent.Grid.ColumnMenu', setup, teardown

test 'no column menus', ->
	column_data = [
		{id: "id", name: "id", title: "_hID", field: "id", sortable: false, groupable: false, renamable: false},
		{id: "title", name: "title", title: "_hTitle", field: "title", sortable: false, groupable: false, renamable: false}
	]

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

	equal gridView.$('.column-dropdown').length, 0, 'Should be no dropdown'

test 'rename column', ->
	column_data = [
		{id: "id", name: "id", title: "_hID", field: "id", sortable: false, groupable: false, renamable: false},
		{id: "title", name: "title", title: "_hTitle", field: "title", sortable: false, groupable: false}
	]

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

	equal gridView.$('.column-dropdown .rename').length, 1, 'There should be a dropdown'
	equal gridView.$('.column-dropdown').attr('data-orig-title'), '_hTitle', 'orig title'
	equal gridView.$('.column-dropdown').attr('data-column'), 'title', 'data-column'
	equal gridView.$('.column-dropdown .rename input').val(), '_hTitle', 'Title should be displayed'

	inputControl = gridView.$('.column-dropdown .rename input')
	inputControl.val('newtitle')

	e = $.Event('keyup')
	e.keyCode = 13
	inputControl.trigger(e)
	
	equal gridView.$('.column-dropdown').attr('data-last-title'), 'newtitle', 'last title has changed'
	equal gridView.get('columns')[1].title, 'newtitle', 'Column should display new title'

	inputControl.val('newtitlexxx')
	e = $.Event('keyup')
	e.keyCode = 27
	inputControl.trigger(e)
	equal gridView.$('.column-dropdown').attr('data-last-title'), 'newtitle', 'last title has not changed'
	equal gridView.get('columns')[1].title, 'newtitle', 'Column should display orig title'
	equal inputControl.val(), 'newtitle', 'input control should revert back to stored value'

test 'column grouping', ->
	column_data = [
		{id: "id", name: "id", title: "_hID", field: "id", sortable: true, groupable: false, renamable: false},
		{id: "title", name: "title", title: "_hTitle", field: "title", sortable: true, groupable: true, renamable: false}
	]

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

	equal gridView.$('.column-dropdown .group').length, 1, 'There should be a dropdown'







