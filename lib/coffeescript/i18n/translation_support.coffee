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
		pleaseSelect: 'Please Select...'
		confirm: 'Confirmation'
		button: {
			ok: 'Ok'
			yes: 'Yes'
			cancel: 'Cancel'
			save: 'Save'
			saveAs: 'Save As...'
			load: 'Load'
			no: 'No'
			proceed: 'Ignore warnings and proceed'
			dontProceed: 'No, return to page'
		}
		dateRange:
			useFuzzy: 'Use relative date'
			presetRanges:
				Today: 'Today'
				Tomorrow: 'Tomorrow'
				Last7days: 'Last 7 Days'
				Monthtodate: 'Month to date'
				Yeartodate: 'Year to date'
				ThepreviousMonth: 'The previous Month'
				Last30Days: 'Last 30 Days'
				Next30Days: 'Next 30 days'
		jqGrid: {
			hideShowAlt: 'Hide/Show Columns'
			hideShowCaption: 'Columns'
			hideShowTitle: 'Hide/Show Columns'
			horizontalScroll: 'Auto-Fit'
			multiviewList: 'List View'
			multiviewCard: 'Card View'
			emptyRecords: 'No results were returned'
			export: {
				xml: 'XML'
				json: 'JSON'
				csv: 'CSV'
				xlsx: 'XLSX'
				xls: 'XLS'
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
			pagerViewing: 'VIEWING'
			paging: {
				next: 'Next page'
				prev: 'Previous page'
				first: 'First page'
				last: 'Last page'
			}
			saveUi: {
				defaultName: 'No Customization'
				default: 'No Customization'
				message: 'Save current settings as:'
			}
		}
		filter: {
			filter: 'Filters'
			filterAction: 'Filter'
			appliedFilters: 'Applied Filters'
			add: 'Add Field'
			bgHint: 'Add Filters'
			prompt: 'Select a field ...'
			operatorLabel: 'Operator'
			operatorPrompt: 'Select an operator'
			del: 'Delete Field'
			lock: 'Lock Field '
			edit: 'Edit'
			ok: 'Ok'
			fieldname: 'Field Name'
			availableFilters: 'Available Filters'
			selectedFilter: 'Selected Filter'
			currentFilter: 'Current Filter'
			saveFilter: 'Save Filter'
			newFilter: 'New Filter'
			filterLabel: 'Filter Label'
			filterDescription: 'Filter Description'
			duplicate: 'A filter already exists for the selected field'
			save: 'Save'
			saveAs: 'Save As'
			cancel: 'Cancel'
			label: 'Label'
			more: 'more'
			description: 'Description'
			beginsWith: 'begins with'
			contains: 'contains'
			equal: 'is equal to'
			nEqual: 'is not equal to'
			before: 'is before'
			after: 'is after'
			beforeInc: 'is before incl'
			afterInc: 'is after incl'
			lThan: 'is less than'
			gThan: 'is greater than'
			lThanEq: 'is less than or equal to'
			gThanEq: 'is greater than or equal to '
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
			totals: 'Totals:'
		}
		rename: {
			main: 'Rename'
		}
		sorting: {
			main: 'Sort'
			ascending: 'Ascending'
			descending: 'Descending'
		}
		upload: {
			buttonLabel: 'Select file to Upload'
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
			uniqueValue: '%@item with this %@property already exists'
	}
 
)
