###*
* @class Tent.Data.ExportSupport
* Adds support for exporting
###

Tent.Data.ExportSupport = Ember.Mixin.create
	###*
	* @method getURL Returns the URL hosting the export service
	* @param {String} type The type of exported data to generate
	###
	getURL: (type)->
		return '#'