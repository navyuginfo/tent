Ember.Handlebars.registerHelper 'formatDate', (context, options) ->
	return Tent.Formatting.date.format(Ember.get(context), options.hash.format)