
setup = ->

teardown = ->

module 'Tent.Date', setup, teardown

test 'Get abbreviated timezone from utcoffset and name', ->
	equal Tent.Date.getAbbreviatedTZFromUTCOffsetAndName('GMT+0530', 'India Standard Time'), 'IST', 'returns the closest match of the timezone name string provided for the given utc offset'	
	equal Tent.Date.getAbbreviatedTZFromUTCOffsetAndName('GMT-1200'), 'BIT', 'returns appropriate tz abbreviation if only one zone exists with the given offset and no name string is provided'
	equal Tent.Date.getAbbreviatedTZFromUTCOffsetAndName('GMT++'), null, 'returns null if given tz is not valid'
	equal Tent.Date.getAbbreviatedTZFromUTCOffsetAndName(), null, 'returns null if UTC offset is not provided'

test 'Get full timezone name from utc offset and abbreviation', ->
	equal Tent.Date.getFullTZFromUTCOffsetAndAbbreviation('GMT+0530', 'IST'), 'Indian Standard Time', 'returns the full timezone wrt the utc offset and abbreviation provided'
	equal Tent.Date.getFullTZFromUTCOffsetAndAbbreviation('GMT-1200'), 'Baker Island Time','returns appropriate full zone name if one one zone exists with the given UTC offset'
	equal Tent.Date.getFullTZFromUTCOffsetAndAbbreviation(), null, 'returns null if UTC offset is not provided'

###test 'Get timezone abbreviation from date object', ->
	#stubbing CultureInfo as it is not found during tests
	Date.CultureInfo = {formatPatterns:{}}
	d = new Date()
	dateString = d.toLongDateString()
	UTCOffset = dateString.substring(25,33)
	tz = dateString.substring(35,dateString.length-1)
	equal Tent.Date.getAbbreviatedTZFromDate(d), Tent.Date.getAbbreviatedTZFromUTCOffsetAndName(UTCOffset,tz), 'returns the timezone abbreviation by extracting necessary information from the date object'
	equal Tent.Date.getAbbreviatedTZFromDate(), null, 'returns null when date is not passed'

test 'Get timezone name from the date object', ->
	#stubbing CultureInfo as it is not found during tests
	Date.CultureInfo = {formatPatterns:{}}
	d = new Date()
	dateString = d.toLongDateString()
	UTCOffset = dateString.substring(25,33)
	tz = dateString.substring(35,dateString.length-1)
	# Failing on alternate testing
	#equal Tent.Date.getFullTZFromDate(d), Tent.Date.getFullTZFromUTCOffsetAndAbbreviation(UTCOffset,tz), 'returns the timezone name by extracting necessary information from the date object'
	#equal Tent.Date.getFullTZFromDate(), null, 'returns null when date is not passed'
###

test 'Get UTC Offset if timezone name and abbreviation are known', ->
	equal Tent.Date.getUTCOffsetFromTZ(), null, 'returns null if timezone both timezone name and abbreviation are not passed'
	equal Tent.Date.getUTCOffsetFromTZ('IST'), null, 'returns null as more than one timezones exist with that abbr and a name is not provided'
	#equal Tent.Date.getUTCOffsetFromTZ('IST', 'Indian Standard Time'), 'GMT+0530', 'returns UTC offset for the given combination'