###*
* @class Tent.Textarea
* @mixins Tent.FormattingSupport
* @mixins Tent.FieldSupport
* @mixins Tent.TooltipSupport
* @mixins Tent.AriaSupport
* @mixins Tent.Html5Support
* @mixins Tent.ReadonlySupport
* @mixins Tent.DisabledSupport
* Usage
*      {{view Tent.Textarea label="" valueBinding="" }}
* @property {String} label
* @property {Boolean} readonly 
###

require '../template/textarea'
require '../mixin/readonly_support'

Tent.Textarea = Ember.View.extend Tent.FormattingSupport, Tent.FieldSupport, Tent.TooltipSupport,
	templateName: 'textarea'
	classNames: ['tent-textarea', 'control-group']

	valueForMandatoryValidation: (->
		@get('formattedValue')
	).property('formattedValue')

	didInsertElement:->
		@_super()
		@set('inputIdentifier', @$('textarea').attr('id'))

	# Text areas don't have line specific validations. Therefore we only validate when saving the form.
	focusOut: ->
		
	change: ->  

Tent.TextareaInput = Ember.TextArea.extend Tent.AriaSupport, Tent.Html5Support, Tent.ReadonlySupport, Tent.DisabledSupport