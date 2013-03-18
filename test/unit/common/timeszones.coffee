
setup = ->
teardown = ->

module 'Tent.TIMEZONES', setup, teardown

test 'Get abbreviated timezone', ->
	equal Tent.Date.getAbbreviatedTZ('GMT+0530', 'India Standard Time'), 'IST', 'returns the closest match of the timezone name string provided for the given utc offset'
	equal Tent.Date.getAbbreviatedTZ('GMT+0530'), null, 'returns null if no name string is provided and more than one zones exist for the given utc offset'
	equal Tent.Date.getAbbreviatedTZ('GMT-1200'), 'BIT', 'returns appropriate tz abbreviation if only one zone exists with the given offset and no name string is provided'
	equal Tent.Date.getAbbreviatedTZ('GMT++'), null, 'returns null if given tz is not valid'
	equal Tent.Date.getAbbreviatedTZ(), null, 'returns null if UTC offset is not provided'

test 'Get full timezone', ->
	equal Tent.Date.getFullTZ('GMT+0530', 'IST'), 'Indian Standard Time', 'returns the full timezone wrt the utc offset and abbreviation provided'
	equal Tent.Date.getFullTZ('GMT+0500'), null, 'returns null if more than one zones exist for the given utc offset and no abbreviation is provided'
	equal Tent.Date.getFullTZ('GMT-1200'), 'Baker Island Time','returns appropriate full zone name if one one zone exists with the given UTC offset'
	equal Tent.Date.getFullTZ(), null, 'returns null if UTC offset is not provided'