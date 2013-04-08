Tent.Browsers = {}

Tent.Browsers.getIEVersion = ->
	v = 3
	div = document.createElement('div')
	a = div.all || []
	while v < 10
		div.innerHTML = '<!--[if gt IE '+(++v)+']><i></i><![endif]-->'
		if div.getElementsByTagName('i')[0]?
			version = v
	version

Tent.Browsers.isIE = ->
	@.getIEVersion()?

