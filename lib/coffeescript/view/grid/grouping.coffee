Tent.JqGrid.Grouping = Ember.Object.extend

Tent.JqGrid.Grouping.comparator = Ember.Object.extend
	compare: (last, value) ->
		return last == value
	rowTitle: (value)->
		value

Tent.JqGrid.Grouping.getComparator = (dataType, groupType)->
		comparator = @ranges.default.comparator
		if not @ranges[dataType]?
			throw new Error('Invalid data type for grid grouping.')
		for type in @ranges[dataType]
			if type.name == groupType
				comparator = type.comparator if type.comparator?
		comparator 

Tent.JqGrid.Grouping.ranges = Ember.Object.create
		default: 
			name: 'exact'
			title: Tent.I18n.loc 'grouping.range.exact'
			comparator: Tent.JqGrid.Grouping.comparator.create()

		date: [
			{
				name: 'exact'
				title: Tent.I18n.loc  'grouping.range.exact'
				comparator: Tent.JqGrid.Grouping.comparator.create
					compare: (last, value) ->
						return last.compareTo(value) == 0
			}
			{
				name: 'week'
				title: Tent.I18n.loc 'grouping.range.week'
				comparator: Tent.JqGrid.Grouping.comparator.create
					compare: (last, value)->
						(last.getFullYear() == value.getFullYear()) and (last.getWeek() == value.getWeek())
					rowTitle: (value)->
						date = Tent.Formatting.date.unformat(value)
						'Week ' + date.getWeek() + ', ' + date.getFullYear()
			}
			{
				name: 'month'
				title: Tent.I18n.loc 'grouping.range.month'
				comparator: Tent.JqGrid.Grouping.comparator.create
					compare: (last, value)->
						(last.getFullYear() == value.getFullYear()) and (last.getMonth() == value.getMonth())
					rowTitle: (value)->
						date = Tent.Formatting.date.unformat(value)
						Tent.Formatting.date.format(date,'MM') + ' ' + date.getFullYear()
			}
			{
				name: 'quarter'
				title: Tent.I18n.loc 'grouping.range.quarter'
				comparator: Tent.JqGrid.Grouping.comparator.create
					compare: (last, value)->
						quarter = Math.floor(last.getMonth()/3) + 1
						(last.getFullYear() == value.getFullYear()) and ((quarter-1) * 3) <= value.getMonth() <= ((quarter-1) * 3) + 2
						
					rowTitle: (value)->
						date = Tent.Formatting.date.unformat(value)
						quarter = Math.floor(date.getMonth()/3) + 1
						'Quarter ' + quarter + ', ' + date.getFullYear()
			}
			{
				name: 'year'
				title: Tent.I18n.loc 'grouping.range.year'
				comparator: Tent.JqGrid.Grouping.comparator.create
					compare: (last, value)->
						last.getFullYear() == value.getFullYear()
					rowTitle: (value)->
						'Year = ' + Tent.Formatting.date.unformat(value).getFullYear()
			}
		]
		string: [
			{
				name: 'exact'
				title: Tent.I18n.loc 'grouping.range.exact'
				comparator: Tent.JqGrid.Grouping.comparator.create()
			}
		]
		number: [
			{
				name: 'exact'
				title: Tent.I18n.loc 'grouping.range.exact'
				comparator: Tent.JqGrid.Grouping.comparator.create()
			}
			{
				name: '10s'
				title: Tent.I18n.loc 'grouping.range.tens'
				comparator: Tent.JqGrid.Grouping.comparator.create
					lower: null
					upper: null
					compare: (last, value) ->
						@calculateRange(last)
						return @get('lower') <= value <= @get('upper')

					rowTitle: (value)->
						value = parseFloat(value)
						@calculateRange(value)
						return @get('lower') + ' - ' + @get('upper')

					calculateRange: (value)->
						if value >= 0
							lower = value - (value%10)
							upper = lower + 9
						else 
							if value%10 == 0
								lower = value
								upper = value + 9
							else
								upper = -1 + value - (value%10) 
								lower = upper - 9
						@set('lower',lower)
						@set('upper', upper)
			}
		]
		boolean: [
			{
				name: 'exact'
				title: Tent.I18n.loc 'grouping.range.exact'
				comparator: Tent.JqGrid.Grouping.comparator.create()
			}
		]

