Tent.Breadcrumb = Ember.View.extend
	router: null
	homeState: 'home'
	classNames: ['tent-breadcrumb']
	template: Ember.Handlebars.compile('{{#collection tagName="ul" contentBinding="view.content"}}
				<button class="btn btn-link" {{bindAttr data-state="view.content.name"}}>{{loc view.content.title}} <i class="icon-chevron-right"></i></button>
			{{/collection}}')
	init: ->
		@_super()
		@generateBreadcrumb()
	 
	generateBreadcrumb: (->
		if @get('router')?
			currentState = @get('router').get('currentState')
			path = []
			@addPathItem(currentState, path)
			while currentState.get('parentState')?
				currentState = currentState.get('parentState')
				if currentState?
					@addPathItem(currentState, path)

			@set('content', path.reverse())
	).observes('router.currentState')


	addPathItem: (state, arr)->
		if state.get('name')? and state.get('title')
			arr.push Ember.Object.create
				name: state.get('name')
				title: state.get('title')
		return arr

	click: (e)->
		state = $(e.target).attr("data-state");
		if state?
			@get('router').transitionTo(state)