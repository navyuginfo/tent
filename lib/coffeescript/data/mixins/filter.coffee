Tent.Data.Filter = Ember.Mixin.create
	init: ->
		@_super()
		@REQUEST_TYPE.FILTER = 'filtering'

	selectedFilterDidChange: (->
		# update the columnFilters
		console.log('Changed selected filter')
		if @get('selectedFilter')?
			columnFilters = @get('columnFilters')

			for filter in @get('selectedFilter').values
				columnFilters[filter.field] = filter.value
			@set('columnFilters', columnFilters)
	).observes('selectedFilterxxx')

	filter: (seletedFilter) ->
		if seletedFilter?
			@set('seletedFilter', seletedFilter)
		@update(@REQUEST_TYPE.FILTER)

	# Called by UI button to trigger filtering
	filterTrigger: ->
		@filter()

	getFilteringInfo: ->
		@get('selectedFilter')
