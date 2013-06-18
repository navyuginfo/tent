setup = ->

teardown = ->

module 'Tent.Data.Customizable', setup, teardown

test 'Test saveUIState', ->

	###
	- set the customization name on the collection
	- save the latest state to the server
	- update the existing p13n or adda  new one if it doesnt exist
	###

	Customizable = Ember.Object.extend Tent.Data.Customizable,
		fetchPersonalizations: ->
		createPersonalizationRecordForClientSide: ->
			Ember.Object.create({name:"1"})
		personalizations: []

	customizable = Customizable.create()

	#spStub = sinon.stub(customizable, 'savePersonalization')
	mock = sinon.mock(customizable)
	mock.expects('savePersonalization').once()

	customizable.saveUIState('thisYear')
	equal customizable.get('customizationName'), 'thisYear', 'set the customization name on the collection' 
	equal customizable.get('personalizations').length, 1, 'Added a p13n'

	mock.verify()
	mock.restore()

	spStub = sinon.stub(customizable, 'savePersonalization')

	customizable.saveUIState(' thisYear    ')
	equal customizable.get('customizationName'), 'thisYear', 'ensure trim on the name' 

