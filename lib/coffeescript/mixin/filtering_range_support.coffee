require './constants'

Tent.FilteringRangeSupport = Ember.Mixin.create
  # Operators for use within a grid filter
  operators: [
    Ember.Object.create({label: "tent.filter.equal", operator: Tent.Constants.get('OPERATOR_EQUALS')}),
    Ember.Object.create({label: "tent.filter.nEqual", operator: Tent.Constants.get('OPERATOR_NOT_EQUALS')})
    Ember.Object.create({label: "tent.filter.lThan", operator: Tent.Constants.get('OPERATOR_LESS_THAN')})
    Ember.Object.create({label: "tent.filter.lThanEq", operator: Tent.Constants.get('OPERATOR_LESS_THAN_EQUALS')})
    Ember.Object.create({label: "tent.filter.gThan", operator: Tent.Constants.get('OPERATOR_GREATER_THAN')})
    Ember.Object.create({label: "tent.filter.gThanEq", operator: Tent.Constants.get('OPERATOR_GREATER_THAN_EQUALS')})
    Ember.Object.create({label: "tent.filter.like", operator: Tent.Constants.get('OPERATOR_LIKE')})
    Ember.Object.create({label: "tent.filter.contains", operator: Tent.Constants.get('OPERATOR_CONTAINS')})
    Ember.Object.create({label: "tent.filter.range", operator: Tent.Constants.get('OPERATOR_RANGE')})
  ]

  ###*
  * @property {Array} rangeValue The value containing the range array if a range operator is selected while filtering
  * If no range operator is selected, this property will just return the normal value.
  *
  ###
  rangeValue: (->
    if @get('isRangeOperator') and @get('value2')?
      value = @get('value')?.toString().replace(/,/, '')
      value2 = @get('value2')?.toString().replace(/,/, '')
      "#{value},#{value2}"
    else
      @get('value')
  ).property('value', 'value2', 'isRangeOperator')
