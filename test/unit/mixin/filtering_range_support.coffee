setup = ->
teardown = ->

module 'Tent.FilteringRangeSupport', setup, teardown

test 'No Range', ->
	clazz = Ember.Object.extend Tent.FilteringRangeSupport,
		isRangeOperator: false
	obj = clazz.create()

	obj.set('value', 123)
	equal obj.get('rangeValue'), 123, 'Setting original value'

	obj.set('rangeValue', 345)
	equal obj.get('value'), 345, 'Getting original value'	

test 'With range', ->
	clazz = Ember.Object.extend Tent.FilteringRangeSupport,
		isRangeOperator: true
	obj = clazz.create()

	obj.set('value', 123)
	equal obj.get('rangeValue'), 123, 'Setting original value'
	obj.set('rangeValue', 345)
	equal obj.get('value'), 345, 'Getting original value'	

	obj.set('rangeValue', ' 123 , 456 ')
	equal obj.get('value'), 123, 'value part should be 123'
	equal obj.get('value2'), 456, 'value2 part should be 456'
	
	obj.set('value', 321)
	equal obj.get('rangeValue'), '321,456', 'set value only'
	obj.set('value2', 654)
	equal obj.get('rangeValue'), '321,654', 'set value2 only'

test 'Serializer', ->
	clazz = Ember.Object.extend Tent.FilteringRangeSupport,
		isRangeOperator: true

	serializer = 
		serialize: (value) ->
			value * 2
		deserialize: (value) ->
			value / 2

	obj = clazz.create()
	obj.set('serializer', serializer)

	obj.set('value', 111)
	equal obj.get('rangeValue'), 222, 'Setting original value'
	obj.set('rangeValue', 888)
	equal obj.get('value'), 444, 'Getting original value'	

	obj.set('rangeValue', ' 444 , 888 ')
	equal obj.get('value'), 222, 'value part should be 222'
	equal obj.get('value2'), 444, 'value2 part should be 444'
	
	obj.set('value', 333)
	equal obj.get('rangeValue'), '666,888', 'set value only'
	obj.set('value2', 500)
	equal obj.get('rangeValue'), '666,1000', 'set value2 only'






	