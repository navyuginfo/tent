###*
* `formatDate` allows you to present a Date value formatted to the current locale
*		
*		{{formatDate date}}
*
* @class Handlebars.helpers.formatDate
* @param {Date} date
* @returns {String} HTML string
###

Ember.Handlebars.registerHelper 'formatDate', (context, options) ->
	date = Tent.Handlebars.getPath(context, options)
	return Tent.Formatting.date.format(date, options.hash.format)