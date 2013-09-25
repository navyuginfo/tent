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
		filterableCols = @get('collection.columnsDescriptor').filter((column)->
			column.filterable != false
		)
		# Clone the columns so that they don't get changed by the filtering.
		filterableCols.map((item) ->
        	Ember.copy(item,true)
      	)
	).property('collection.columnsDescriptor')


Tent.FilterPanelView = Ember.View.extend
	templateName: 'filterpanel/filter_panel_view'
	collection: null
	isPinned: false
	showFilter: false
	usageContext: null

	init: ->
		@_super()
		@set('controller', Tent.FilterPanelController.create(
			collection: @get('collection')
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
	lockedBinding: 'content.locked'
	usageContext: null

	deleteField: ->
		@get('parentController').deleteFilterField(@get('content'))

	toggleLock: ->
		if @get('lockIsEnabled')
			@toggleProperty('locked')

	lockIsEnabled: (->
		@get('usageContext')? and @get('usageContext') != 'view'
	).property('usageContext')

	# field should be disabled if it is locked and in view mode
	isDisabled: (->
		@get('locked') and (not @get('usageContext')? or @get('usageContext') == 'view')
	).property('locked','usageContext')

Tent.FilterFieldView = Ember.View.extend
	templateName: 'filterpanel/filter_field_view'
	classNames: ['filter-field']
	classNameBindings: ['controller.locked']
	parentControllerBinding: 'parentView.controller'
	collectionBinding: 'parentView.collection'
	content: null
	usageContext: null

	init: ->
		@_super()
		@set('controller', @createController())
		@initializeSelection()

	createController: ->
		Tent.FilterFieldController.create
			content: @get('content')
			parentController: @get('parentController')
			collection: @get('collection')
			usageContext: @get('usageContext')

	initializeSelection: ->
		selectedField = @get('content.field')
		if selectedField?
			columns = @get('parentController.filterableColumns')
			selectedColumn = columns.filter((item)->
				item.name == selectedField
			)
			@set('controller.selectedColumn', selectedColumn[0]) if selectedColumn.length == 1

	willDestroyElement: ->
		delete @get('controller')

	typeIsSelected: (->
		@get('content.field')?
	).property('content.field')

	showLockIcon: (->
		# Show icon if not in view mode, or if in view mode but also locked
		@get('controller.locked') or (@get('usageContext') != 'view' and @get('usageContext')?)
	).property('usageContext', 'controller.locked')

	lockIsSelected: (->
		@get('controller.locked') and @get('controller.lockIsEnabled')
	).property('controller.locked', 'controller.lockIsEnabled')

	showTrashIcon: (->
		@get('usageContext') != 'view' and @get('usageContext')?
	).property('usageContext')


Tent.FilterFieldControlView = Ember.ContainerView.extend
	classNames: ['filter-field-control']
	content: null
	column: null
	isDisabled: false

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
							disabledBinding: "parentView.isDisabled"

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
							disabledBinding: "parentView.isDisabled"

				else
					fieldView = Tent.TextField.create
						label: Tent.I18n.loc(@get('column.title'))
						isFilter: true 
						valueBinding: "parentView.content.data"
						filterOpBinding: "parentView.content.op"
						field: @get('column.name')
						classNames: ["no-label"]
						disabledBinding: "parentView.isDisabled"

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
					disabledBinding: "parentView.isDisabled"
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
					disabledBinding: "parentView.isDisabled"

			when "boolean"
				fieldView = Tent.Checkbox.create
					label: Tent.I18n.loc(@get('column.title')) 
					isFilter: true 
					checkedBinding: "content.data" 
					filterOpBinding: "content.op"
					field: @get('column.name')
					classNames: ["no-label"]
					disabledBinding: "parentView.isDisabled"

		if fieldView?
			@set('fieldView', fieldView)
			@get('childViews').pushObject(fieldView)



