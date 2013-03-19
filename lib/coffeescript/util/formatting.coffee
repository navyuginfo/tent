
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


Tent.Formatting.amount = Ember.Object.create
	cleanup: (value) ->
		if value? and value!=''
			Tent.Formatting.amount.format(accounting.unformat(value))
		else
			""

	###*
	* @method format
	* Formats an amount
	* @param {Number} amount The amount to format
	* @param {Array} [settings] Optional setting to use for formatting
	* @return {String} The formatted value
	###
	format: (amount, settings) ->
		if amount?
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
				accounting.unformat(amount, settings)
			else
				accounting.unformat(amount)
		else
			null

	settingsFilter: (rawSettings) ->
		rawSettings

	cssClass: ->
		"amount"

	###*
	* @Object serializer A serialization object which implements serialize() and deserialize() methods.
	###
	serializer: null

Tent.Formatting.date = Ember.Object.create
	options: 
		dateFormat: "mm/dd/yy"

	getFormat: ->
		return @get('options').dateFormat

	format: (value, dateFormat) ->
		if dateFormat is "dd-M-yy hh-mm tz"
			hours = value.getHours()
			hours = "0" + hours if hours < 10
			minutes = value.getMinutes()
			minutes = "0" + minutes if minutes < 10
			Tent.Formatting.date.format(value, "dd-M-yy") + ' ' + hours + ':' + minutes + " (" + Tent.Date.getAbbreviatedTZFromDate(value) + ")"
		else
			$.datepicker.formatDate(dateFormat or Tent.Formatting.date.getFormat(), value)
	
	unformat: (value, dateFormat) ->
		if dateFormat is "dd-M-yy hh-mm tz"
			$.datepicker.parseDate("dd-M-yy", value.substring(0,11))
		else
			$.datepicker.parseDate(dateFormat or Tent.Formatting.date.getFormat(), value)

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

	###*
	* @Object serializer A serialization object which implements serialize() and deserialize() methods.
	###
	serializer: null

Tent.Formatting.percent = Ember.Object.create
	isValidNumber: (value)->
		(value != '') && !(isNaN(value) || isNaN(parseFloat(value))) 

	errorText: ->
		Tent.I18n.loc 'formatting.percent'

	format: (value) ->
		if (typeof value == 'number') 
			Math.round(1000*value)/10.toString(10) + "%"
		else if value?
			value
		else 
			""
	unformat: (value) ->
		# Convert from a string to a number
		if value=="" or not value?
			return null
		if value.indexOf('%') != -1
			value = value.split('%')[0]

		if @isValidNumber(value)
			val = parseFloat((value/100).toFixed(3))
		else 
			value

	cssClass: ->
		"amount"

