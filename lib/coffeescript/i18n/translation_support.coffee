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
	* @param {String|[Array| Object]} [vars] arguments to be interpolated in the translated string
	###
	loc: (key, vars) ->
    if key?
      string = Ember.get(@language, key) || key
      idx  = 0
      vars = [vars] if(typeof vars == 'string')
      string.replace(/%@([0-9]|[a-zA-Z]+)?/g,(s, argIndex)->
        argIndex = if(argIndex? and isNaN(argIndex)) then argIndex else (if isNaN(parseInt(argIndex)) then idx++ else parseInt(argIndex)-1)
        s = vars?[argIndex]
        if(s?) then s else ''
      )


Tent.translate = Tent.I18n.loc

Tent.I18n.loadTranslations(
	tent: {
		on: 'On'
		off: 'Off'
		pleaseSelect: 'Please Select'
		button: {
			ok: 'Ok'
			yes: 'Yes'
			cancel: 'Cancel'
			save: 'Save'
			saveAs: 'Save As...'
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
				comma: 'COMMA'
				pipe: 'PIPE'
				semicolon:'SEMI COLON'
				colon: 'COLON'
				_or: 'or'
				enterDelimiter: 'Enter Delimiter'
				headers: 'Column Headers'
				inclQuotes: 'Include Quotes'
				export: 'Export'
			}
			saveUi: {
				message: 'Save current settings as:'
			}
		}
		filter: {
			filter: 'Filter'
			availableFilters: 'Available Filters'
			selectedFilter: 'Selected Filter'
			currentFilter: 'Filter'
			saveFilter: 'Save Filter'
			save: 'Save'
			cancel: 'Cancel'
			label: 'Label'
			more: 'more'
			description: 'Description'
			beginsWith: 'begins with'
			contains: 'contains'
			equal: 'equal'
			nEqual: 'not equal'
			before: 'before'
			after: 'after'
			beforeInc: 'before incl'
			afterInc: 'after incl'
			lThan: 'less than'
			gThan: 'greater than'
			lThanEq: 'less than or equal'
			gThanEq: 'greater than or equal'
			range: 'range'
			search: 'Search'
			clear: 'Clear'
			noFilter: 'No Filter'
			like: 'like'
		}
		warning: {
			header: 'Warnings Exist'
			warningsOnPage: 'The following warnings exist on this page. Do you wish to ignore them and proceed?'
		}
 
		grouping: {
			_groupBy: 'Group'
			range: {
				exact: 'Exact'
				tens: 'Tens'
				hundreds: 'Hundreds'
				thousands: 'Thousands'
				week: 'Week'
				weekStarting: 'Week starting'
				month: 'Month'
				quarter: 'Quarter'
				year: 'Year'
			}
			no_grouping: 'None'
			revert: 'Revert to Original'
		}
		rename: {
			main: 'Rename'
		}
		sorting: {
			main: 'Sort'
			ascending: 'Ascending'
			descending: 'Descending'
		}

	}
	error: {
	    generic: 'Error'
	    required: 'Field is required'
	    numeric: 'Value must be numbers only'
	    amount: 'Amount should be positive'
	    positive: 'Value should be positive'
	    email: 'Email format error'
	    date: 'Date format error'
	    dateBetween: 'Date should be between %@startDate and %@endDate'
	    dateFuture: 'You provided a date in the future'
	    maxLength: 'Length must be %@max characters or less'
	    minLength: 'Length must be %@min characters or more'
	    invalidCurrency: 'Invalid currency'
	    regexp: 'Value must pass the regular expression %@regexp'
	    minValue: 'Value must be greater than or equal to %@min'
	    maxValue: 'Value must be less than or equal to %@max'
	    valueBetween: 'Value must be between %@min and %@max'
	}
 
)
