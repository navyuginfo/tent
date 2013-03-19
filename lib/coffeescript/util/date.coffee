###*
* @class Tent.Date
* This class has methods used to fetch data associated with dates and timezones.
  Private methods used for getting UTCOffset, timezone name or abbreviations using different combinations of data available.
  A "zone" object = A javascript object having timezone name, abbreviation and UTCOffset
###
Tent.Date = Ember.Object.create
	###*
	* @method getAbbreviatedTZFromUTCOffsetAndName Returns time zone abbreviation
	(closest match of the supplied name string is considered as full names of timezones 
	might be different from what is in the Tent list). 
	Returns null if UTCOffset is missing
	* @param {String} UTCOffset string of type : "GMT+0400"
	* @param {String} name Optional argument which is the full name of timezone
	* @return {String}
	###
	getAbbreviatedTZFromUTCOffsetAndName: (UTCOffset, name="")->
		return null unless UTCOffset?
		zones = getZonesFromUTCOffset(UTCOffset)
		zone = (if zones.length is 1 then zones[0] else filterZoneUsingTZName(zones, name))
		if zone then zone['abbr'] else null

	###*
	* @method getFullTZFromUTCOffsetAndAbbreviation Returns timezone name, returns null if UTC Offset is missing
	* @param {String} UTCOffset string of type : "GMT+0400" (Required)
	* @param {String} abbr Timezone abbreviation of type: "IST" (Optional)
	* @return {string}
	###
	getFullTZFromUTCOffsetAndAbbreviation: (UTCOffset, abbr="")->
		return null unless UTCOffset?
		zones = getZonesFromUTCOffset(UTCOffset)
		zone = (if zones.length is 1 then zones[0] else filterZoneUsingTZAbbreviation(zones, abbr)) if zones.length
		if zone then zone['name'] else null

	###*
	* @method getAbbreviatedTZFromDate Returns timezone abbreviation, returns null if date is missing
	* @param {Date Object} date (Required)
	* @return {string}
	###
	getAbbreviatedTZFromDate: (date)->
		return null unless date?
		dateString = date.toLongDateString()
		tz = dateString.substring(35,dateString.length-1)
		if tz.split(" ").length != 1 then Tent.Date.getAbbreviatedTZFromUTCOffsetAndName(dateString.substring(25,33), tz) else tz

	###*
	* @method getFullTZFromDate Returns timezone name, returns null if date is missing
	* @param {Date Object} date (Required)
	* @return {String}
	###
	getFullTZFromDate: (date)->
		return null unless date?
		dateString = date.toLongDateString()
		tz = dateString.substring(35,dateString.length-1)
		if tz.split(" ").length != 1 then tz else Tent.Date.getFullTZFromUTCOffsetAndAbbreviation(dateString.substring(25,33), tz)
		
	###*
	* @method getUTCOffsetFromTZ Returns UTCOffset given the timezone abbreviation and name. 
	* If name is not provided and there are more than one records with the given abbreviation,
	* null will be returned
	* @param {String} abbr (Required)
	* @param {String} name (Optional)
	* @return {String}
	###
	getUTCOffsetFromTZ: (abbr, name) ->
		return null unless abbr?
		zones = getZonesFromAbbreviation(abbr)
		zone = (if zones.length is 1 then zones[0] else (if name? then filterZoneUsingTZName(zones, name) else null))
		if zone then zone['UTCOffset'] else null




###*
* @method filterZoneUsingTZAbbreviation (PRIVATE) Returns a zone object from an array of zone objects 
 if the given abbreviation matches any of the object abbreviations
 returns null if a list of 'zone' objects or abbreviation is not provided
* @param {Array of Zone Objects} zones
* @param {String} abbr
* @return {Object} Zone object
###
filterZoneUsingTZAbbreviation = (zones, abbr)->
	return null unless zones? or zones.length>0 or abbr?
	zones.find (item) ->
		item.abbr == abbr

###*
* @method filterZoneUsingTZName (PRIVATE) Returns an zone object from an array of zone objects
  if the given name exactly or almost matches any of the object names 
  (has the scope of "almost matching strings" as the name may not exactly match the ones in the Tent list)
  returns null if the list of 'zone' objects or name is not provided
* @param {Array of Zone Objects} zones
* @param {String} name
* @return {Object} Zone object
###
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

###*
* @method getZonesFromUTCOffset (PRIVATE) Returns an array list of zone objects which have the given UTCOffset
* @param {String} UTCOffset 
* @return {Object} Zone object
###
getZonesFromUTCOffset = (UTCOffset)->
	Tent.TIMEZONES.filter (item) ->
		item["UTCOffset"] is UTCOffset

###* 
* @method getZonesFromAbbreviation (PRIVATE) Returns an array list of zone objects which have the given abbreviation
* @param {String} abbr
* @return {Object} Zone object
###
getZonesFromAbbreviation = (abbr)->
  	Tent.TIMEZONES.filter (item) ->
  		item["abbr"] is abbr