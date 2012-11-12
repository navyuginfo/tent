#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
* @class Tent.I18n
* A general purpose class for I18n support.
###

Tent.I18n = Ember.Namespace.create
	language: {}

	###*
	* Loads a set of translations for localizing text
	* @param {Object} translations A map of key:value pairs defining the translations to be used
	###
	loadTranslations: (translations)->
		if translations?
			@set('language', $.extend(@get('language'), translations))

	translate: (code) ->
		#Stubbed
		"t_" + code

	###*
	* Replace a key with its translation
	* @param {String} key
	* @param {String|Array} [vars] arguments to be interpolated in the translated string
	###
	loc: (key, vars) ->
		if key?
			string = Ember.get(@language, key) || key
			vars = [vars] if typeof vars == 'string'
			return Ember.String.fmt(string, vars)

Tent.translate = Tent.I18n.translate

Tent.I18n.loadTranslations(
	tent: {
		button: {
			ok: 'Ok'
			yes: 'Yes'
			cancel: 'Cancel'
			no: 'No'
			proceed: 'Ignore warnings and proceed'
			dontProceed: 'No, return to page'
		}
		jqGrid: {
			hideShowAlt: 'Hide/Show Columns'
			hideShowCaption: 'Columns'
			hideShowTitle: 'Hide/Show Columns'
			export: {
				xml: 'XML'
				json: 'JSON'
				csv: 'CSV'
				xlsx: 'XLSX'
			}
		}
		filter: {
			filter: 'Filter'
			availableFilters: 'Available Filters'
			selectedFilter: 'Selected Filter'
			currentFilter: 'Current Filter'
			saveFilter: 'Save Filter'
			save: 'Save'
			cancel: 'Cancel'
			label: 'Label'
			description: 'Description'
			beginsWith: 'begins with'
			contains: 'contains'
			equal: 'equal'
			nEqual: 'not equal' 
		}
		warning: {
			header: 'Warnings Exist'
			warningsOnPage: 'The following warnings exist on this page. Do you wish to ignore them and proceed?'
		}
	}
)