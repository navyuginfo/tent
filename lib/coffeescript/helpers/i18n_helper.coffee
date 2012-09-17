Ember.Handlebars.registerHelper 'loc', (context, options) ->
	key = Ember.get(context)
	args = []
	if options.hash.args?
		args.push(Ember.get(arg) for arg in Ember.String.w(options.hash.args))

	return Ember.String.htmlSafe(Tent.I18n.loc(key, args[0]))
 	 
