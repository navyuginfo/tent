require '../../template/grid/multiview_buttons'

Tent.Grid.MultiviewButtons = Ember.View.extend
	templateName: 'grid/multiview_buttons'
	showCardView: false
	showListView: true

	didInsertElement: ->
		@$('.btn-group').button()

	click: (e)->
		selected = @$('.active').attr('data-view')
		switch selected
			when "card" 
				@set('showCardView', true)
				@set('showListView', false)
			when "list" 
				@set('showCardView', false)
				@set('showListView', true)
			else
				@set('showCardView', false)
				@set('showListView', true)