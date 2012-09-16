Ember.Handlebars.registerHelper 'formatAmount', (context, options) ->
	return Tent.Formatting.amount.format(Ember.get(context))