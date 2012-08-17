require '../template/tab'
require 'bootstrap-sass/bootstrap-tab'

Tent.Tabs = Ember.View.extend
	classNames: ["nav", "nav-tabs"]
	tagName: "ul"

Tent.Tab = Ember.View.extend
	tagName: "li"
	template: Ember.Handlebars.compile '<a {{bindAttr href="view.paneSelector"}} data-toggle="tab">{{view.title}}</a>'
	paneSelector: (-> "#" + @get("pane")).property("pane")

Tent.TabPanes = Ember.View.extend
	classNames: ["tab-content"]

Tent.TabPane = Ember.View.extend
	classNames: ["tab-pane"]
	layout: Ember.Handlebars.compile '{{yield}}'
