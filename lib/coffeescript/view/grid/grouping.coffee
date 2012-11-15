

Tent.JqGrid.Grouping = Ember.Object.create
	ranges:
		default: 
			name: 'exact'
			title: Tent.I18n.loc 'grouping.range.exact'
			comparator: 
				compare: (last, value) ->
					return last == value
		date: [
			{
				name: 'exact'
				title: Tent.I18n.loc  'grouping.range.exact'
			}
			{
				name: 'week'
				title: Tent.I18n.loc 'grouping.range.week'
			}
			{
				name: 'month'
				title: Tent.I18n.loc 'grouping.range.month'
			}
			{
				name: 'quarter'
				title: Tent.I18n.loc 'grouping.range.quarter'
			}
			{
				name: 'year'
				title: Tent.I18n.loc 'grouping.range.year'
			}
		]
		string: [
			{
				name: 'exact'
				title: Tent.I18n.loc 'grouping.range.exact'
				
			}
		]
		number: [
			{
				name: 'exact'
				title: Tent.I18n.loc 'grouping.range.exact'
			}
			{
				name: '10s'
				title: Tent.I18n.loc 'grouping.range.tens'
				comparator: 
					compare: (last, value) ->
						lower = last - (last%10)
						upper = lower + 9
						return lower <= value <= upper
					rowTitle: (value)->
						lower = value - (value%10)
						upper = lower + 9
						return lower + ' - ' + upper
			}
		]
		boolean: [
			{
				name: 'exact'
				title: Tent.I18n.loc 'grouping.range.exact'
				comparator: 
					compare: (last, value) ->
						return last == value
			}
		]

