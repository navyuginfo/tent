Tent.Grid.FilterSupport = Ember.Mixin.create

	filtering: true

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

 
