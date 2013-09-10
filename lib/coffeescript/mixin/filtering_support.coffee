require './constants'

###*
* @class Tent.FilteringSupport 
* Allows widgets to participate in filter panels, and provides them with a range of 
* comparison operators
###
Tent.FilteringSupport = Ember.Mixin.create
	isFilter: false
	filterOp: null

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

	# Ensure that the correct operator is selected in the operators dropdown
	filterSelection: (->
		filterOp = @get('filterOp')
		selectedOperators = @get('operators').filter((item)->
			item.get('operator') == filterOp
		)
		selectedOperators[0] if selectedOperators.length == 1
	).property('filterOp')
	
	# Check to see if the operator requires a range presentation
	isRangeOperator: (->
		currentFilterOperator = @get('filterOp')
		currentFilterOperator == 'range'
	).property('filterOp')

	observeFilterOp: (->
		@set('selectedOperator', @get('operators').findProperty('operator', op)) if (op = @get('filterOp'))? and !op.isBlank() and @get('operators')?
	).observes('filterOp')





