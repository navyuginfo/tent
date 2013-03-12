setup = ->
teardown = ->

module 'Tent.SerializerSupport', setup, teardown

test 'No Serializer', ->
	clazz = Ember.Object.extend Tent.SerializerSupport,
		init: ->
	obj = clazz.create()
	obj.set('value', 123)
	equal obj.get('serializedValue'), 123, 'No serializer'

	obj.set('serializedValue', 321)
	equal obj.get('value'), 321, 'No serializer - value'


test 'With Serializer', ->
	clazz = Ember.Object.extend Tent.SerializerSupport,
		init: ->
	serializer = 
		serialize: (value) ->
			value * 2
		deserialize: (value) ->
			value / 2
	
	obj = clazz.create()
	obj.set('serializer', serializer)

	obj.set('value', 111)
	equal obj.get('serializedValue'), 222, 'With serializer'

	obj.set('serializedValue', 888)
	equal obj.get('value'), 444, 'With serializer - value'
