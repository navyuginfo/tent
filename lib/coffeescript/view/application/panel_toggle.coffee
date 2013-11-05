Tent.Application = Tent.Application or Em.Namespace.create()

Tent.Application.PanelToggleView = Ember.View.extend
  elementId: "dashboard-toggle"
  classNames: ['dashboard-toggle']
  template: Ember.Handlebars.compile('<a><i class="icon-reorder"></i></a>')
  attributeBindings: ['rel']
  rel: 'popover'
  targets: ['main-menu']

  didInsertElement: ->
    @_super()
  
  click: ->
    for target in @get('targets')
      if @getViewForTarget(target)?
        @getViewForTarget(target).toggleCollapse()
      else
        $('.' + target).toggleClass('expanded')

  getViewForTarget: (target)->
    Ember.View.views[$('.'+ target).attr('id')]
