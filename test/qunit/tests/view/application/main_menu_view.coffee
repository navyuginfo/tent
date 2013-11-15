view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))
setup = ->
teardown = ->

module 'Tent.Application.MainMenuView', setup, teardown

test 'selection', ->

  #applyStub = sinon.stub(Tent.Application.MainMenuView, "selectItemFromUrl")
  plugin = Tent.Application.MainMenuView.applyMenuPlugin
  Tent.Application.MainMenuView.reopen
    applyMenuPlugin: ->

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
    template: Ember.Handlebars.compile '{{view Tent.Application.MainMenuView 
          controllerBinding="view.controller"
          templateBinding="view.innerTemplate"
        }}'
    controller: controller
    innerTemplate: testTemplate

  appendView()

  menuView = Ember.View.views[view.$('.main-menu').attr('id')]
  notEqual menuView, undefined, 'menuView should be defined'
  equal view.$('.menu-item').length, 3, 'Rendered main-menu'

  menuView.selectItemFromUrl('/upload_invoice')
  equal menuView.get('controller.selectedItem.route'), '/upload_invoice', 'Selected the correct route'

  menuView.selectItemFromAction('showNewOffer')
  equal menuView.get('controller.selectedItem.route'), '/sell', 'Selected the correct item from action'


  Tent.Application.MainMenuView.reopen
    applyMenuPlugin: plugin
 

test 'parent menu items are entitled only if all of their children are entitled', ->    
  cachedPolicy = Tent.Application.MenuItemView.evaluatePolicy

  Tent.Application.MenuItemView.reopen
    evaluatePolicy: (operation)->
      return ['valid-operation', 'another-valid-operation'].contains(operation)

  view = Ember.View.create
    template: Ember.Handlebars.compile """
      {{#view Tent.Application.MainMenuView}}
        {{view Tent.Application.MenuItemView hasChildren=false class="top-level-menu-item-entitled"}}
        {{#view Tent.Application.MenuItemView  hasChildren=true class="top-level-menu-item-not-entitled"}}
           
          {{view Tent.Application.MenuItemView 
            title="menu.upload.newUpload"
            icon="icon-cloud-upload"
            route="/upload_invoice"
            operations="scicustomer.uploadInvoices.upload,scicustomer.uploadInvoices.all"
          }}
        {{/view}}
      {{/view}}"""

  appendView()

  menuView = Ember.View.views[view.$('.main-menu').attr('id')]

  topMenuItemEntitled = Ember.View.views[view.$('.top-level-menu-item-entitled').attr('id')]
  ok topMenuItemEntitled.get('isEntitled'), "top level should be entitled"

  topMenuItemNotEntitled = Ember.View.views[view.$('.top-level-menu-item-not-entitled').attr('id')]
  ok not topMenuItemNotEntitled.get('isEntitled'), "top level should not be entitled"

  Tent.Application.MenuItemView.reopen
    evaluatePolicy: cachedPolicy

   