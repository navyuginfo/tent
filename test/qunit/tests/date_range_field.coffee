view = null
@dispatcher = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->
  Ember.run ->
    @dispatcher = Ember.EventDispatcher.create()
    @dispatcher.setup()      

teardown = ->
  if view
      Ember.run -> view.destroy()
      view = null
  Em.run -> 
    @dispatcher.destroy()

module 'Tent.DateRangeField', setup, teardown

test 'placeholder', ->
	view = Tent.DateRangeField.create
			dateFormat: 'mm/dd/yyyy'
			rangeSplitter: 'x'

	equal view.get('placeholder'), 'mm/dd/yyyyx mm/dd/yyyy', 'placeholder format'

test 'test set and get value', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.DateRangeField required=true
			value="11/11/2011 - 12/11/2011"
			rangeSplitter="-"
		}}'

	appendView()	
	rangeWidget = Ember.View.views[view.$('.tent-date-range-field').attr('id')]
	inputfield = view.$('input')
	equal rangeWidget.getValue(), '11/11/2011 - 12/11/2011', 'initial value'
	
	Ember.run ->
		inputfield.val('11/11/2012 - 12/11/2012')
	equal rangeWidget.getValue(), '11/11/2012 - 12/11/2012', 'changed input value'

test 'validate', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.DateRangeField required=true
			value="11/11/2011 - 12/11/2011"
			rangeSplitter="-"
		}}'

	appendView()	
	rangeWidget = Ember.View.views[view.$('.tent-date-range-field').attr('id')]
	
	rangeWidget.validate()
	deepEqual rangeWidget.get('startDate'), Tent.Formatting.date.unformat('11/11/2011'), 'Got a start date'
	deepEqual rangeWidget.get('endDate'), Tent.Formatting.date.unformat('12/11/2011'), 'Got an end date'

	rangeWidget.set('formattedValue', 'blah')
	rangeWidget.validate()
	ok rangeWidget.get('isValid'), 'should be invalid'


test 'initializeWithStartAndEndDates', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.DateRangeField required=true
			startDateBinding="startDate"
			endDateBinding="endDate"
			rangeSplitter="-"
		}}'
		startDate: Tent.Formatting.date.unformat('11/11/2011')
		endDate: Tent.Formatting.date.unformat('12/11/2011')

	appendView()

	#rangeWidget = Ember.View.views[view.$('input').attr('id')]
	equal view.$('input').val(), '11/11/2011- 12/11/2011', 'Value should be set from dates'
