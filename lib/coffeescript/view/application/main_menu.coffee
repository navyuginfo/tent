Tent.Application = Tent.Application or Em.Namespace.create()

Tent.Application.MainMenuView = Ember.View.extend
  
  ###*
  * @property {Boolean} collapseAutomatically If set to true, the menu will collapse when an actionable
  * item is selected.
  ###
  collapseAutomatically: true
  classNames: ['main-menu', 'mp-level', 'selected']

  didInsertElement: ->
    @_super()
    @hideMenusWithNoValidChildren()
    @openMenuInitially()
    @selectItemFromUrl()

  openMenuInitially: ->
    $('.dashboard-toggle a').click()

  selectedActionDidChange: (->
    @selectItemFromAction(@get('controller.selectedAction'))
  ).observes('controller.selectedAction')

  # Read the URL and find the menuItem which corresponds to that route
  selectItemFromUrl: (path)->
    #set the default selection on the basis of hitted url
    path = path or window.location.pathname
    that = this
    if (@$()?)
      @forAllChildViews((view)->
        if view.get('hasAction')
          if path.indexOf(view.get('route')) != -1
            that.set('controller.selectedItem', view)
            @navigateToCorrectMenuLevel(view)
      )
  
  selectItemFromAction: (action)->
    that = this
    if (@$()?)
      @forAllChildViews((view)->
        if view.get('hasAction')
          if action == view.get('action')
            that.set('controller.selectedItem', view)
      )

  # Navigate through the child items
  # bottomUp determines whether to start navigation from the top level
  # or the deepest levels.
  forAllChildViews: (callback, bottomUp=false, view)->
    view = view || @
    callback.call(@, view) unless bottomUp
    for childView in view.get('childViews')
      @forAllChildViews(callback, bottomUp, childView)
    callback.call(@, view) if bottomUp

  navigateToCorrectMenuLevel: (selectedItem) ->
    @openMenuInitially()
    levels = selectedItem.$().parentsUntil('#mp-menu','li')
    reversed = levels.toArray().reverse()
    for item in reversed
      $(item).find('a:first').click()

  hideMenusWithNoValidChildren: ->
    @forAllChildViews((view)->
        view.checkParentEntitlements() if view.checkParentEntitlements?
      , true
    )

