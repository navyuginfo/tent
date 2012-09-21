#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
* @class Tent.Tag
* A single tag item
* Usage
*      {{view Tent.Tag text="Important"}}
###

Tent.Tag = Ember.View.extend
  tagName: 'span'

  ###*
  * @property {String} [type=info] The type of tag to display
  ###
  type: 'info'
  classNameBindings: ['labelClasses']
  labelClasses: (-> 'label ' +  'label-' + @get('type')).property('type')
  template: Ember.Handlebars.compile '{{view.text}}'

  init: ->
    @_super()
    type = @get('type')
    classNames = @get('classNames')
    classNames.push('label-' + type) if type
