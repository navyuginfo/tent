###*
 * @class Tent.AriaSupport
 * Some docs here...
###

Tent.AriaSupport = Ember.Mixin.create
	attributeBindings: [
		'ariaRequired:aria-required'
		'ariaReadOnly:aria-readonly'
		'ariaDisabled:aria-disabled'
		'ariaDescribedBy:aria-describedby'
	]
	ariaRequired: (->
		return if @get('parentView.required') then 'true' else 'false'
	).property('parentView.required')

	ariaReadOnly: (->
		return if @get('parentView.readOnly') then 'true' else 'false'
	).property('parentView.readOnly')

	ariaDisabled: (->
		return if @get('parentView.disabled') then 'true' else 'false'
	).property('parentView.disabled')

	ariaDescribedBy: (->
		@get('parentView.errorId') + " " + @get('parentView.helpId')
	).property('parentView.errorId')



