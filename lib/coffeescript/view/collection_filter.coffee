require '../template/collection_filter'

Tent.CollectionFilter = Ember.View.extend
	collection: null
	filterTemplate: null
	templateName: 'collection_filter'
	classNames: ['tent-filter']
	availableFiltersBinding: 'collection.availableFilters'
	selectedFilterBinding: 'collection.selectedFilter'
	
