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
	selectable: false
	selection: null

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
		@set('selection', Ember.A()) if not @get('selection')?


Tent.CollectionPanelContentContainerView = Ember.ContainerView.extend
	item: null
	contentViewType: null
	collection: null
	selectable: false
	selection: Ember.A()
	childViews: ['contentView']
	contentView: (->
		if @get('contentViewType')?
			eval(@get('contentViewType')).create
				content: @get('item')
				collection: @get('collection')
				selectable: @get('selectable')
				selected: @get('isSelected')

	).property('item')

	isSelected: (->
		@get('selection').contains(@get('item'))
	).property('selection.@each')

	selectedDidChange: (isSelected)->
		if isSelected
			@addToSelection()
		else
			@removeFromSelection()

	addToSelection: ->
		@get('selection').pushObject(@get('item')) if not @get('selection').contains(@get('item'))
		
	removeFromSelection: ->
		myItem = @get('item')
		@set('selection', @get('selection').filter((item)->
			item != myItem
		))


###*
*	@class Tent.CollectionPanelContentView
*	This class should be extended to provide the content for a {@link #Tent.CollectionPanelView}
###
Tent.CollectionPanelContentView = Ember.View.extend
	templateName: null
	classNames: ['collection-panel-content']
	classNameBindings: ['selected']
	content: null
	selectable: false
	selected: false

	didInsertElement: ->
		@$().parents('.collection-panel:first').css('opacity', '1')

	###*
	* @method getLabelForField Returns a translated label for the given field name of a collections columns
	* @param {String} fieldName the field name of the column to be returned
	* @return {String} the translated label for the field
	###
	getLabelForField: (fieldName)->
		column = @get('collection')?.getColumnByField(fieldName)
		Tent.I18n.loc(column?['title'])

	###*
	* @method formattedValue Formats a given value using the formatter associated with a collection column definition.
	* @param {String} fieldName the field name of the column which is used to locate the formatter
	* @param {Object} value the value to be formatted
	* @return {String} the formatted value
	###
	formattedValue: (fieldName, value) ->
		column = @get('collection')?.getColumnByField(fieldName)
		if column['formatter']?
			$.fn.fmatter[column['formatter']](value, {colModel: {formatOptions: column['formatoptions']}})
		else
			value

	selectedDidChange: (->
		@set('selected', @get('selected'))
		@get('parentView').selectedDidChange(@get('selected'))
	).observes('selected')



