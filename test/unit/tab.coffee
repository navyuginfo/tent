view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

setup = ->
	view = Ember.View.create
		template: Ember.Handlebars.compile '
		{{#view Tent.Tabs id="tabstrip" active="settings"}}
          {{view Tent.Tab title="Profile" pane="profile"}}
          {{view Tent.Tab title="Messages" pane="messages"}}
          {{view Tent.Tab title="Settings" pane="settings"}}
        {{/view}}

        {{#view Tent.TabPanes}}
          {{#view Tent.TabPane id="profile"}}
              Lorem ipsum dolor sit amet, consectetur adipisicing elit.
          {{/view}}
          {{#view Tent.TabPane id="messages"}}
              Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium,
          {{/view}}
          {{#view Tent.TabPane id="settings"}}
              At vero eos et accusamus et iusto odio dignissimos ducimus
          {{/view}}
        {{/view}}'

teardown = ->
  Em.run -> 
    view.destroy() if view

module 'Tent.Tabs', setup, teardown

test 'Ensure the tabs get rendered correctly', ->
	appendView()
	equal view.$('.nav-tabs').length, 1, 'Tab root has been created'
	equal view.$('.nav-tabs a').length, 3, 'Three anchors created'
	equal view.$('.nav-tabs a').eq(0).attr("href"), '#profile', 'Href for anchor 1'
	equal view.$('.nav-tabs a').eq(0).attr("data-toggle"), 'tab', 'data-toggle attribute'

	equal view.$('.tab-content').length, 1, 'Tab content has been created'
	equal view.$('.tab-content .tab-pane').length, 3, 'Three panes created'
	equal view.$('.tab-content .tab-pane').eq(0).attr("id"), 'profile', 'First pane id'
	
test 'Ensure clicking applies the correct classes', ->
	appendView()
	equal view.$('.nav-tabs li.active').length, 1, '1 tab is active'
	equal view.$('.tab-content .tab-pane.active').length, 1, '1 pane is active'
	ok view.$('.nav-tabs li').eq(2).hasClass("active"), 'last tab is active'

	view.$('.nav-tabs a').eq(0).trigger("click")
	ok view.$('.nav-tabs li').eq(0).hasClass("active"), 'First li becomes active'
	ok view.$('.tab-content .tab-pane').eq(0).hasClass("active"), 'First pane becomes active'
	