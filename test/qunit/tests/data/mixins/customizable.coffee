setup = ->

teardown = ->

module 'Tent.Data.Customizable', setup, teardown

Customizable = Ember.Object.extend Tent.Data.Customizable,
  dataType: 'lego'
  fetchPersonalizations: ->
  createPersonalizationRecordForClientSide: ->
    Ember.Object.create({name:"1"})
  personalizations: []

test 'Test saveUIState', ->
  ###
  - set the customization name on the collection
  - save the latest state to the server
  - update the existing p13n or adda  new one if it doesnt exist
  ###

  customizable = Customizable.create()
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

test 'personalizations are saved correctly', ->
  # by default, personalizations are saved with a subcategory equal
  # to the dataType of the Collection
  store = Ember.Object.extend({savePersonalization: ->}).create()
  mock = sinon.mock(store)
  mock.expects('savePersonalization').once().withArgs('collection', 'lego', 'foo')

  customizable = Customizable.create()
  customizable.set('store', store)
  customizable.saveUIState('foo')

  mock.verify()

  # the personalization subcategory can be overridden by setting the
  # personalizationType property
  mock = sinon.mock(store)
  mock.expects('savePersonalization').once().withArgs('collection', 'testType', 'foo')

  customizable.set('personalizationType', 'testType')
  customizable.saveUIState('foo')

  mock.verify()
  expect(0)

test 'filter gets saved when customization gets saved', ->
	customizable = Customizable.create
		selectedFilter: "filter1"
		updateCurrentFilter: ->
			@set('selectedFilter', "filter2")
		store: 
			savePersonalization: ->

	report = Ember.Object.create
		name:'report1'
	equal customizable.get('selectedFilter'), "filter1"
	customizable.saveReport(report)
	equal customizable.get('selectedFilter'), "filter2"


