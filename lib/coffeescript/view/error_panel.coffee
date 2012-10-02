

Tent.ErrorPanel = Ember.View.extend
	classNames: ['tent-error-panel']
	errors: Ember.Object.create()

	addErrorsFromView: (view)->
		console.log('ErrorPanel: adding errors')
		errs = view.get('validationErrors')
		if errs?
			viewId = view.get('elementId')
			@get('errors').set(viewId, $.merge([],errs))

	getErrorsForView: (view) ->
		return @get('errors').get(view.get('elementId'))

	clear: ->
		@set('errors', Ember.Object.create())

Tent.ErrorObject = Ember.Object.extend
	viewId: null
	errorMessages: null
	errorType: null


Tent.errorPanel = Tent.ErrorPanel.create()