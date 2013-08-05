require '../../template/filterpanel/filter_panel_view'
require '../../template/filterpanel/filter_field_view'

Tent.FilterPanelController = Ember.ArrayController.extend
	content: Ember.A()
	addFilterField: ->
		@get('content').pushObject({'label': new Date()})

	removeFilterField: (fieldContent)->
		@get('content').removeAt(@get('content').indexOf(fieldContent))

	# Called from the view
	deleteFilterField: (event)->
		@removeFilterField(event.context)


Tent.FilterPanelView = Ember.View.extend
	templateName: 'filterpanel/filter_panel_view'
	init: ->
		@_super()
		@set('controller', Tent.FilterPanelController.create())


Tent.FilterFieldController = Ember.ObjectController.extend
	deleteField: ->
		console.log 'deleting field'
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
		
	typeIsSelected: (->
		@get('content.type')?
	).property('content.type')




Tent.FilterFieldControlView = Ember.ContainerView.extend
	classNames: ['form-horizontal']
	#collection: null
	#collectionFilterBinding: 'parentView'

	init: ->
		@_super()
		#@set('collectionFilter', @get('parentView'))
		@populateContainer()

	populateContainer: ()->
		fieldView = null
		switch @get('type')
			when "string"
				fieldView = Tent.TextField.create
					label: Tent.I18n.loc(column.title) 
					isFilter: true 
					valueBinding: "parentView.collectionFilter.currentFilter.values." + column.name + ".data" 
					filterOpBinding: "parentView.collectionFilter.currentFilter.values." + column.name + ".op" 
					filterBinding: "parentView.collectionFilter.currentFilter"
					field: column.name
			when "date", "utcdate"
				fieldView = Tent.DateRangeField.create
					label: Tent.I18n.loc(column.title) 
					isFilter: true 
					valueBinding: "parentView.collectionFilter.currentFilter.values." + column.name + ".data" 
					closeOnSelect:true
					arrows:true
					filterOpBinding: "parentView.collectionFilter.currentFilter.values." + column.name + ".op" 
					dateFormat: "yy-mm-dd"
					#filterBinding: "parentView.grid.currentFilter"
					#field: column.name
			when "number", "amount"
				fieldView = Tent.NumericTextField.create
					label: Tent.I18n.loc(column.title) 
					isFilter: true 
					serializer: Tent.Formatting.number.serializer
					rangeValueBinding: "parentView.collectionFilter.currentFilter.values." + column.name + ".data" 
					filterOpBinding: "parentView.collectionFilter.currentFilter.values." + column.name + ".op" 
					filterBinding: "parentView.collectionFilter.currentFilter"
					field: column.name
			when "boolean"
				fieldView = Tent.Checkbox.create
					label: Tent.I18n.loc(column.title) 
					isFilter: true 
					checkedBinding: "parentView.collectionFilter.currentFilter.values." + column.name + ".data" 
					filterOpBinding: "parentView.collectionFilter.currentFilter.values." + column.name + ".op" 
					filterBinding: "parentView.collectionFilter.currentFilter"
					field: column.name
		@get('childViews').pushObject(fieldView) if fieldView?

