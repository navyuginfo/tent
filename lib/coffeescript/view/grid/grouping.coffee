

Tent.JqGrid.Grouping = Ember.Object.create
	ranges:
		default: 
			name: 'exact'
			title: 'grouping.range.exact'
			comparator: 
				compare: (last, value) ->
					return last != value
		date: [
			{
				name: 'exact'
				title: 'grouping.range.exact'
			}
			{
				name: 'week'
				title: 'grouping.range.week'
			}
			{
				name: 'month'
				title: 'grouping.range.month'
			}
			{
				name: 'quarter'
				title: 'grouping.range.quarter'
			}
			{
				name: 'year'
				title: 'grouping.range.year'
			}
		]
		string: [
			{
				name: 'exact'
				title: 'grouping.range.exact'
				
			}
		]
		number: [
			{
				name: 'exact'
				title: 'grouping.range.exact'
			}
			{
				name: '10s'
				title: 'grouping.range.tens'
				comparator: 
					compare: (last, value) ->
						lower = last - (last%10)
						upper = lower + 9
						return lower <= value <= upper
			}
		]
		boolean: [
			{
				name: 'exact'
				title: 'grouping.range.exact'
				comparator: 
					compare: (last, value) ->
						return last != value
			}
		]

