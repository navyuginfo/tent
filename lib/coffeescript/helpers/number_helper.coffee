Ember.Handlebars.registerHelper 'formatNumber', (context, options) ->
	number = Tent.Handlebars.getPath(context, options)
	return Tent.Formatting.number.format(number, options.hash.format)