Tent.Grid.FilterSupport = Ember.Mixin.create

	filtering: false

	addFilterPanel: ->
		if @get('filtering')
			widget = @
			button = """
					<div class="btn-group jqgrid-title-button filter">
						<a class="open-dropdown">
							<i class="icon-filter"></i>
							#{Tent.I18n.loc 'tent.filter.filter'}
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu filter-panel">
							<li></li>
						</ul>
					</div>
			"""

			@$(".ui-jqgrid-titlebar").append(button)

			#filterSelection = @getFilterSelection()
			#if filterSelection?
			#	filterSelection.detach()
		#		@set('filterSelection', filterSelection)
		#	else 
		#		filterSelection = @get('filterSelection')

		#	@$(".ui-jqgrid-titlebar").append(filterSelection)
			
			
			filterDetails = @getFilterDetails()
			if filterDetails?
				filterDetails.detach()
				@set('filterDetails', filterDetails)
			else 
				filterDetails = @get('filterDetails')
			@$(".jqgrid-title-button .filter-panel li").append(filterDetails)


			@$(".jqgrid-title-button.filter .open-dropdown").click(->
				widget.toggleFilterPanel()
			)

			@$(".jqgrid-title-button.filter .filter-panel .close-panel .btn").click(->
				widget.closeFilterPanel()
			)

	toggleFilterPanel: ->
		dropDown = @$(".jqgrid-title-button.filter .dropdown-menu")
		dropDown.css('display', if dropDown.css('display')=='none' then 'block' else 'none')

	closeFilterPanel: ->
		@$(".jqgrid-title-button.filter .dropdown-menu").css('display', 'none')

	openFilterPanel: ->
		@$(".jqgrid-title-button.filter .dropdown-menu").css('display', 'block')

	getFilterSelection: ->
		@$('.filter-selection') if @$('.filter-selection').length > 0

	getFilterDetails: ->
		@$('.filter-details') if @$('.filter-details').length > 0


 
