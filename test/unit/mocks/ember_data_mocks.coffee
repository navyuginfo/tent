
Tent.Mock = Tent.Mock || Ember.Namespace.create()

Tent.Mock.DSModel = Ember.Object.extend
	toJSON: () ->
		return @content

Tent.Mock.RecordArray = Ember.Object.extend
	toArray: ->
		return @content
	removeArrayObserver: ->
		console.log 'removeArrayObserver'
	addArrayObserver: ->
		console.log 'addArrayObserver'
 