Tent.FilteringSupport = Ember.Mixin.create
	isFilter: false
	operators: [
		Ember.Object.create({label: "filter.beginsWith", operator: "begin"}),
		Ember.Object.create({label: "filter.contains", operator: "contain"}),
		Ember.Object.create({label: "filter.equal", operator: "equal"}),
		Ember.Object.create({label: "filter.nEqual", operator: "nequal"}),
	]

	init: ->
		@_super(arguments)
		#@set('selectedOperator', @get('filterValue.op'))

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

	valueDidChange: (->
		if @get('isFilter')
			@set('filterValue',[@get('value')]) 
	).observes('value')
	###



