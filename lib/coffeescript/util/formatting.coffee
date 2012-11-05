
accounting.settings = 
	currency:
		symbol : "$"   # default currency symbol is '$'
		format: "%s%v" # controls output: %s = symbol, %v = value/number (can be object: see below)
		decimal : "."  # decimal point separator
		thousand: ","  # thousands separator
		precision : 2   # decimal places
	number:
		precision : 2  # default precision on numbers is 0
		thousand: ","
		decimal : "."
		pattern: 'xxx,xxx.xx'

Tent.Formatting = {} unless Tent.Formatting?

###*
* @class Tent.Formatting
* 
* Formatting methods for converting base values to and from presentation strings.
*
###

###*
* @class Tent.Formatting.amount
###

###*
* @property {Object} divisor A function to transform the value before formatting, and after unformatting.
* This may typically be provided to normalise values when stored as centesimal values
* The divisor is expected to have a 'func' property which returns a Numeric divisor
###


Tent.Formatting.amount = Ember.Object.create

	###*
	* @method format
	* Formats an amount
	* @param {Number} amount The amount to format
	* @param {Array} [settings] Optional setting to use for formatting
	* @return {String} The formatted value
	###
	format: (amount, settings) ->
		if amount?
			amount = if @divisor? then amount * @divisor.func() else amount
			if settings?
				settings = Tent.Formatting.amount.settingsFilter(settings)
				accounting.formatNumber(amount, settings)
			else
				accounting.formatNumber(amount)
		else
			""

	###*
	* @method unformat
	* Unformats an amount
	* @param {String} amount The amount to format
	* @param {Array} [settings] Optional setting to use for formatting
	* @return {Number} The unformatted value
	###
	unformat: (amount, settings) ->
		if amount?
			if settings?
				settings = Tent.Formatting.amount.settingsFilter(settings)
				amount = accounting.unformat(amount, settings)
			else
				amount = accounting.unformat(amount)
			amount = if @divisor? then amount / @divisor.func() else amount
		else
			null

	settingsFilter: (rawSettings) ->
		rawSettings

	cssClass: ->
		"amount"

Tent.Formatting.date = Ember.Object.create
	options: 
		dateFormat: "mm/dd/yy"

	getFormat: ->
		return @get('options').dateFormat

	format: (value, dateFormat) ->
		$.datepicker.formatDate(dateFormat or @getFormat(), value)
	
	unformat: (value, dateFormat) ->
		$.datepicker.parseDate(dateFormat or @getFormat(), value)

	cssClass: ->
		"date"

Tent.Formatting.number = Ember.Object.create
	isValidNumber: (value)->
		(value != '') && !(isNaN(value) || isNaN(parseFloat(value))) 

	errorText: ->
		Tent.I18n.loc 'formatting.number'

	format: (value) ->
		if (typeof value == 'number') or value == ''
			value.toString(10)
		else if value?
			value
		else 
			""
	unformat: (value) ->
		# Convert from a string to a number
		if @isValidNumber(value)
			val = parseFloat(value)
		else if value==""
			return null
		else 
			value

	cssClass: ->
		"amount"
