setup = ->
	@dom = $('<div></div>')
	@Hideable = Ember.View.extend Tent.HideableSupport

	@hideable = Hideable.create
		hidden: false
		hideable: true
		$: ->
			dom


teardown = ->
	delete @dom
	delete @hideable
	delete @Hideable

module 'Tent.HideableSupport', setup, teardown

test 'didInsertElement', ->
	hideable.hidden = true
	hideable.didInsertElement()
	ok hideable.get('hidden'), 'initial state is hidden'
	ok dom.hasClass('hidden'), '"force" was used to set the class'

test 'Test hide: hideable', ->
	ok not dom.hasClass('hidden'), 'No hidden class to start with'
	hideable.hide()
	ok hideable.get('hidden'), 'hidden property added'
	ok dom.hasClass('hidden'), 'hidden class added'

	hideable.show()
	ok not hideable.get('hidden'), 'hidden property removed'
	ok not dom.hasClass('hidden'), 'hidden class removed'


test 'Test non-hideable', ->
	hideable.hideable = false

	hideable.hidden = true
	hideable.show()
	ok hideable.get('hidden'), 'Should not have changed hidden state to not-hidden'

	hideable.hidden = false
	hideable.hide()
	ok not hideable.get('hidden'), 'Should not have changed hidden state to hidden'
	