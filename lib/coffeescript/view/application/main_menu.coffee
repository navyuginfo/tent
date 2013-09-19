Tent.Application = Tent.Application or Em.Namespace.create()

require '../../template/application/main_menu'

Tent.Application.MainMenuView = Ember.View.extend
  templateName: 'application/main_menu'
  classNames: ['main-menu', 'mp-level']

  didInsertElement: ->
    @_super()
    @applyMenuPlugin()
    @selectItemFromUrl()
    #@$('a i, button i').tooltip('enable')

  applyMenuPlugin: ->
    @set('menuPlugin', new mlPushMenu( document.getElementById( 'mp-menu' ), document.getElementById( 'dashboard-toggle' ), {
          type : 'cover'
        }))

  selectedItemDidChange: (->
    @addHighlightToMenuItem(@get('controller.selectedItem')) if @get('controller.selectedItem')?
  ).observes('controller.selectedItem')

  selectedActionDidChange: (->
    @selectItemFromAction(@get('controller.selectedAction'))
  ).observes('controller.selectedAction')

  # Read the URL and find the menuItem which corresponds to that route
  selectItemFromUrl: (path)->
    #set the default selection on the basis of hitted url
    path = path or window.location.pathname
    that = this
    if (@$()?)
      @unhighlightAllItems()

      @forAllChildViews((view)->
        if view.get('hasAction')
          if path.indexOf(view.get('route')) != -1
            that.set('controller.selectedItem', view)
            @navigateToCorrectMenuLevel(view)
      )
  
  selectItemFromAction: (action)->
    that = this
    if (@$()?)
      @unhighlightAllItems()

      @forAllChildViews((view)->
        if view.get('hasAction')
          if action == view.get('action')
            that.set('controller.selectedItem', view)
      )

  forAllChildViews: (callback, view)->
    view = view || @
    callback.call(@, view)
    for childView in view.get('childViews')
      @forAllChildViews(callback, childView)


  addHighlightToMenuItem: (selectedItem)->
    @unhighlightAllItems()
    selectedItem.set('isSelected', true)

  navigateToCorrectMenuLevel: (selectedItem) ->
    level = selectedItem.$().parents('.mp-level:first').get(0)
    #@get('menuPlugin')._openMenu(level) if @get('menuPlugin')?

  unhighlightAllItems: ->
    @forAllChildViews((view)->
      if view.get('hasAction')
        view.set('isSelected', false)
    )
