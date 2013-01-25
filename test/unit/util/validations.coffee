
setup = ->
teardown = ->

module 'Tent.Validations', setup, teardown

test 'Basic validation', ->
	ok Tent.Validations.email.validate('a.b@c.com')
	ok not Tent.Validations.email.validate('a.c.com')


test 'Date between validation with parameters', ->
	value = new Date("11/11/2012")
	startDate = new Date("10/10/2012")
	endDate = new Date("12/12/2012")
	ok Tent.Validations.datebetween.validate(value, {startDate:startDate, endDate:endDate}), 'Should be Ok'

	value = new Date("9/9/2012")
	startDate = new Date("10/10/2012")
	endDate = new Date("12/12/2012")
	ok not Tent.Validations.datebetween.validate(value, {startDate:startDate, endDate:endDate}), 'Should be out of range'

	value = new Date("9/9/2012")
	ok not Tent.Validations.datebetween.validate(value), 'No options provided'

	value = new Date("11/11/2012")
	startDate = null
	endDate = new Date("12/12/2012")
	ok not Tent.Validations.datebetween.validate(value, {startDate:startDate, endDate:endDate}), 'Start date is null'

	value = new Date("11/11/2012")
	startDate = new Date("10/10/2012")
	endDate = null
	ok not Tent.Validations.datebetween.validate(value, {startDate:startDate, endDate:endDate}), 'End date is null'

	value = "11/11/2012"
	startDate = "10/10/2012"
	endDate = "12/12/2012"
	ok Tent.Validations.datebetween.validate(value, {startDate:startDate, endDate:endDate}), 'Dates are strings'

 
test 'Maximum length validations with params', ->
  #Validate max
  value = "AXS92234908203948092234"
  options = {max: 20}
  ok not Tent.Validations.maxLength.validate(value, options), '24 caracters string failed to validate'

  #Validate max
  value = "809223423423"
  options = {max: 20}
  ok Tent.Validations.maxLength.validate(value, options), '12 caracters string validated succesfully'

test "Positive Validations", ->
	equal Tent.Validations.positive.validate(2), true, 'Success'
	equal Tent.Validations.positive.validate(-2), false, '-1'
	equal Tent.Validations.positive.validate(0), true, 'zero'
	equal Tent.Validations.positive.validate(null), true, 'null'
	equal Tent.Validations.positive.validate(undefined), true, 'undefined'
	equal Tent.Validations.positive.validate(-.000072), false, 'fraction'





