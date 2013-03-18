###*
* @class Tent.Date
* This has methods used to fetch data associated with dates and timezones, given some information
###
Tent.Date = Ember.Object.create

	#Finds time zone abbreviation according to the standard timezones list. 
	#Finds the closest match of the name string supplied from the given list 
	#if more than one timezones exist for the given UTCOffset
	getAbbreviatedTZ: (UTCOffset, name="")->
		return null unless UTCOffset?
		zones = Tent.TIMEZONES.filter (item) ->
				item["UTCOffset"] is UTCOffset
		if zones.length
			if zones.length is 1
				return zones[0].abbr
			zone = zones.find (item)->
					item.name == name
			if zone
				return zone.abbr
			else
				zones.forEach (item)->
					str = item.name
					i = 0
					while (str[i] == name[i] and i<str.length and i<name.length)
						i+=1
					item.index = i
				indices = zones.mapProperty('index')
				min = Math.max.apply(Math, indices)
				if min is 0 then null else zones[indices.indexOf(min)].abbr
		else
			null

	#Finds full time zone name from the given UTCOffset
	#If there are more than one timezones for the given offset, it matches the
	#available abbreviation if provided, returns null otherwise
	getFullTZ: (UTCOffset, abbr="")->
		return null unless UTCOffset?
		zones = Tent.TIMEZONES.filter (item) ->
				item["UTCOffset"] is UTCOffset
		if zones.length is 1
			return zones[0].name
		zone = zones.find (item) ->
			item.abbr == abbr
		if zone then zone.name else null		