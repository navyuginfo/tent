Tent.Browsers = {}

Tent.Browsers.getIEVersion = ->
	# Returns the version of Internet Explorer or undefined
	if navigator.appName is "Microsoft Internet Explorer"
		ua = navigator.userAgent
		re = new RegExp("MSIE ([0-9]{1,}[.0-9]{0,})")
		rv = parseFloat(RegExp.$1)  if re.exec(ua)?
	rv

Tent.Browsers.isIE = ->
	res = @getIEVersion()?
	# Memoize to prevent further execution.
	@isIE = ->
		res
	res
