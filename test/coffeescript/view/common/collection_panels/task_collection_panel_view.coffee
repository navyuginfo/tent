Tent.TaskCollectionPanelContentView = Tent.CollectionPanelContentView.extend
	templateName: 'collection_panel_content'
	content: null

	durationLabel: (->
		@getLabelForField('duration')
	).property('collection')

	durationValue: (->
		@formattedValue('duration', @get('content.duration'))
	).property('content')

	finishLabel: (->
		@getLabelForField('finish')
	).property('collection')

	finishValue: (->
		@formattedValue('finish', @get('content.finish'))
	).property('content')

	 

