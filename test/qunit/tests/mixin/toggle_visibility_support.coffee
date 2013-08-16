setup = ->
teardown = ->

module 'Tent.ToggleVisibility', setup, teardown

test 'Check for isShowing property', ->
	View = Ember.Object.extend Tent.ToggleVisibility
	view = View.create()

	equal view.get('isShowing'), false, 'Should be false to start'
	view.showComponent($())
	equal view.get('isShowing'), true, 'Should be set to true'
	view.hideComponent($())
	equal view.get('isShowing'), false, 'Should be set to false again'
	view.toggleVisibility($('<span></span>').css('display','none'),$($('<span></span>')))
	equal view.get('isShowing'), true, 'Should be set to true after toggleVisibility'
	view.toggleVisibility($('<span></span>').css('display','visible'),$($('<span></span>')))
	equal view.get('isShowing'), false, 'Should be set to false after toggleVisibility'
	

	