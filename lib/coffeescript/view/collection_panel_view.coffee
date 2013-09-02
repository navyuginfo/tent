require '../template/collection_panel'
require '../template/collection_panel_content'

###*
* @class Tent.CollectionPanelView
* 
* Displays a collection of objects in separate panels laid out in a 2d grid.
* The {@link #contentViewType} property must be populated with a view which will render each panel.
*
###

Tent.CollectionPanelView = Ember.View.extend
	templateName: 'collection_panel'
	classNames: ['collection-panel-container']

	###*
	* @property {Object} collection The colleciton which contains the items for display.
	###
	collection: null

	###*
	* @property {String} contentViewType The name of a view class which will render the contents of each panel.
	* This view will have its 'content' populated with the model for that panel
	###
	contentViewType: null

	didInsertElement: ->
		@get('collection').update()
		

Tent.CollectionPanelContentContainerView = Ember.ContainerView.extend
	item: null
	contentViewType: null
	childViews: ['contentView']
	contentView: (->
		eval(@get('contentViewType')).create
			content: @get('item')

	).property('item')


Tent.CollectionPanelContentView = Ember.View.extend
	templateName: 'collection_panel_content'
	content: null
