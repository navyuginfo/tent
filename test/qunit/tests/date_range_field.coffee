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

test 'convertSingleDateToDateRange', ->
	view = Tent.DateRangeField.create
			dateFormat: 'mm/dd/yyyy'
			rangeSplitter: 'x'
	newDate = view.convertSingleDateToDateRange("date1")
	equal newDate, 'date1,date1', 'duplicate single date'
	newDate = view.convertSingleDateToDateRange("date1,date2")
	dateArr = newDate.split(',')
	equal dateArr[0], 'date1', 'first date does not change'
	equal dateArr[1], 'date2', 'second date does not change'
	equal dateArr.length, 2, 'Contains 2 items'


test 'initialize with value (fuzzy turned off)', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.DateRangeField required=true
			value="11/11/2011 - 12/11/2011"
			rangeSplitter="-"
			allowFuzzyDates=true
		}}'

	appendView()	
	#rangeWidget.validate()
	rangeWidget = Ember.View.views[view.$('.tent-date-range-field').attr('id')]
	equal rangeWidget.getValue(), '11/11/2011 - 12/11/2011', 'initial value'
	equal rangeWidget.get('value'), '11/11/2011 - 12/11/2011', 'Set value'
	equal rangeWidget.get('dateValue'), '11/11/2011 - 12/11/2011', 'Set dateValue'
	equal rangeWidget.get('fuzzyValueTemp'), '11/11/2011 - 12/11/2011', 'Set fuzzyValueTemp'
	ok not rangeWidget.isChecked(), 'Checkbox is off'
	

test 'initialize with fuzzy value)', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.DateRangeField required=true
			value="11/11/2011 - 11/11/2011"
			fuzzyValue="Today"
			rangeSplitter="-"
			allowFuzzyDates=true
			arrows=true
		}}'

	appendView()	

	rangeWidget = Ember.View.views[view.$('.tent-date-range-field').attr('id')]

	equal rangeWidget.getValue(), 'Today', 'initial value'
	notEqual rangeWidget.get('value'), '11/11/2011 - 11/11/2011', 'Set value'

	ok rangeWidget.isConventionalDate(rangeWidget.getStartFromDate(rangeWidget.get('value'))), 'Value has valid fuzzy start date'
	ok rangeWidget.isConventionalDate(rangeWidget.getEndFromDate(rangeWidget.get('value'))), 'Value has valid fuzzy end date'	

	notEqual rangeWidget.get('dateValue'), '11/11/2011 - 12/11/2011', 'Set dateValue'
	ok rangeWidget.get('useFuzzyDates'), 'useFuzzyDates is true'
	equal rangeWidget.get('fuzzyValueTemp'), 'Today', 'Set fuzzyValueTemp'
	equal rangeWidget.get('formattedValue'), 'Today', 'formattedValue'
	ok rangeWidget.isChecked(), 'Checkbox is on'

test 'get date from fuzzy value)', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.DateRangeField required=true
			value="11/11/2011 - 11/11/2011"
			fuzzyValue="Today"
			rangeSplitter="-"
			allowFuzzyDates=true
			arrows=true
		}}'

	appendView()	
	rangeWidget = Ember.View.views[view.$('.tent-date-range-field').attr('id')]

	equal rangeWidget.getDateStringFromFuzzyValue('invalidFuzzyDate'), 'invalidFuzzyDate', "invalid date"
	today = rangeWidget.getDateStringFromFuzzyValue('Today')
	ok rangeWidget.isConventionalDate(rangeWidget.getStartFromDate(today)), 'Value has valid fuzzy start date'
	ok rangeWidget.isConventionalDate(rangeWidget.getEndFromDate(today)), 'Value has valid fuzzy end date'	
	 

test 'change with fuzzy dates', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.DateRangeField required=true
			 
			fuzzyValue="Today"
			rangeSplitter="-"
			allowFuzzyDates=true
			arrows=true
		}}'

	appendView()	
	rangeWidget = Ember.View.views[view.$('.tent-date-range-field').attr('id')]

	#While in fuzzy mode
	rangeWidget.setValue('Tomorrow')
	equal rangeWidget.getValue(), 'Tomorrow', 'Input field has the correct value displayed'
	ok rangeWidget.isConventionalDate(rangeWidget.getStartFromDate(rangeWidget.get('value'))), 'Value has valid fuzzy start date'
	ok rangeWidget.isChecked(), 'Checkbox is on'

	# Toggle fuzzy mode, 
	Ember.run ->
		rangeWidget.set('useFuzzyDates', false)
	ok rangeWidget.isConventionalDate(rangeWidget.getStartFromDate(rangeWidget.getValue())), 'Toggle fuzzy mode, onscreen display should change. Value has valid fuzzy start date'
	ok rangeWidget.isConventionalDate(rangeWidget.getEndFromDate(rangeWidget.getValue())), 'Toggle fuzzy mode, onscreen display should change. Value has valid fuzzy end date'	
	



