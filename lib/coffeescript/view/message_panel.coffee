require '../template/message_panel'

###*
 * @class Tent.MessagePanel
 * @extends Ember.View
 *
 * A panel for displaying error and information messages for the application.
 *
 * All Tent widgets will publish messages when they are in an error state and these will
 * be displayed dynamically by the MessagePanel. If there are no errors, the panel will be hidden.
 * Each error message will identify the source of the error, if provided, and can also send focus
 * to the source widget when clicked.
 *
 * Error messages can also be displayed by explicitly publishing them, setting type='error'
 *
 * 			$.publish('/message', {
 					type:'error', 
 					messages:['Date format incorrect'], 
 					sourceId: 'ember13'
 					label: 'Date'
 			})
 *
 * - **type**: The type of message, can be 'error' or 'info'
 * - **messages**: An array of messages to display
 * - **sourceId**: If the message refers to a Tent widget, provide the elementId of the widget
 * so that focus can be transferred to it when the error is clicked
 * - **label**: The label to display beside the messages for this source
 *
 * Each source will be allocated one line in the MessagePanel. If there are no messages for
 * a source, it will be removed from the MessagePanel. So in effect, to clear the messages for a source, send an
 * empty messages array
 * 			
 * 			$.publish('/message', {
 					type:'error', 
 					messages:[], 
 					sourceId: 'ember13'
 			})
 * 
 * Information messages are displayed as-is, with no linking to source widgets.
 *
 * 			$.publish('/message', {
 					type:'info', 
 					messages:['Please call this number for assistance..']
 			})
 *
 * If you wish to display more than one message, use different sourceId's in the published message.
 *
 * The default state of the MessagePanel is collapsed and showing the first message. The panel can 
 * be expanded if there is more than one message. The panel can be permanently expanded by setting the 
 * {@link #collapsible} property to false. The default collapse state can be set with the {@link #collapsed}
 * property.
 *
 * 
 *
 * ##Usage
 *         {{view Tent.MessagePanel}}
 *
###
Tent.MessagePanel = Ember.View.extend
	templateName: 'message_panel'
	classNames: ['tent-message-panel']
	title: null

	###*
  	* @property {Boolean} collapsible A boolean indicating that the panel is collapsible
  	###
	collapsible: true

	###*
  	* @property {Boolean} collapsed A boolean indicating that the panel is collapsed by default
  	###
	collapsed: true
	init: ->
		@_super()
		@clearAll()
		@set('handler', $.proxy(@handleNewMessage, @))
		$.subscribe('/message', @get('handler') )

	willDestroy: ->
		$.unsubscribe('/message', @get('handler'))
		@_super()

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
		newErrors = Ember.ArrayProxy.create({content: $.merge([], arrayWithMessageRemoved)})
		@set(msg.type, newErrors)


	expandoClass: (->
		if @get('collapsed') then "error-expando collapse" else "error-expando collapse in"
	).property('collapsed')
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

	hasMoreThanOneError: (->
		@get('error').toArray().length > 1
	).property('error')

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