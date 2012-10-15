#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

###*
* @class Tent.ProgressBar
* 
* Usage
* 		{{view Tent.ProgressBar isStriped=true progress="50" isAnimated=true}}
###
Tent.ProgressBar = Ember.View.extend
  classNames: ['tent-progress-bar', 'progress']
  classNameBindings: ['isStriped:progress-striped', 'isAnimated:active']
  template: Ember.Handlebars.compile '<div class="bar" {{bindAttr style="view.style"}}></div>' 
  
  ###*
  * @property {Boolean} isAnimated Boolean to indicate if the bar should be rendered with a progress animation.
  ###
  isAnimated: false

  ###*
  * @property {Boolean} isStriped Boolean to indicate if the bar should be rendered with stripes
  ###  
  isStriped: false

  ###*
  * @property {Number} progress The progress to be displayed, as a percentage between 0 and 100
  ###
  progress: 0    

  style: Ember.computed(->
    "width:" + @get('progress') + "%;"
  ).property('progress')  