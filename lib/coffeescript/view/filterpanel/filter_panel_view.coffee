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
	isPinned: false
	showFilter: false

	init: ->
		@_super()
		@set('controller', Tent.FilterPanelController.create(
			collectionBinding: 'collection'
		))

	collectionDidChange: (->
		# collection may not be available when init() is called
		@get('controller').set('collection', @get('collection'))
	).observes('collection', 'collection.isLoaded')

	willDestroyElement: ->
		delete @get('controller')

	togglePin: ->
		@toggleProperty('isPinned')
		Ember.run.next =>
			$.publish("/window/resize")

	showFilterDidChange: (->
		@set('isPinned', false)
		$.publish("/window/resize")
	).observes('showFilter')


Tent.FilterFieldController = Ember.ObjectController.extend
	selectedColumn: null
	content: null

	deleteField: ->
		@get('parentController').deleteFilterField(@get('content'))


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
	).property('content.data')
		
	typeIsSelected: (->
		@get('content.field')?
	).property('content.field')


Tent.FilterFieldControlView = Ember.ContainerView.extend
	classNames: ['filter-field-control']
	content: null
	 
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
		@resetFieldView()
		

		switch @get('column.type')
			when "string"
				if @get('column.edittype') == 'select'
					# This is an enumeration
					# Enumerations can be specified in the column meta in a format such as this:
					# edittype('select').editoptions({value: [{key: 'Eligible', value: 'eligible'}, {key: 'InEligible', value: 'ineligible'}]}
					if @get('column.editoptions.value')?
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
					if @get('column.editoptions.collection')
						coll = eval(@get('column.editoptions.collection.name')).fetchCollection()
						fieldView = Tent.Select.create
							label: Tent.I18n.loc(@get('column.title'))
							isFilter: true 
							list: coll
							optionLabelPath: @get('column.editoptions.collection.label')
							optionValuePath: @get('column.editoptions.collection.value')
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
					valueBinding: "parentView.content.data"
					filterOpBinding: "parentView.content.op"
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
					rangeValueBinding: "parentView.content.data"
					filterOpBinding: "parentView.content.op"
					field: @get('column.name')
					classNames: ["no-label"]

			when "boolean"
				fieldView = Tent.Checkbox.create
					label: Tent.I18n.loc(@get('column.title')) 
					isFilter: true 
					checkedBinding: "parentView.content.data" 
					filterOpBinding: "parentView.content.op"
					field: @get('column.name')
					classNames: ["no-label"]

		if fieldView?
			@set('fieldView', fieldView)
			@get('childViews').pushObject(fieldView)

