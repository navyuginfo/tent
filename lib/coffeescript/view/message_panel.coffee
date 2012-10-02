require '../template/message_panel'

Tent.MessagePanel = Ember.View.extend
	templateName: 'message_panel'
	classNames: ['tent-message-panel']
	title: null

	init: ->
		@_super()
		@clearAll()
		$.subscribe('/message', $.proxy(@handleNewMessage, @))

	handleNewMessage: (e, msg)->
		if not msg.type?
			throw new Error('Message must have a type')
		errs = msg.messages
		arrayWithMessageRemoved = []
		if msg.messages? 
			arrayWithMessageRemoved = @get(msg.type).filter((item, index, enumerable) ->
				item.sourceId != msg.sourceId
			)
			if msg.messages.length > 0
				arrayWithMessageRemoved.pushObject($.extend({}, msg))
		@set(msg.type,  Ember.ArrayProxy.create({content: $.merge([], arrayWithMessageRemoved)}))

	didInsertElement: ->
		@$('expando').collapse('hide')

	###*
	 * return the error messages 
	###
	getErrorsForView: (viewId) ->
		errors = []
		for error in @get('error').get('content')
			if error.sourceId == viewId
				$.merge(errors, error.messages)
		return errors.uniq()

	getInfosForView: (viewId) ->
		infos = []
		for info in @get('info').get('content')
			if info.sourceId == viewId
				$.merge(infos, info.messages)
		return infos.uniq()

	hasErrors: (->
		@get('error').toArray().length > 0
	).property('error')

	hasInfos: (->
		@get('info').toArray().length > 0
	).property('info')


	clearAll: ->
		@clearErrors()
		@clearInfos()
	clearErrors: ->
		@set('error', Ember.ArrayProxy.create({content: []}))
	clearInfos: ->
		@set('info', Ember.ArrayProxy.create({content: []}))

	click: (e) ->
		target = $(e.target)

		wrappingMessage = target.closest('.error-message', @$())
		if wrappingMessage? and wrappingMessage.length > 0
			#target.hasClass('error-message') 
			targetId = wrappingMessage.attr('data-target')
			Ember.View.views[targetId].focus() if Ember.View.views[targetId]?
			

Tent.Message = Ember.Object.extend
	messages: null
	params: null
	type: null
	sourceId: null

Tent.Message.ERROR_TYPE = 'error'
Tent.Message.INFO_TYPE = 'info'

#Tent.errorPanel = Tent.ErrorPanel.create()