Ember.Handlebars.registerHelper 'formatNumber', (context, options) ->
	return Tent.Formatting.number.format(Ember.get(context), options.hash.format)