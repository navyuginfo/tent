Tent.Application = Tent.Application or Em.Namespace.create()

require '../../template/application/main_menu'

Tent.Application.MainMenuView = Ember.View.extend
  templateName: 'application/main_menu'
  classNames: ['sci-main-menu']
  collapsedDashboard: false

  ###*
  * @property {Boolean} collapseAutomatically Defines whether the menu should collapse when the content area recieves focus.
  ###
  collapseAutomatically: true

  ###*
  * @property {Boolean} isFlattened Render all menu items in a single hierarchy, ignoring grouping.
  ###
  isFlattened: false

  didInsertElement: ->
    @_super()
    @highlightSelectedItem()

    @$('.nav-tabs a.menu-link').click((e)=>
      @switchMenu(e)
      return true
    )

  highlightSelectedItem: ->
    #set the default selection on the basis of hitted url
    path = window.location.pathname

    @$("a[data-route]").each(->
      if path.indexOf($(this).attr('data-route')) != -1
        $(this).addClass('active-menu')
    )

    current = null
    @$("a.active-menu").each(->
      if not current?
        current = $(this)
      else
        if $(this).attr('data-route').length > current.attr('data-route').length
          current.removeClass('active-menu')
          current = $(this)
    )

  menuClicked: (e)->
    action = $(e.target).attr('data-action') or $(e.target).parents('[data-action]:first').attr('data-action')
    @get('controller').menuClicked(action)

  switchMenu: (event)->
    target = event.target
    selected = @$('.active-menu')[0]
    $(selected).removeClass('active-menu') if selected isnt `undefined`
    if $(target).is('a')
      $(target).addClass('active-menu')
    else 
      $(target).parents('a:first').addClass('active-menu')
    @collapseDashboard() if @get('collapseAutomatically')

  collapseDashboard: ->
    if not @get('collapsedDashboard')
      mainPanel = @getMainPanel()
      mainPanel.removeClass('expanded')
      @set('collapsedDashboard', true)
      @$("span[rel=tooltip]").tooltip('enable');
      @$('.tent-panel.collapsible').each(->
        view = Ember.View.views[$(this).attr('id')]
        if view.get('collapsed')
          view.show()
      )
    @$('a i').tooltip('enable')


  expandDashboard: ->
    if @get('collapsedDashboard')
      mainPanel = @getMainPanel()
      mainPanel.addClass('expanded')
      @set('collapsedDashboard', false)
    @$('a i').tooltip('disable')

  toggleCollapse: ->
    if @get('collapsedDashboard') then @expandDashboard() else @collapseDashboard()

  getMainPanel: ->
    $('.main-content')