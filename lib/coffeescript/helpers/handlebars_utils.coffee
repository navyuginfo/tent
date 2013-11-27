getPath = Ember.Handlebars.get
normalizePath = Ember.Handlebars.normalizePath

Tent.Handlebars = Ember.Namespace.create
	getPath: (property, options)->
		context = (options.contexts && options.contexts[0]) || this
		normalized = normalizePath(context, property, options.data)
		pathRoot = normalized.root
		path = normalized.path
		getPath(pathRoot, path, options) || Ember.get(path) || path