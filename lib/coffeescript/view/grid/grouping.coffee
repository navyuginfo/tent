
###*
* @class Tent.JqGrid.Grouping
* Provides configuration options for grouping by column values and comparators for defining
* grouping ranges.
*
###

Tent.JqGrid.Grouping = Ember.Object.extend()

###*
* @method getComparator returns a comparator to use for a combination of datatype and grouping type
* @param {String} dataType the type of the column which is defining the grouping e.g. 'date'
* @param {String} groupType the type of grouping to perform e.g. 'month'  
###
Tent.JqGrid.Grouping.getComparator = (dataType, groupType)->
		comparator = @ranges.get('default')().comparator
		if not @ranges.get(dataType)?
			dataType = "string"
			#throw new Error('Invalid data type for grid grouping.')
		for type in @ranges.get(dataType)()
			if type.name == groupType
				comparator = type.comparator if type.comparator?
		comparator 

###*
* @class Tent.JqGrid.Grouping.comparator
* A base class for providing custom comparison functions for determining if values lie in a particular range.
###
Tent.JqGrid.Grouping.comparator = Ember.Object.extend
	###*
	* @method compare Test whether a value lies in the same range as another.
	* @param {Object} firstValue The value defining the range to use in the test
	* @param {Object} testValue The value to test
	* @param {Boolean} The result of the test
	###
	compare: (firstValue, testValue) ->
		return firstValue == testValue

	###*
	* @method rowTitle Returns the text to display as the first interpolation of the group row text
	* @param {Object} value the value which is used to determine the range
	###
	rowTitle: (value, formatter)->
		if value? 
			if formatter? then formatter(value) else value	 
		else 
			''	


Tent.JqGrid.Grouping.helper = Ember.Object.create
	numeric: 
		calculateName: (value) ->
			"" + (Tent.Formatting.number.serializer?.serialize(value) or value)
		rowTitle: (value, formatter)->
			if not formatter? then formatter = Tent.Formatting.number.format
			if (typeof value == "string")
				value = Tent.Formatting.number.unformat(value)
			@calculateRange(value)
			return formatter(@get('lower')) + ' - ' + formatter(@get('upper'))
		compare: (last, value) ->
			@calculateRange(last)
			return @get('lower') <= value <= @get('upper')
		calculateRange: (range)->
			return (value)->
				if value >= 0
					lower = value - (value%range)
					upper = lower + (range-1)
				else 
					if value%range == 0
						lower = value
						upper = value + (range - 1)
					else
						upper = -1 + value - (value%range) 
						lower = upper - (range - 1)
				@set('lower',lower)
				@set('upper', upper)
	amount: 
		rowTitle: (value, formatter)->
			if value? 
				if formatter? then formatter(value) else Tent.Formatting.amount.format(value) 
			else 
				''

		rangeRowTitle: (value, formatter)->
			if not formatter? then formatter = Tent.Formatting.amount.format
			if (typeof value == "string")
				value = Tent.Formatting.amount.unformat(value)
			@calculateRange(value)
			return formatter(@get('lower')) + ' - ' + formatter(@get('upper'))

