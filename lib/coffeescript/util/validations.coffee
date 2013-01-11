# APi for validation
#Tent.Validations.get('Capitalize').validate(value, options, message)

Tent.Validations = Ember.Object.create()

Tent.Validation = Ember.Object.extend
	ERROR_MESSAGE: Tent.messages.GENERIC_ERROR

	isValueEmpty: (value) ->
		not (value? && value != '')

	getErrorMessage: (value, options)->
		Tent.I18n.loc(@get('ERROR_MESSAGE'),options || [])

Tent.Validations.email = Tent.Validation.create
	validate: (value, options, message)-> 
		pattern = /^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$/i;
		isValid = (@isValueEmpty(value) or pattern.test(value))

	ERROR_MESSAGE: Tent.messages.EMAIL_FORMAT_ERROR


Tent.Validations.datebetween = Tent.Validation.create
	validate: (value, options, message)->
		if not options? or not options.startDate? or not options.endDate?
			return false
		isValid = @isValueEmpty(value) or (@convertToDate(value) > @convertToDate(options.startDate) and @convertToDate(value) < @convertToDate(options.endDate))

	convertToDate: (value) ->
		if not (value instanceof Date)
			return new Date(value)
		value

	ERROR_MESSAGE: Tent.messages.DATE_BETWEEN_ERROR

Tent.Validations.futuredate = Tent.Validation.create
	validate: (value, options, message) ->
		today = new Date()
		if not @isValueEmpty(value) and @convertToDate(value) > today
			return false
		true

	convertToDate: (value) ->
		if not (value instanceof Date)
			return Tent.Formatting.date.unformat(value)
		value

	ERROR_MESSAGE: Tent.messages.DATE_FUTURE_ERROR

Tent.Validations.minLength = Tent.Validation.create
  validate: (value, options, message)->
    if not options? or not options.min?
      return false
    value=value.trim() if value?
    @isValueEmpty(value) or value.length >= options.min

  ERROR_MESSAGE: Tent.messages.MIN_LENGTH

Tent.Validations.maxLength = Tent.Validation.create
  validate: (value, options, message)->
    if not options? or not options.max?
      return false
    value=value.trim() if value?
    @isValueEmpty(value) or value.length <= options.max

  ERROR_MESSAGE: Tent.messages.MAX_LENGTH

Tent.Validations.regExp = Tent.Validation.create
  validate: (value, options, message)->
    if not options? or not options.regexp?
      return false
    message = if(not message? and options.message?) then options.message else Tent.messages.REG_EXP
    @set('ERROR_MESSAGE', message) if message?
    @isValueEmpty(value) or options.regexp.test(value)

  ERROR_MESSAGE: Tent.messages.REG_EXP
