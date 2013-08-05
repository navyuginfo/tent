require '../../template/filterpanel/filter_panel_view'
require '../../template/filterpanel/filter_field_view'

Tent.FilterPanelController = Ember.ArrayController.extend
	contentBinding: 'collection.selectedFilter.values'
	collection: null

	addFilterField: ->
		@get('collection').createBlankFilterFieldValue()

	removeFilterField: (fieldContent)->
		@get('collection').removeFilterFieldValue(fieldContent)

	applyFilter: ->
		@get('collection').doFilter()

	# Called from the view
	deleteFilterField: (event)->
		@removeFilterField(event.context)

	filterableColumns: (->
		@get('collection.columnsDescriptor').filter((column)->
			column.filterable != false
		)
	).property('collection.columnsDescriptor')


Tent.FilterPanelView = Ember.View.extend
	templateName: 'filterpanel/filter_panel_view'

	collection: null
	init: ->
		@_super()
		@set('controller', Tent.FilterPanelController.create(
			collection: @get('collection')
		))


Tent.FilterFieldController = Ember.ObjectController.extend
	selectedColumn: null
	content: null

	deleteField: ->
		console.log 'deleting field'
		@get('parentController').deleteFilterField(@get('content'))

	filterableColumnsBinding: 'parentController.filterableColumns'


Tent.FilterFieldView = Ember.View.extend
	templateName: 'filterpanel/filter_field_view'
	parentControllerBinding: 'parentView.controller'
	collectionBinding: 'parentView.collection'
	init: ->
		@_super()
		@set('controller', Tent.FilterFieldController.create
			content: @get('content')
			parentController: @get('parentController')
			collection: @get('collection')
		)

	contentDidChange: (->
		console.log @get('content.field')
	).property('content.data')
		
	typeIsSelected: (->
		@get('content.field')?
	).property('content.field')


Tent.FilterFieldControlView = Ember.ContainerView.extend
	content: null
	classNames: ['form-horizontal']
	column: null

	init: ->
		@_super()
		@populateContainer()

	columnDidChange: (->
		@populateContainer()
	).observes('column')

	populateContainer: ()->
		@get('childViews').removeObject(@get('fieldView')) if @get('fieldView')?
		switch @get('column.type')
			when "string"
				fieldView = Tent.TextField.create
					label: Tent.I18n.loc(@get('column.title'))
					isFilter: true 
					valueBinding: "parentView.content.data"
					filterOpBinding: "parentView.content.op"
					field: @get('column.name')
			when "date", "utcdate"
				fieldView = Tent.DateRangeField.create
					label: Tent.I18n.loc(@get('column.title')) 
					isFilter: true 
					valueBinding: "parentView.content.data"
					filterOpBinding: "parentView.content.op"
					closeOnSelect:true
					arrows:true
					dateFormat: "yy-mm-dd"
					#field: column.name
			when "number", "amount"
				fieldView = Tent.NumericTextField.create
					label: Tent.I18n.loc(@get('column.title')) 
					isFilter: true 
					serializer: Tent.Formatting.number.serializer
					rangeValueBinding: "parentView.content.data"
					filterOpBinding: "parentView.content.op"
					field: @get('column.name')
			when "boolean"
				fieldView = Tent.Checkbox.create
					label: Tent.I18n.loc(@get('column.title')) 
					isFilter: true 
					checkedBinding: "parentView.content.data" 
					filterOpBinding: "parentView.content.op"
					field: @get('column.name')
		if fieldView?
			@set('fieldView', fieldView)
			@get('childViews').pushObject(fieldView)