###*
* @property {Object} Tent.JqGrid.Grouping.ranges A collection of range definitions which provide titles, comparators etc for particular types
###
Tent.JqGrid.Grouping.ranges = Ember.Object.create
		default: -> 
			name: 'exact'
			title: Tent.I18n.loc 'tent.grouping.range.exact'
			comparator: Tent.JqGrid.Grouping.comparator.create()

		###*
		* @class Tent.JqGrid.Grouping.ranges.date
		###
		date: ->
			[

				{
					###*
					* @property {Object} exact group dates which are the same
					###
					name: 'exact'
					title: Tent.I18n.loc  'tent.grouping.range.exact'
					comparator: Tent.JqGrid.Grouping.comparator.create
						compare: (last, value) ->
							return last.compareTo(value) == 0	
				}
				{
					###*
					* @property {Object} week group dates which occur in the same week
					###
					name: 'week'
					title: Tent.I18n.loc 'tent.grouping.range.week'
					comparator: Tent.JqGrid.Grouping.comparator.create
						compare: (last, value)->
							if (last.getFullYear() == value.getFullYear()) and (last.getWeekOfYear() == value.getWeekOfYear())
								return true
							if (last.compareTo(value) == -1) #ascending
								if (last.getFullYear()+1 == value.getFullYear()) and (last.getWeekOfYear() == value.getWeekOfYear()) and (last.getMonth() == 11) and (value.getMonth() == 0)
									return true
							if (last.compareTo(value) == 1) #descending
								if (last.getFullYear()-1 == value.getFullYear()) and (last.getWeekOfYear() == value.getWeekOfYear()) and (last.getMonth() == 0) and (value.getMonth() == 11)
									return true
						rowTitle: (value, formatter)->
							if not formatter? then formatter = Tent.Formatting.date.format

							if (typeof value == "string")
									value = Tent.Formatting.date.unformat(value)
								week = value.getWeekOfYear()
								yesterday = value
								while week == yesterday.getWeekOfYear()
									yesterday.add(-1).day()

							"#{Tent.I18n.loc('tent.grouping.range.weekStarting')} #{formatter(yesterday.add(1).day())}"

				}
				{
					###*
					* @property {Object} month group dates which occur in the same month
					###
					name: 'month'
					title: Tent.I18n.loc 'tent.grouping.range.month'
					comparator: Tent.JqGrid.Grouping.comparator.create
						compare: (last, value)->
							(last.getFullYear() == value.getFullYear()) and (last.getMonth() == value.getMonth())
						rowTitle: (value)->
							if (typeof value == "string")
								value = Tent.Formatting.date.unformat(value)
							Tent.Formatting.date.format(value,'MM') + ' ' + value.getFullYear()
				}
				{
					###*
					* @property {Object} quarter group dates which occur in the same quarter
					###
					name: 'quarter'
					title: Tent.I18n.loc 'tent.grouping.range.quarter'
					comparator: Tent.JqGrid.Grouping.comparator.create
						compare: (last, value)->
							quarter = Math.floor(last.getMonth()/3) + 1
							(last.getFullYear() == value.getFullYear()) and ((quarter-1) * 3) <= value.getMonth() <= ((quarter-1) * 3) + 2
			
						rowTitle: (value)->
							if (typeof value == "string")
								value = Tent.Formatting.date.unformat(value)
							quarter = Math.floor(value.getMonth()/3) + 1
							'Quarter ' + quarter + ', ' + value.getFullYear()

				}
				{
					###*
					* @property {Object} year group dates which occur in the same year
					###
					name: 'year'
					title: Tent.I18n.loc 'tent.grouping.range.year'
					comparator: Tent.JqGrid.Grouping.comparator.create
						compare: (last, value)->
							last.getFullYear() == value.getFullYear()
						rowTitle: (value)->
							if (typeof value == "string")
								value = Tent.Formatting.date.unformat(value)
							'Year = ' + value.getFullYear()
				}
			]
		###*
		* @class Tent.JqGrid.Grouping.ranges.string
		###
		string: ->
			[
				{
					###*
					* @property {Object} exact group string which are the same
					###
					name: 'exact'
					title: Tent.I18n.loc 'tent.grouping.range.exact'
					comparator: Tent.JqGrid.Grouping.comparator.create()
				}
			]
		###*
		* @class Tent.JqGrid.Grouping.ranges.number
		###
		number: ->
			[
				{
					###*
					* @property {Object} exact group numbers which are the same
					###
					name: 'exact'
					title: Tent.I18n.loc 'tent.grouping.range.exact'
					comparator: Tent.JqGrid.Grouping.comparator.create()
				}
				{
					###*
					* @property {Object} 10s group numbers in ranges of ten
					###
					name: Tent.JqGrid.Grouping.helper.numeric.calculateName(10)
					title: Tent.I18n.loc 'tent.grouping.range.tens'
					comparator: Tent.JqGrid.Grouping.comparator.create
						lower: null
						upper: null
						compare: Tent.JqGrid.Grouping.helper.numeric.compare
						rowTitle: Tent.JqGrid.Grouping.helper.numeric.rowTitle
						calculateRange: Tent.JqGrid.Grouping.helper.numeric.calculateRange(10)
				}
				{
					###*
					* @property {Object} 100s group numbers in ranges of hundreds
					###
					name: Tent.JqGrid.Grouping.helper.numeric.calculateName(100)
					title: Tent.I18n.loc 'tent.grouping.range.hundreds'
					comparator: Tent.JqGrid.Grouping.comparator.create
						lower: null
						upper: null
						compare: Tent.JqGrid.Grouping.helper.numeric.compare
						rowTitle: Tent.JqGrid.Grouping.helper.numeric.rowTitle
						calculateRange: Tent.JqGrid.Grouping.helper.numeric.calculateRange(100)
				}
				{
					###*
					* @property {Object} 100s group numbers in ranges of thousands
					###
					name: Tent.JqGrid.Grouping.helper.numeric.calculateName(1000)
					title: Tent.I18n.loc 'tent.grouping.range.thousands'
					comparator: Tent.JqGrid.Grouping.comparator.create
						lower: null
						upper: null
						compare: Tent.JqGrid.Grouping.helper.numeric.compare
						rowTitle: Tent.JqGrid.Grouping.helper.numeric.rowTitle
						calculateRange: Tent.JqGrid.Grouping.helper.numeric.calculateRange(1000)
				}
			]

		###*
		* @class Tent.JqGrid.Grouping.ranges.amount
		###
		amount: ->
			[
				{
					###*
					* @property {Object} exact group amounts which are the same
					###
					name: 'exact'
					title: Tent.I18n.loc 'tent.grouping.range.exact'
					comparator: Tent.JqGrid.Grouping.comparator.create
						rowTitle: Tent.JqGrid.Grouping.helper.amount.rowTitle
				}
				{
					###*
					* @property {Object} 10s group amounts in ranges of ten
					###
					name: Tent.JqGrid.Grouping.helper.numeric.calculateName(10)
					title: Tent.I18n.loc 'tent.grouping.range.tens'
					comparator: Tent.JqGrid.Grouping.comparator.create
						lower: null
						upper: null
						compare: Tent.JqGrid.Grouping.helper.numeric.compare
						rowTitle: Tent.JqGrid.Grouping.helper.amount.rangeRowTitle
						calculateRange: Tent.JqGrid.Grouping.helper.numeric.calculateRange(10)
						 
				}
				{
					###*
					* @property {Object} 100s group amounts in ranges of hundreds
					###
					name: Tent.JqGrid.Grouping.helper.numeric.calculateName(100)
					title: Tent.I18n.loc 'tent.grouping.range.hundreds'
					comparator: Tent.JqGrid.Grouping.comparator.create
						lower: null
						upper: null
						compare: Tent.JqGrid.Grouping.helper.numeric.compare
						rowTitle: Tent.JqGrid.Grouping.helper.amount.rangeRowTitle
						calculateRange: Tent.JqGrid.Grouping.helper.numeric.calculateRange(100)
				}
				{
					###*
					* @property {Object} 100s group amounts in ranges of thousands
					###
					name: Tent.JqGrid.Grouping.helper.numeric.calculateName(1000)
					title: Tent.I18n.loc 'tent.grouping.range.thousands'
					comparator: Tent.JqGrid.Grouping.comparator.create
						lower: null
						upper: null
						compare: Tent.JqGrid.Grouping.helper.numeric.compare
						rowTitle: Tent.JqGrid.Grouping.helper.amount.rangeRowTitle
						calculateRange: Tent.JqGrid.Grouping.helper.numeric.calculateRange(1000)
				}
			]

		###*
		* @class Tent.JqGrid.Grouping.ranges.boolean
		###
		boolean: ->
			[
				{
					###*
					* @property {Object} exact group boleans which have the same value
					###
					name: 'exact'
					title: Tent.I18n.loc 'tent.grouping.range.exact'
					comparator: Tent.JqGrid.Grouping.comparator.create()
				}
			]

 
###*
* @class Tent.JqGrid.Grouping.ranges.utcdate
###
Tent.JqGrid.Grouping.ranges.utcdate = Tent.JqGrid.Grouping.ranges.date


