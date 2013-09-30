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

# If a script is likely to take a long time to run, and potentially 
# trigger an IE long-running-script timeout, then wrap it in this method
# to cause it to execute asynchronously.
Tent.Browsers.executeForIE = (context, callback, args)->
	if Tent.Browsers.getIEVersion() != 8
		if args?
			callback.apply(context,args)
		else
			callback.apply(context)
	else
		if args?
			setTimeout((-> callback.apply(context, args)), 10) 
		else
			setTimeout((-> callback.apply(context)), 10) 
