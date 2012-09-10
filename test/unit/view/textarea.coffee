view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->
teardown = ->

module 'Tent.Textarea', setup, teardown

test 'Create a textarea', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.Textarea valueBinding="name" labelBinding="label"}}'
		name: 'foobar'
		label: 'FooBar'

	appendView()

	ok true, '...'