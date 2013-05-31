require './constants'

###*
* @class Tent.FilteringSupport 
* Allows widgets to participate in filter panels, and provides them with a range of 
* comparison operators
###
Tent.FilteringSupport = Ember.Mixin.create
	isFilter: false
	operators: [
		Ember.Object.create({label: "tent.filter.beginsWith", operator: Tent.Constants.get('OPERATOR_BEGINS_WITH')}),
		Ember.Object.create({label: "tent.filter.contains", operator: Tent.Constants.get('OPERATOR_CONTAINS')}),
		Ember.Object.create({label: "tent.filter.equal", operator: Tent.Constants.get('OPERATOR_EQUALS')}),
		Ember.Object.create({label: "tent.filter.nEqual", operator: Tent.Constants.get('OPERATOR_NOT_EQUALS')})
		Ember.Object.create({label: "tent.filter.like", operator: Tent.Constants.get('OPERATOR_LIKE')})
	]

	init: ->
		@_super(arguments)

	didInsertElement: ->
		@_super()
	
	# Check to see if the operator requires a range presentation
	isRangeOperator: (->
		currentFilterOperator = @get('filterOp')
		currentFilterOperator == 'range'
	).property('filterOp')





