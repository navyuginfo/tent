###*
* @class Tent.FilteringSupport 
* Allows widgets to participate in filter panels, and provides them with a range of 
* comparison operators
###
Tent.FilteringSupport = Ember.Mixin.create
	isFilter: false
	operators: [
		Ember.Object.create({label: "tent.filter.beginsWith", operator: "begin"}),
		Ember.Object.create({label: "tent.filter.contains", operator: "contain"}),
		Ember.Object.create({label: "tent.filter.equal", operator: "equal"}),
		Ember.Object.create({label: "tent.filter.nEqual", operator: "nequal"})
	]

	init: ->
		@_super(arguments)

	didInsertElement: ->
		@_super()
		if @get('filter')
			@get('filter.values')[@get('id')] = {}

	filterDidChange: (->
		console.log 'filter changed'
	).observes('filter')
	
	# Check to see if the operator requires a range presentation
	isRangeOperator: (->
		currentFilterOperator = @get('filterOp')
		currentFilterOperator == 'range'
	).property('filterOp')





