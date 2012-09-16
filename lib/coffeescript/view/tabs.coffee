require '../template/tabs'

Tent.Tabs = Ember.View.extend
	layoutName: 'tabs'
	didInsertElement: ->
		@.$("a[#" + @get("active") + "]").tab("show")

Tent.TabPane = Ember.View.extend
	classNames: ["tab-pane"]
	layout: Ember.Handlebars.compile '{{yield}}'

	didInsertElement: ->
		@get('parentView').$('ul').append('<li><a href="#' + @get('elementId')+ '" data-toggle="tab">'+@get('title')+'</a></li>')
		if @get('parentView.active') == @get('elementId')
			@getTabWithHref(@get("parentView.active")).tab("show")

	getTabWithHref: (href) ->
		@get('parentView').$("a[href=#" + href + "]")		