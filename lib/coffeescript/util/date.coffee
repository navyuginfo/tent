###*
* @class Tent.Date
* This has methods used to fetch data associated with dates and timezones
###
( ->
	Tent.Date = Ember.Object.create

		#Returns time zone abbreviation(closest match of the supplied 
		#name string is considered as full names of timezones might be different from what is in the Tent list)
		#Required argument: UTCOffset, Optional argument: name
		#Returns null if UTCOffset is missing
		getAbbreviatedTZFromUTCOffsetAndName: (UTCOffset, name="")->
			return null unless UTCOffset?
			zones = getZonesFromUTCOffset(UTCOffset)
			zone = (if zones.length is 1 then zones[0] else filterZoneUsingTZName(zones, name))
			if zone then zone['abbr'] else null

		#Returns timezone name
		#Required argument: UTCOffset, Optional argument: timezone abbreviation
		#Returns null if UTC Offset is missing
		getFullTZFromUTCOffsetAndAbbreviation: (UTCOffset, abbr="")->
			return null unless UTCOffset?
			zones = getZonesFromUTCOffset(UTCOffset)
			zone = (if zones.length is 1 then zones[0] else filterZoneUsingTZAbbreviation(zones, abbr)) if zones.length
			if zone then zone['name'] else null

		#Returns timezone abbreviation
		#Required argument: Date object
		#Returns null if date is missing
		getAbbreviatedTZFromDate: (date)->
			return null unless date?
			dateString = date.toLongDateString()
			tz = dateString.substring(35,dateString.length-1)
			if tz.split(" ").length != 1 then Tent.Date.getAbbreviatedTZFromUTCOffsetAndName(dateString.substring(25,33), tz) else tz

		#Returns timezone name
		#Required argument: Date object
		#Returns null if date is missing
		getFullTZFromDate: (date)->
			return null unless date?
			dateString = date.toLongDateString()
			tz = dateString.substring(35,dateString.length-1)
			if tz.split(" ").length != 1 then tz else Tent.Date.getFullTZFromUTCOffsetAndAbbreviation(dateString.substring(25,33), tz)
			
		#Returns UTCOffset given the timezone abbreviation and name
		#Required argument abbr, Optional argument: name 
		#If name is not provided and there are more than one records with the given abbreviation,
		#null will be returned
		getUTCOffsetFromTZ: (abbr, name) ->
			return null unless abbr?
			zones = getZonesFromAbbreviation(abbr)
			zone = (if zones.length is 1 then zones[0] else (if name? then filterZoneUsingTZName(zones, name) else null))
			if zone then zone['UTCOffset'] else null


	###*
	* Private methods used for getting UTCOffset, timezone name or abbreviations using different combinations of data available
	* A zone object = A javascript object having timezone name, abbreviation and UTCOffset
	###

	#returns a zone object from an array of zone objects
	#if the given abbreviation matches any of the object abbreviations
	#returns null if a list of 'zone' objects or abbreviation is not provided
	filterZoneUsingTZAbbreviation = (zones, abbr)->
		return null unless zones? or zones.length>0 or abbr?
		zones.find (item) ->
			item.abbr == abbr

	#returns an zone object from an array of zone objects
	#if the given name exactly or almost matches any of the object names 
	#(has the scope of "almost matching strings" as the name may not exactly match the ones in the Tent list)
	#returns null if the list of 'zone' objects or name is not provided
	filterZoneUsingTZName = (zones, name)->
		return null unless zones? or zones.length>0 or name? 
		zone = zones.find (item)->
			item.name == name
		unless zone
			zones.forEach (item)->
				str = item.name
				i = 0
				while (str[i] == name[i] and i<str.length and i<name.length)
					i+=1
				item.index = i
			indices = zones.mapProperty('index')
			min = Math.max.apply(Math, indices)
			zone = (if min is 0 then null else zones[indices.indexOf(min)])
		zone

	#returns an array list of zone objects which have the given UTCOffset
	getZonesFromUTCOffset = (UTCOffset)->
		Tent.TIMEZONES.filter (item) ->
			item["UTCOffset"] is UTCOffset

	#returns an array list of zone objects which have the given abbreviation
	getZonesFromAbbreviation = (abbr)->
	  	Tent.TIMEZONES.filter (item) ->
	  		item["abbr"] is abbr

)()