getPath = Ember.Handlebars.getPath
normalizePath = Ember.Handlebars.normalizePath

Ember.Handlebars.registerHelper 'loc', (property, options) ->
	context = (options.contexts && options.contexts[0]) || this
	normalized = normalizePath(context, property, options.data)
	pathRoot = normalized.root
	path = normalized.path
	#key = (path == 'this') ? pathRoot : getPath(pathRoot, path, options)
	key = getPath(pathRoot, path, options) || Ember.get(path)
	
	if key?
		args = []
		if options.hash.args?
			args.push(Ember.get(arg) for arg in Ember.String.w(options.hash.args))
		return Ember.String.htmlSafe(Tent.I18n.loc(key, args[0]))
	
	return path 
