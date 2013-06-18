setup = ->

teardown = ->

module 'Tent.Browsers', setup, teardown

test 'Test isIE:', ->
	ver = Tent.Browsers.getIEVersion()
	equal Tent.Browsers.isIE(), ver?
