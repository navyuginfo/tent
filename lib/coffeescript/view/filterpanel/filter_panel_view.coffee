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


Tent.FilterPanelView = Ember.View.extend
	templateName: 'filterpanel/filter_panel_view'
	collection: null
	init: ->
		@_super()
		@set('controller', Tent.FilterPanelController.create(
			collection: @get('collection')
		))

	willDestroyElement: ->
		delete @get('controller')


Tent.FilterFieldController = Ember.ObjectController.extend
	selectedColumn: null
	content: null

	deleteField: ->
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

	willDestroyElement: ->
		delete @get('controller')

	contentDidChange: (->
		console.log @get('content.field')
	).property('content')
		
	typeIsSelected: (->
		@get('content.field')?
	).property('content.field')


Tent.FilterFieldControlView = Ember.ContainerView.extend
	classNames: ['filter-field-control']
	content: null
	classNames: ['form-horizontal']
	column: null

	init: ->
		@_super()
		@populateContainer()

	columnDidChange: (->
		@populateContainer()
	).observes('column')

	resetFieldView: ->
		if @get('fieldView')?
			@get('childViews').removeObject(@get('fieldView'))
			@set('fieldView', null)
			@set('parentView.content.op', null)
			@set('parentView.content.data', null)

	populateContainer: ()->
		fieldView = null
		switch @get('column.type')
			when "string"
				if @get('column.edittype') == 'select'
					# This is an enumeration
					# Enumerations can be specified in the column meta in a format such as this:
					# edittype('select').editoptions({value: [{key: 'Eligible', value: 'eligible'}, {key: 'InEligible', value: 'ineligible'}]}
					fieldView = Tent.Select.create
						label: Tent.I18n.loc(@get('column.title'))
						isFilter: true 
						list: @get('column.editoptions.value')
						optionLabelPath: 'content.key'
						optionValuePath: 'content.value'
						valueBinding: "parentView.content.data"
						filterOpBinding: "parentView.content.op"
						field: @get('column.name')
						classNames: ["no-label"]
				else
					fieldView = Tent.TextField.create
						label: Tent.I18n.loc(@get('column.title'))
						isFilter: true 
						valueBinding: "parentView.content.data"
						filterOpBinding: "parentView.content.op"
						field: @get('column.name')
						classNames: ["no-label"]

			when "date", "utcdate"
				fieldView = Tent.DateRangeField.create
					label: Tent.I18n.loc(@get('column.title')) 
					isFilter: true 
					valueBinding: "content.data"
					filterOpBinding: "content.op"
					closeOnSelect:true
					arrows:true
					dateFormat: "yy-mm-dd"
					classNames: ["no-label"]
					#field: column.name

			when "number", "amount"
				fieldView = Tent.NumericTextField.create
					label: Tent.I18n.loc(@get('column.title')) 
					isFilter: true 
					serializer: Tent.Formatting.number.serializer
					rangeValueBinding: "content.data"
					filterOpBinding: "content.op"
					field: @get('column.name')
					classNames: ["no-label"]

			when "boolean"
				fieldView = Tent.Checkbox.create
					label: Tent.I18n.loc(@get('column.title')) 
					isFilter: true 
					checkedBinding: "content.data" 
					filterOpBinding: "content.op"
					field: @get('column.name')
					classNames: ["no-label"]

		if fieldView?
			@set('fieldView', fieldView)
			@get('childViews').pushObject(fieldView)


