require '../template/tabs'

###*
* @class Tent.Tabs
* Display a group of {@link Tent.TabPane}s
*
* Usage 
*        {{#view Tent.Tabs active="settings"}}
              {{#view Tent.TabPane id="profile" title="_profile"}}
                  Lorem ipsum dolor sit amet, consectetur adipisicing elit.
              {{/view}}
              {{#view Tent.TabPane id="messages" title="_messages"}}
                  Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium,
              {{/view}}
              {{#view Tent.TabPane id="settings" title="_settings"}}
                  At vero eos et accusamus et iusto odio dignissimos ducimus
              {{/view}}
          {{/view}}
###
Tent.Tabs = Ember.View.extend
	layoutName: 'tabs'

	###*
	* @property {String} active The id of the tabpane which should be initially displayed
	###
	active: null
	didInsertElement: ->
		@.$("a[#" + @get("active") + "]").tab("show")

###*
* @class Tent.TabPane
* An individual tab pane to be displayed as part of a {@link Tent.Tabs}
*
* Usage 
*       {{#view Tent.TabPane id="profile" title="_profile"}}
            Lorem ipsum dolor sit amet, consectetur adipisicing elit.
        {{/view}}
###
Tent.TabPane = Ember.View.extend
	classNames: ["tab-pane"]
	layout: Ember.Handlebars.compile '{{yield}}'

	###*
	* @property {String} id The id of the pane. This should be unique for the page
	###
	id: null

	###*
	* @property {String} title The title for the pane. This title will be translated and displayed in a tab by the containing {@link Tent.Tabs}.	 
	###
	title: null	

	didInsertElement: ->
		title = Tent.I18n.loc(@get('title'))
		@get('parentView').$('ul').append('<li><a href="#' + @get('elementId')+ '" data-toggle="tab">' + title + '</a></li>')
		if @get('parentView.active') == @get('elementId')
			@getTabWithHref(@get("parentView.active")).tab("show")

	getTabWithHref: (href) ->
		@get('parentView').$("a[href=#" + href + "]")		