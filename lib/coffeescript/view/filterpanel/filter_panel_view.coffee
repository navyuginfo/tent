require '../../template/filterpanel/filter_panel_view'
require '../../template/filterpanel/filter_field_view'

Tent.FilterPanelController = Ember.ArrayController.extend
	contentBinding: 'collection.selectedFilter.values'
	collection: null

	addFilterField: ->
		@get('collection').createBlankFilterFieldValue()

	removeFilterField: (fieldContent)->
		@get('collection').removeFilterFieldValue(fieldContent)

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

	contentDidChange: (->
		console.log @get('content.field')
	).property('content')


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
	).property('content')
		
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

	populateContainer: ()->
		fieldView = null
		switch @get('column.type')
			when "string"
				fieldView = Tent.TextField.create
					label: Tent.I18n.loc(@get('column.title'))
					isFilter: true 
					valueBinding: "content.data"
					filterOpBinding: "content.op"
					field: @get('column.name')
			when "date", "utcdate"
				fieldView = Tent.DateRangeField.create
					label: Tent.I18n.loc(@get('column.title')) 
					isFilter: true 
					valueBinding: "content.data"
					filterOpBinding: "content.op"
					closeOnSelect:true
					arrows:true
					dateFormat: "yy-mm-dd"
					#field: column.name
			when "number", "amount"
				fieldView = Tent.NumericTextField.create
					label: Tent.I18n.loc(@get('column.title')) 
					isFilter: true 
					serializer: Tent.Formatting.number.serializer
					rangeValueBinding: "content.data"
					filterOpBinding: "content.op"
					field: @get('column.name')
			when "boolean"
				fieldView = Tent.Checkbox.create
					label: Tent.I18n.loc(@get('column.title')) 
					isFilter: true 
					checkedBinding: "content.data" 
					filterOpBinding: "content.op"
					field: @get('column.name')
		@get('childViews').pushObject(fieldView) if fieldView?

