#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#
get=Ember.get
set=Ember.set
getPath=Ember.getPath
setPath=Ember.setPath
require '../template/list'
Tent.List=Ember.View.extend
  layoutName: 'list'
  modelName:null
  click: (event) ->
    if event.target.className is "icon-plus"
      event.preventDefault()
      @getPath('controller.controllers').send('new'+@modelName)  
  collectionView:Ember.CollectionView.extend
    contentBinding: 'parentView.controller.content'
    controllersBinding: 'parentView.controller.controllers'
    itemViewClass: Ember.View.extend
      classNameBindings:['isActive:is-active']
      isActive: (->
        @get('content') == @getPath('parentView.parentView.selected')
      ).property('parentView.parentView.selected')
      
      click: (event) ->
        event.preventDefault()
        @setPath('parentView.parentView.selected', @get('content'))