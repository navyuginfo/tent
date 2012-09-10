view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->

teardown = ->

module 'Tent.DateField', setup, teardown

test 'Test format and unFormat', ->
	view = Tent.DateField.create()
	equal view.get('options').dateFormat, 'mm/dd/yy', 'Date format option was set'
	equal view.format(new Date()), '01/01/1970', 'Format a date'
	deepEqual view.unFormat('01/01/1970'), new Date(), 'UnFormat a date'

test 'Test Validate', ->
	view = Tent.DateField.create()
	view.set('formattedValue', '12/04/2005')
	ok view.validate(), 'Valid date string'

	view.set('formattedValue', '12/44/20045')
	ok !view.validate(), 'Invalid date string'

	view.set('formattedValue', '')
	ok view.validate(), 'Empty string is valid'

test 'Mandatory behaviour', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.DateField isMandatory=true}}'
  appendView()
  
  ok view.$('span.tent-mandatory').length, 1, 'mandatory icon displayed' 

test 'Ensure tooltip gets displayed', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.DateField 
                          tooltip="tooltip here.."
                          }}'
  appendView()

  ok view.$('a[rel=tooltip]')?, 'Tooltip anchor exists'
  equal view.$('a[rel=tooltip]').attr('data-original-title'), "tooltip here..", 'Tooltip text'
  ok typeof view.$("a[rel=tooltip]").tooltip, "function", 'tooltip plugin has been applied'

test 'Ensure aria attributes are applied ', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.DateField isMandatory=true}}'
  appendView()
  equal view.$('input[required=required]').length, 1, 'required html5 attribute'
  equal view.$('input[aria-required=true]').length, 1, 'Aria-required'