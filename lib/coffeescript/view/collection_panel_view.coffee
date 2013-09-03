require '../template/collection_panel'
require '../template/collection_panel_content'

###*
* @class Tent.CollectionPanelView
* 
* Displays a collection of objects in separate panels laid out in a 2d grid.
* The {@link #contentViewType} property must be populated with a view which will render each panel. This view 
* should be a subclass of Tent.TaskCollectionPanelContentView
* 
* Usage within a template:
*     {{view Tent.CollectionPanelView 
            collectionBinding="Pad.jqRemoteCollection"
            contentViewType="Tent.TaskCollectionPanelContentView"
       }} 
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
	collection: null
	childViews: ['contentView']
	contentView: (->
		eval(@get('contentViewType')).create
			content: @get('item')
			collection: @get('collection')

	).property('item')

###*
*	@class Tent.CollectionPanelContentView
*	This class should be extended to provide the content for a {@link #Tent.CollectionPanelView}
###
Tent.CollectionPanelContentView = Ember.View.extend
	templateName: null
	content: null

	###*
	* @method getLabelForField Returns a translated label for the given field name of a collections columns
	* @param {String} fieldName the field name of the column to be returned
	* @return {String} the translated label for the field
	###
	getLabelForField: (fieldName)->
		column = @get('collection')?.getColumnByField(fieldName)
		Tent.I18n.loc(column?.get('title'))

	###*
	* @method formattedValue Formats a given value using the formatter associated with a collection column definition.
	* @param {String} fieldName the field name of the column which is used to locate the formatter
	* @param {Object} value the value to be formatted
	* @return {String} the formatted value
	###
	formattedValue: (fieldName, value) ->
		column = @get('collection')?.getColumnByField(fieldName)
		if column.get('formatter')?
			$.fn.fmatter[column.get('formatter')](value, {colModel: {formatOptions: column.get('formatoptions')}})
		else
			value



