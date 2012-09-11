view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->
	@TemplateTests = Ember.Namespace.create()
	Ember.run ->
		@dispatcher = Ember.EventDispatcher.create()
		@dispatcher.setup()

teardown = ->
	if view
		Ember.run -> view.destroy()
		view = null
	@TemplateTests = undefined
	@dispatcher.destroy()

module 'Tent.Textarea', setup, teardown

test 'Create a textarea', ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '{{view Tent.Textarea 
				valueBinding="name" 
				labelBinding="label"
				rows="19"
				cols="40"
			}}'
		name: 'foobar'
		label: 'FooBar'

	appendView()

	ok view.$('textarea').length, 1, 'text area field gets rendered'
	equal view.$('.tent-textarea').length, 1, 'tent-textarea class gets applied'
	equal view.$('label').text(), view.get('label'), 'label is rendered'
	equal view.$('textarea').attr('rows'), 19, 'Rows was rendered'
	equal view.$('textarea').attr('cols'), 40, 'Cols was rendered'


test 'Ensure Textarea renders Span if isEditable=false', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Textarea 
    			valueBinding="name" labelBinding="label" isEditable=false}}'
    name: 'foobar'
    label: 'FooBar'

  appendView()
  
  equal view.$('span').length, 2, 'span gets rendered'
  equal $('.controls span').text(), view.get('name') , 'value is set to span'
  equal view.$('.uneditable-input').length, 1, 'uneditable-input class gets applied'


test 'Ensure value is propagated back from DOM to controller', ->

  TemplateTests.controller = Ember.Object.create
    content: 'foobar'

  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Textarea
      valueBinding="TemplateTests.controller.content"
      labelBinding="label"
      isEditable=true}}'
    label: 'FooBar'

  appendView()
  
  equal view.$('textarea').val(), 'foobar', 'Initial DOM value'
  equal TemplateTests.controller.get('content'), 'foobar', 'Initial controller value"'

  Ember.run ->
    view.$('textarea').val('newValue')
    view.$('textarea').trigger('change')
  equal view.$('textarea').val(), 'newValue', 'Dom value changed'
  equal TemplateTests.controller.get('content'), 'newValue', 'Controller value is set to "newValue"'

  Ember.run ->
    TemplateTests.controller.set('content', 'resetValue') 
  equal view.$('textarea').val(), 'resetValue', 'DOM value is reset'


test 'Ensure required check', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Textarea valueBinding="name" 
      labelBinding="label"
      required=true
      isValidBinding="isValid"}}'
    name: 'foobar'
    label: 'FooBar'

  appendView()

  ok view.$('span.tent-mandatory').length, 1, 'required icon displayed' 

  Ember.run ->
    view.$('textarea').val('newValue')
    view.$('textarea').trigger('change')
  ok view.get('isValid')

  Ember.run ->
    view.$('textarea').val('')
    view.$('textarea').trigger('change')
  ok not view.get('isValid')  


test 'Ensure readonly attribute', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Textarea valueBinding="name" 
      labelBinding="label"
      readOnly=true}}'
    name: 'foobar'
    label: 'FooBar'

  appendView()

  equal view.$('textarea').attr('readonly'), 'readonly', 'readonly attribute detected'

test 'Test for disabled', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Textarea disabled=true}}'
  appendView()

  equal view.$('textarea').attr('disabled'), 'disabled', 'disabled attribute detected'

test 'Ensure tooltip gets displayed', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Textarea valueBinding="name" 
      labelBinding="label"
      tooltip="tooltip here.."
      }}'
    name: 'foobar'
    label: 'FooBar'
  appendView()

  equal view.$('a[rel=tooltip]').length, 1, 'Tooltip anchor exists'
  equal view.$('a[rel=tooltip]').attr('data-original-title'), "tooltip here..", 'Tooltip text'
  ok typeof view.$("a[rel=tooltip]").tooltip, "function", 'tooltip plugin has been applied'

test 'Ensure aria attributes are applied ', ->
  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.Textarea isMandatory=true}}'
  appendView()
  equal view.$('textarea[required=required]').length, 1, 'required html5 attribute'
  equal view.$('textarea[aria-required=true]').length, 1, 'Aria-required'



