Tent.Grid.FilterSupport = Ember.Mixin.create
	###*
	* @property {Template} filterTemplate The name of a template which is used to display the filter fields.
	* See {@link Tent.CollectionFilter#filterTemplate}
	###
	filterTemplate: null

	filtering: false

	addFilterPanel: ->
		#Temporary!!!
		@getTopToolbar().css({'position','relative','height':'30px'})
		filterDom = @getFilterDom().detach()

		@getTopToolbar().append('
			<div class="filter-panel">
				
			</div>'
		)

		@$('.filter-panel').append(filterDom)

	getFilterDom: ->
		@$('.tent-filter')

	getTopToolbar: ->
		@$('#t_' + @get('elementId') + '_jqgrid')

 
