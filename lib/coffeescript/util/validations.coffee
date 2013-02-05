###*
* @class Tent.Validations
* Validations that can be applied to tent fields
###
Tent.Validations = Ember.Object.create()

Tent.Validation = Ember.Object.extend
	ERROR_MESSAGE: Tent.messages.GENERIC_ERROR

	isValueEmpty: (value) ->
		not (value? && value != '')

	getErrorMessage: (value, options)->
		Tent.I18n.loc(@get('ERROR_MESSAGE'),options || [])

###*
* @class Tent.Validations.email Validates that the value conforms to an email format
###
###*
* @method validate
* @param {String} value the value to test
* @return {Boolean} the result of the validation
###
Tent.Validations.email = Tent.Validation.create
  validate: (value, options, message)-> 
    pattern = /^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$/i
    isValid = (@isValueEmpty(value) or pattern.test(value))

  ERROR_MESSAGE: Tent.messages.EMAIL_FORMAT_ERROR

###*
* @class Tent.Validations.datebetween Validates that the date is between two specified dates
###
Tent.Validations.datebetween = Tent.Validation.create
  ###*
  * @method validate
  * @param {String} value the value to test
  * @param {Object} options the options to pass to the validation. options must contain a 
  * 'startDate' and an 'endDate' property
  * @return {Boolean} the result of the validation
  ###
  validate: (value, options, message)->
    if not options? or not options.startDate? or not options.endDate?
      return false
    isValid = @isValueEmpty(value) or (@convertToDate(value) > @convertToDate(options.startDate) and @convertToDate(value) < @convertToDate(options.endDate))

  convertToDate: (value) ->
    if not (value instanceof Date)
      return new Date(value)
    value

  ERROR_MESSAGE: Tent.messages.DATE_BETWEEN_ERROR

###*
* @class Tent.Validations.futuredate Validates that the date value is not later than today
###
Tent.Validations.futuredate = Tent.Validation.create
  ###*
  * @method validate
  * @param {String} value the value to test
  * @return {Boolean} the result of the validation
  ###
  validate: (value, options, message) ->
    today = new Date()
    if not @isValueEmpty(value) and @convertToDate(value, options) > today
      return false
    true

  convertToDate: (value, options) ->
    if not (value instanceof Date)
      return Tent.Formatting.date.unformat(value, options.dateFormat)
    value

  ERROR_MESSAGE: Tent.messages.DATE_FUTURE_ERROR

###*
* @class Tent.Validations.minLength Validates that the value is greater than or equal to a defined length
###
Tent.Validations.minLength = Tent.Validation.create
  ###*
  * @method validate
  * @param {String} value the value to test
  * @param {Object} options the options to pass to the validation. options must contain a 
  * 'min' value
  * @param {String} message an optional message to display if the validation fails
  * @return {Boolean} the result of the validation
  ###
  validate: (value, options, message)->
    if not options? or not options.min?
      return false
    value=value.trim() if value?
    @isValueEmpty(value) or value.length >= options.min

  ERROR_MESSAGE: Tent.messages.MIN_LENGTH

###*
* @class Tent.Validations.maxLength Validates that the value is less than or equal to a defined length
###
Tent.Validations.maxLength = Tent.Validation.create
  ###*
  * @method validate
  * @param {String} value the value to test
  * @param {Object} options the options to pass to the validation. options must contain a 
  * 'max' value
  * @param {String} message an optional message to display if the validation fails
  * @return {Boolean} the result of the validation
  ###
  validate: (value, options, message)->
    if not options? or not options.max?
      return false
    value=value.trim() if value?
    @isValueEmpty(value) or value.length <= options.max

  ERROR_MESSAGE: Tent.messages.MAX_LENGTH

###*
* @class Tent.Validations.regExp Validates that the value matches a regular expression
###
Tent.Validations.regExp = Tent.Validation.create
  ###*
  * @method validate
  * @param {String} value the value to test
  * @param {Object} options the options to pass to the validation. options must contain a 'regexp' property
  * @param {String} message an optional message to display if the validation fails
  * @return {Boolean} the result of the validation
  ###
  validate: (value, options, message)->
    if not options? or not options.regexp?
      return false
    message = if(not message? and options.message?) then options.message else Tent.messages.REG_EXP
    @set('ERROR_MESSAGE', message) if message?
    @isValueEmpty(value) or options.regexp.test(value)

  ERROR_MESSAGE: Tent.messages.REG_EXP

###*
* @class Tent.Validations.valueBetween Validates that the value is between two numbers
###
Tent.Validations.valueBetween = Tent.Validation.create
  ###*
  * @method validate
  * @param {String} value the value to test
  * @param {Object} options the options to pass to the validation. options must contain either a 
  * 'min' or a 'max' value or both
  * @param {String} message an optional message to display if the validation fails
  * @return {Boolean} the result of the validation
  ###
  validate: (value, options, message)->
    if not options? or not (options.min? or options.max?)
      return false
    message = if(not message? and options.message?) then options.message
    if value
      if options.min? and options.min>value
        message = Tent.messages.MIN_VALUE_ERROR unless message
        @set('ERROR_MESSAGE', message) if message?
        false
      else if options.max? and options.max<value
        message = Tent.messages.MAX_VALUE_ERROR unless message
        @set('ERROR_MESSAGE', message) if message?
        false
      else
        true
    else 
      true

  ERROR_MESSAGE: Tent.messages.VALUE_BETWEEN_ERROR

###*
* @class Tent.Validations.positive Validates that the value is positive (>= 0)
###
Tent.Validations.positive = Tent.Validation.create
  ###*
  * @method validate
  * @param {String} value the value to test
  * @param {Object} options the options to pass to the validation. options must contain either a 
  * 'min' or a 'max' value or both
  * @param {String} message an optional message to display if the validation fails
  * @return {Boolean} the result of the validation
  ###
  validate: (value, options, message) ->
    message = if(not message? and options? and options.message?) then options.message
    value = Tent.Formatting.amount.unformat(value)
    if @isValueEmpty(value) or value >= 0
      true
    else
      false

  ERROR_MESSAGE: Tent.messages.POSITIVE_ERROR

