Tent.FilteringSupport = Ember.Mixin.create
	isFilter: false
	operators: [
		Ember.Object.create({label: "tent.filter.beginsWith", operator: "begin"}),
		Ember.Object.create({label: "tent.filter.contains", operator: "contain"}),
		Ember.Object.create({label: "tent.filter.equal", operator: "equal"}),
		Ember.Object.create({label: "tent.filter.nEqual", operator: "nequal"})
	]

	init: ->
		@_super(arguments)
		
		#@set('selectedOperator', @get('filterValue.op'))

	didInsertElement: ->
		if @get('filter')
			@get('filter.values')[@get('id')] = {}

	###selectedOperator: (->
		if @get('filterValue')
			console.log "Setting selectedOperator" + @get('filterValue.op')
			@get('filterValue.op')
	).property('filterValue')
	###

	###filterValue: (->
		console.log @get('selectedOperator') + "  :  " + @get('value')
		return {op: @get('selectedOperator'), data: [@get('value')]}
	).property('selectedOperator', 'value')
	###
	
	###filterValueDidChange: (->
		if @get('isFilter')
			if @get('filterValue')
				@set('value', @get('filterValue')[0]) 
			else 
				@set('value', null) 
	).observes('filterValue')
	###
	filterDidChange: (->
		console.log 'filter changed'
	).observes('filter')
	



