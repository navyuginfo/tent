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
		@$().on("shown", 'a[data-toggle="tab"]', (e)=>
			$.publish("/ui/refresh", ['tab-shown'])
		)

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
	
	###*
  * The title will be updated from the bindings, but there is a race condition between the
  * Instantiation of the view and change of title, now there are two cases
  * 1) if the value is changed before this view is instantiated the observer
  * will not fire because the value is set and will not change, in that case
  * we would need to call the observer explicitely in the didInsertElement for
  * this view to render that tab element.
  * 2) if the value is set after this view is instantiated the observer will
  * automatically fire and will render the required tab element, and once
  * the value of the title is set, the observer won't do anything
  ###
	didInsertElement:->
    @updateTitle()
  
  updateTitle: (->
    unless Ember.empty(@get("title"))
      title = Tent.I18n.loc(@get("title"))
      href = "#" + @get("elementId")
      unless @exists(href)
        @get("parentView").$("ul:first").append "<li><a href=\"" + href + "\" data-toggle=\"tab\">" + title + "</a></li>"
        @getTabWithHref(@get("parentView.active")).tab "show"  if @get("parentView.active") is @get("elementId")
  ).observes("title")
  
  
  ###*
  * This method checks whether there already exists an element with same href as the href of this 
  * view instance, if there is it will update the element's title and return true, so that it is not 
  * appended on the tabs
  ###
  exists: (href) ->
    list = @get("parentView").$("ul:first")[0].children
    if list.length
      for list_item in list
        if list_item.children[0].getAttribute("href") is href
          $(list_item.children[0]).html(@get('title'))
          return true
    false

  getTabWithHref: (href) ->
    @get("parentView").$ "a[href=#" + href + "]"
    