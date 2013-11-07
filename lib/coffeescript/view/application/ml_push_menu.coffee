Tent.MLPushMenuView = Tent.Application.MainMenuView.extend
  classNames: ['tent-push-menu']
  currentLevel: 1
  maxDepth: 0
  levelOffset: 40

  didInsertElement: ->
    @set('expandWidth', $('#mp-menu').width())
    @annotateLevels()
    @_super()
    @redraw()

  showMenu: ->
    width = @get('expandWidth') + ((@get('currentLevel') - 1) * @get('levelOffset'))
    @translate(width, $('.mp-pusher'))
    @set('collapsed', false)

  hideMenu: ->
    width = 0
    @translate(width, $('.mp-pusher'))
    @set('collapsed', true)

  showMenuLevel: (menu, level)->
    width = @get('expandWidth') + ((level-1) * @get('levelOffset'))
    menu.css('margin-left', "-#{width}px")

  hideMenuLevel: (menu, level)->
    width = @get('expandWidth') * level
    menu.css('margin-left', "-#{width}px")

  toggleCollapse: ->
    if @get('collapsed') then @showMenu() else @hideMenu()

  translate: (val, el) ->
    if Tent.Browsers.isIE()
        left = val - @get('expandWidth')
        right = val
        el.css('margin-left', "#{left}px")
        el.css('margin-right', "-#{right}px")
    else
      el.css('margin-left', "#{val}px")
      el.css('margin-right', "-#{val}px")

  # Add attributes to allow the levels to be easily identified
  annotateLevels: ->
    @$().attr('data-level', 1).addClass('selected current root')
    @$('.mp-level').each((i, el) =>
        $(el).attr('data-level', @getLevelDepth($(el))) 
    )

  getLevelDepth: (el) ->
    depth = el.parents('.mp-level').length + 1
    if depth > @get('maxDepth')
        @set('maxDepth', depth)
    depth

  click: (e) ->
    target = $(e.target)
    if @isBackButton(target) or @isOverlapArea(target)
      @goBack()
      @showLevelIcons() if @isOverlapArea(target)
    else
      if @isLevelHeader(target) then return
      if @hasChildLevel(target) and not @isDisabled(target)
        @navigateToNewLevel(e)
      else
        @hideMenu() if @get('collapseAutomatically')

  isBackButton: (target) ->
    target.hasClass('mp-back') or target.hasClass('mp-level') or target.parents('a:first').hasClass('mp-back')

  isOverlapArea: (target) ->
    parseInt(target.parents('.mp-level').attr('data-level')) != @get('currentLevel')

  isLevelHeader: (target) ->
    target.is('h2') or target.parent().is('h2')

  goBack: ->
    mpLevel = @getMpLevelElement(@get('currentLevel'))
    @removeSelectedClass(mpLevel)
    @set('currentLevel', @get('currentLevel') - 1)
    @redraw()

  navigateToNewLevel: (e) ->
    @set('currentLevel', @findLevel($(e.target)) + 1)
    $(e.target).parents('.mp-level:first').find('ul:first .mp-level').removeClass('selected')
    $(e.target).parents('li:first').find('.mp-level').addClass('selected')
    @redraw()

  getMpLevelElement: (level) ->
    $('.selected[data-level="' + level + '"]', '.mp-menu')

  removeSelectedClass: (target) ->
    if (target.hasClass('mp-level'))
      target.removeClass('selected')
    else
      target.parents('.mp-level:first').removeClass('selected')

  findLevel: (target)->
    parseInt(target.parents('.mp-level:first').attr('data-level'))

  hasChildLevel: (target) ->
    target.parents('.menu-item:first').children('.mp-level').length == 1

  isDisabled: (target) ->
    target.hasClass('ui-state-disabled') or target.parents('a:first').hasClass('ui-state-disabled')

  redraw: ->
    @hideLowerLevels()
    @showSelectedLevels()
    @addRemoveCurrentClass()
    @showLevelIcons()
    @showMenu()

  hideLowerLevels: ->
    for level in [@get('currentLevel')+1..@get('maxDepth')]
      $('[data-level="'+level+'"]', '.mp-menu').each( (index, menu) =>
        @hideMenuLevel($(menu), level)
      )

  showSelectedLevels: ->
    for level in [1..@get('currentLevel')]
      @getMpLevelElement(level).each( (index, menu) =>
        @showMenuLevel($(menu), level)
      )

  addRemoveCurrentClass: (menu, level) ->
    current = @get('currentLevel')
    for level in [1..current]
      menu = @getMpLevelElement(level)
      if level == @get('currentLevel')
          menu.addClass('current')
      else
          menu.removeClass('current')

  showLevelIcons: ->
    currentLevel = @get('currentLevel')
    @removeLevelIcon(currentLevel)
    if currentLevel != 1
      for level in [1..(@get('currentLevel') - 1)]
        @showLevelIcon(level)

  showLevelIcon: (level) ->
    mpLevel = @getMpLevelElement(level)
    icon = mpLevel.find(' > h2 > .menu-icon')
    mpLevel.append(icon.clone())

  removeLevelIcon: (level) ->
    @getMpLevelElement(level).find('> .menu-icon').hide(500, -> $(@).remove())


