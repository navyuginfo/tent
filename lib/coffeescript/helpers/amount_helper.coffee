###*
* `formatAmount` allows you to present a numeric value formatted as a money amount 
* according to the current locale
*		
*		{{formatAmount amount}}
*
* @class Handlebars.helpers.formatAmount
* @param {Number} amount
* @returns {String} HTML string
###

Ember.Handlebars.registerHelper 'formatAmount', (property, options) ->
	amount = Tent.Handlebars.getPath(property, options)
	return Tent.Formatting.amount.format(amount, options.hash)
