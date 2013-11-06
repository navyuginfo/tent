view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))
setup = ->
teardown = ->

module 'Tent.Application.MLPushMenuView', setup, teardown

test 'selection', ->

  testTemplate = Ember.Handlebars.compile("""
    {{#view Tent.Application.MenuItemView title="menu.upload.main" icon="icon-cloud-upload" hasChildren=true}}
     
      {{view Tent.Application.MenuItemView 
        title="menu.upload.newUpload"
        action="showNewUpload"
        icon="icon-cloud-upload"
        route="/upload_invoice"
      }}
      {{view Tent.Application.MenuItemView 
          title="menu.sell.sellInvoices"
          action="showNewOffer"
          icon="icon-coin"
          route="/sell"
        }}
       
    {{/view}}
  """)

  controller = Tent.Application.MainMenuController.create
    target: 
      send: ->


  view = Ember.View.create
    template: Ember.Handlebars.compile '{{view Tent.MLPushMenuView 
          controllerBinding="view.controller"
          templateBinding="view.innerTemplate"
        }}'
    controller: controller
    innerTemplate: testTemplate

  appendView()
  menuView = Ember.View.views[view.$('.main-menu').attr('id')]

  notEqual menuView, undefined, 'menuView should be defined'
  equal view.$('.menu-item').length, 3, 'Rendered main-menu'

  menuView.hideMenu()
  ok menuView.get('collapsed'), 'Collapsed property is true'
  
  menuView.showMenu()
  ok not menuView.get('collapsed'), 'Collapsed property is false'

  menuView.toggleCollapse()
  ok menuView.get('collapsed'), 'Collapsed property toggled to true'
  
  


