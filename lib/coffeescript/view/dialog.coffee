#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require '../template/dialog'

Tent.Dialog = Ember.View.extend
	templateName: 'dialog'
  ###*
  * @property {String} headerMessage The text to be displayed in Header of Confirm Dialog
  ###	
	headerMessage: null
	message: null
	response: null
	visible: false
	didConfirm: null
	didCancel: null

	init: ->
		if not(@get('headerMessage'))?
			@set('headerMessage', loc('confirm'))

	cancel: ->
		@set('visible', false)

	confirm: ->
		@set('visible', false)

	show: ->
		@set('visible', true)