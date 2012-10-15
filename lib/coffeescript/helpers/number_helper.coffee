###*
* `formatNumber` allows you to present a numeric value formatted  
* according to the current locale
*		
*		{{formatNumber number}}
*
* @class Handlebars.helpers.formatNumber
* @param {Number} number
* @returns {String} HTML string
###

Ember.Handlebars.registerHelper 'formatNumber', (context, options) ->
	number = Tent.Handlebars.getPath(context, options)
	return Tent.Formatting.number.format(number, options.hash.format)