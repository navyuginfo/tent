#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

Tent.AlertMessage = Ember.View.extend
  tagName: 'div'
  classNames: ['alert']
  title: null;
  template: Ember.Handlebars.compile '<a href="#" class="close" close="close">x</a>{{#if view.title}}<span class="title">{{loc view.title}}</span>{{/if}}{{loc view.text}}'

# type --- error/success/info/block  
  init: ->
    @_super()
    type = @get('type')
    classNames = @get('classNames')
    classNames.push('alert-' + type) if type

  click: (event)->
    target = event.target
    targetClose = target.getAttribute('close')
    (@destroy(); false) if targetClose == 'close' 
