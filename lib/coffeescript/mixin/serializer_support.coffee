###*
* @class Tent.SerializerSupport.
*
* The host applications Model may apply serialization transforms on this field type. Where   
* this field is not bound to a model, SerializerSupport can apply those transforms explicitly.
* Set the {@link #serializer} property to and object that implements the {@link #from} and 
* {@link #to} methods.
*
###

Tent.SerializerSupport = Ember.Mixin.create
	serializer: null

	deserialize: (serialized)->
		if @get('serializer')
			@get('serializer').deserialize(serialized)
		else
			serialized
	serialize: (deserialized)->
		if @get('serializer')
			@get('serializer').serialize(deserialized)
		else
			deserialized

	serializedValue: ((key,value)->
		if arguments.length == 1 #getter
			@serialize(@get('value'))
		else					#setter
			@set('value', @deserialize(value))
	).property('value')
