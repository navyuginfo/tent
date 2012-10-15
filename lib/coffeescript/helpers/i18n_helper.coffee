###*
* `loc` will translate a string key using the bundle for the current locale
*		
*		{{loc string}}
*
* You may optionally pass in an **args** property, which is a space-delimited list of
* values which will be interpolated into the translated key string 
*
*    	{{loc string args='view.firstName view.lastName'}}
*
* @class Handlebars.helpers.loc
* @param {String} key
* @param {}
* @returns {String} translated string
###

Ember.Handlebars.registerHelper 'loc', (property, options) ->
	key = Tent.Handlebars.getPath(property, options)
	if key?
		args = []
		if options.hash.args?
			args.push(Ember.get(arg) for arg in Ember.String.w(options.hash.args))
		return Ember.String.htmlSafe(Tent.I18n.loc(key, args[0]))
	
	return path 

