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

Tent.Browsers.isChromeFrame = ->
	b = navigator.userAgent
	c = /MSIE (\S+); Windows NT/
	g = false
	if c.test(b)
		g = true  if parseFloat(c.exec(b)[1]) < 6 and b.indexOf("SV1") < 0
	else
		g = true
	g