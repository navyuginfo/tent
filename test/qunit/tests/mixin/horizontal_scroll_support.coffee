view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->

teardown = ->

module 'Tent.Grid.HorizontalScrollSupport', setup, teardown

test 'Test that button is displayed: ', ->

	Tent.HContainerView = Ember.View.extend Tent.Grid.HorizontalScrollSupport,
		elementId: 'hcontainer'
		template: Ember.Handlebars.compile '<div class="header-buttons"></div>'
		didInsertElement: ->
			@addNavigationBar()
		buildGrid: ->
		gridDataDidChange: ->
		updateGrid: ->
		adjustHeight: ->
		getTableDom: ->
			{
				get: ->
					{p: {forceFit:true, shrinkToFit: true}}
			}

	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.HContainerView horizontalScrolling=false}}'
	
	appendView()
	
	hContainer = Ember.View.views['hcontainer']
	#dump(hContainer.$().html())
	button = view.$('.horizontal-scroll-button')
	ok button.length, 1, 'Anchor should be displayed'
	equal hContainer.get('horizontalScrolling'), false, 'start with scrolling false'
	equal button.hasClass('active'), false, 'not active'
	equal button.attr('title'), 'Horizontal Scroll', 'Check that the title is set'

	
	Ember.run ->
		button.click()

	equal hContainer.get('horizontalScrolling'), true, 'scrolling is now true'
	equal button.hasClass('active'), true, 'activated'

	Ember.run ->
		button.click()

	equal hContainer.get('horizontalScrolling'), false, 'scrolling is false again'
	equal button.hasClass('active'), false, 'not active again'

###test 'calculateColumnWidth', ->
	Grid = Ember.Object.extend Tent.Grid.Adapters, Tent.Grid.HorizontalScrollSupport,
		horizontalScrolling: false
	grid = Grid.create()

	equal grid.calculateColumnWidth({title:'New Column Title'}), 80, 'no column width'
	equal grid.calculateColumnWidth({title:'New Column Title', width: '120'}), 120, 'column width'

	grid.set('horizontalScrolling', true)
	equal grid.calculateColumnWidth({title:'New Column Title'}), 160, 'Width based on title length'
	equal grid.calculateColumnWidth({title: null}), 80, 'No title provided'

	grid.set('fixedColumnWidth', 88)
	equal grid.calculateColumnWidth(), 88, 'fixed column width'
###

