Tent.Tree = Ember.View.extend
  
  activeVisible: true
  autoActivate: true 
  autoCollapse: false
  autoScroll: false
  checkbox: false
  clickFolderMode: 4
  disabled: false
  extensions: []
  generateIds: false
  icons: false
  keyboard: true
  selectMode: 2
  tabbable: true
  nolink: true
  minExpandLevel: 1

  template:(->
    guid = Ember.guidFor(@)
    Ember.Handlebars.compile("<div id='##{guid}-tree'></div>")
  ).property()

  didInsertElement: ->
    widget = @
    options = $.extend({}, @getTreeEvents(), @getNodeEvents(), @getDefaultSettings())
    @set 'tree', @$("##{Ember.guidFor(@)}-tree").fancytree(options)

  getTreeEvents: ->
    options = {}
    treeEvents = ['init', 'create']
    for event in treeEvents
      options[event] = ((e, data, flag) -> widget[event].call(widget, e, data, flag)) if widget[event]?
    options
  
  getNodeEvents: ->
    options = {}
    nodeEvents = ['beforeActivate', 'activate', 'deactivate', 'beforeSelect', 'select',
                  'beforeExpand', 'collapse', 'expand', 'loadChildren', 'focustree',
                  'blurtree', 'focus', 'blur', 'click', 'dblclick', 'keydown', 'keypress',
                  'createnode', 'rendernode', 'lazyload', 'lazyread']
    for event in nodeEvents
      options[event] = ((e, data) -> widget[event].call(widget, e, data)) if widget[event]?
    options

  getDefaultSettings: ->
    options = {}
    defaultSettings = ['activeVisible', 'autoActivate', 'autoCollapse', 'autoScroll',
                      'checkbox', 'clickFolderMode', 'disabled', 'extensions', 'generateIds',
                      'icons', 'keyboard', 'nolink', 'selectMode', 'tabbable', 'minExpandLevel']
    options[setting] = widget.get(setting) for setting in defaultSettings
    options