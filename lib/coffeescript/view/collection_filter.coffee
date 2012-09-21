require '../template/collection_filter'

Tent.CollectionFilter = Ember.View.extend
	collection: null
	filterTemplate: null
	templateName: 'collection_filter'
	classNames: ['tent-filter']
	availableFiltersBinding: 'collection.availableFilters'
	#selectedFilterBinding: 'collection.selectedFilter'

	init: ->
		@_super()
		@set('currentFilter', {
			name: "temporary"
			label: "temporary"
			description: "temporary"
			values: {id: "51",title: ""}
		})
	
	filter: ->
		@get('collection').filter(@get('currentFilter'))

	selectedFilterDidChange: (->
		if @get('selectedFilter')?
			#@set('currentFilter.values', $.extend({}, @get('selectedFilter.values')))
			@set('currentFilter', Ember.copy(@get('selectedFilter'), true))

	).observes('selectedFilter')

	saveFilter: ->
		@get('collection').saveFilter(@get('currentFilter'))


Tent.FilterDefinition = Ember.Object.extend
	name: "temporary"
	label: "temporary"
	description: "temporary"
	values: {id: "51",title: ""}
