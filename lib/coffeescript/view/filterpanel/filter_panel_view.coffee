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
		filterableCols = @get('collection.columnsDescriptor').filter((column)=>
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
	validations: Ember.A()

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
		@get('controller').destroy() if @get('controller')?
		@get('validations').clear()

	togglePin: ->
		@toggleProperty('isPinned')
		Ember.run.next =>
			$.publish("/window/resize")

	showFilterDidChange: (->
		@set('isPinned', false)
		$.publish("/window/resize")
	).observes('showFilter')

	applyFilter: ->
		@set('showFilter', false) if not @get('isPinned')
		@get('controller').applyFilter()

	fieldValidationStateChanged: (fieldId, isValid, operatorsIsValid)->
		allValid = isValid and operatorsIsValid
		field = @get('validations').findProperty('id', fieldId)
		if field?
			field.set('value', allValid)
		else
			@get('validations').pushObject(Ember.Object.create({id:fieldId, value:allValid}))

	areAnyFieldsInvalid: (->
		invalids = @get('validations').findProperty('value', false)
		invalids?
	).property('validations.@each', 'validations.@each.value')
	


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
	classNameBindings: ['controller.locked', 'duplicateField']
	parentControllerBinding: 'parentView.parentView.controller'
	collectionBinding: 'parentView.parentView.collection'
	content: null
	usageContext: null
	isValid: true
	operatorsIsValid: true

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
		selectedField = @get('controller.content.field')
		if selectedField?
			columns = @get('filterableColumns')
			selectedColumn = columns.filter((item)->
				item.name == selectedField
			)
			@set('controller.selectedColumn', selectedColumn[0]) if selectedColumn.length == 1

	filterableColumns: (->
		filterableCols = @get('parentController.filterableColumns')
		return filterableCols
	).property('parentController.filterableColumns')

	willDestroyElement: ->
		# Ensure that the error panel gets cleared of any errors for this field.
		@set('isValid', true)
		@set('operatorsIsValid', true)
		@get('controller').destroy() if @get('controller')?

	typeIsSelected: (->
		@get('content.field')?
	).property('content.field')

	duplicateField: (->
		if @get('content.field')?
			matches = @get('collection.selectedFilter.values').filter((item)=>
				item.field == @get('content.field')
			)
			if matches.length > 1
				setTimeout(=> 
					@set('content.field', null)
				, 4000)
				return true
		false
	).property('content.field')

	showLockIcon: (->
		# Show icon if not in view mode, or if in view mode but also locked
		@get('controller.locked') or (@get('usageContext') != 'view' and @get('usageContext')?)
	).property('usageContext', 'controller.locked')

	lockIsSelected: (->
		@get('controller.locked') and @get('controller.lockIsEnabled')
	).property('controller.locked', 'controller.lockIsEnabled')

	showTrashIcon: (->
		not (@get('usageContext') == 'view' and @get('controller.locked'))
	).property('usageContext')

	isValidDidChange: (->
		@get('parentView.parentView').fieldValidationStateChanged(@get('elementId'), @get('isValid'), @get('operatorsIsValid'))
	).observes('isValid', 'operatorsIsValid')


Tent.FilterFieldControlView = Ember.ContainerView.extend
	content: null
	column: null
	isDisabled: false
	isValid: true
	operatorsIsValid: true

	init: ->
		@_super()
		@populateContainer()

	columnDidChange: (->
		@populateContainer()
	).observes('column')

	willDestroyElement: ->
		if not this.isDestroyed
			@resetFieldView()

	resetFieldView: ->
		if @get('fieldView')?
			Ember.run =>
				if not @get('fieldView').isDestroyed
					@get('fieldView').flushValidationErrors()
					@get('fieldView').destroy()
				@set('parentView.content.op', "")
				@set('parentView.content.data', "")
				@set('isValid', true)

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
							isValidBinding: "parentView.isValid"
							operatorsIsValidBinding: 'parentView.operatorsIsValid'
							required: true

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
							isValidBinding: "parentView.isValid"
							operatorsIsValidBinding: 'parentView.operatorsIsValid'
							required: true
				else
					fieldView = Tent.TextField.create
						label: Tent.I18n.loc(@get('column.title'))
						isFilter: true 
						valueBinding: "parentView.content.data"
						filterOpBinding: "parentView.content.op"
						field: @get('column.name')
						classNames: ["no-label"]
						disabledBinding: "parentView.isDisabled"
						isValidBinding: "parentView.isValid"
						operatorsIsValidBinding: 'parentView.operatorsIsValid'
						required: true

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
					disabledBinding: "parentView.isDisabled"
					isValidBinding: "parentView.isValid"
					operatorsIsValidBinding: 'parentView.operatorsIsValid'
					required: true
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
					disabledBinding: "parentView.isDisabled"
					isValidBinding: "parentView.isValid"
					operatorsIsValidBinding: 'parentView.operatorsIsValid'
					required: true

			when "boolean"
				fieldView = Tent.Checkbox.create
					label: Tent.I18n.loc(@get('column.title')) 
					isFilter: true 
					checkedBinding: "parentView.content.data" 
					filterOpBinding: "parentView.content.op"
					field: @get('column.name')
					classNames: ["no-label"]
					disabledBinding: "parentView.isDisabled"
					isValidBinding: "parentView.isValid"
					operatorsIsValidBinding: 'parentView.operatorsIsValid'
					required: true

		if fieldView?
			@set('fieldView', fieldView)
			@get('childViews').pushObject(fieldView)


