###*
* @class Tent.Grid.ColumnChooserSupport
* Adds a column choooser to a grid
###

Tent.Grid.ColumnChooserSupport = Ember.Mixin.create
	###*
	* @property {Boolean} showColumnChooser Display a button at the top of the grid which presents
	* a dialog to show/hide columns. Any columns which have a property **'hideable:false'** will not be shown
	* in this dialog
	###
	showColumnChooser: true
	
	addNavigationBar: ->
		@_super()
		if @get('showColumnChooser')
			@renderColumnChooser()

	renderColumnChooser: (->
		if @$()?
			tableDom = @getTableDom()
			widget = this
			button = """
					<div class="btn-group column-chooser">
						<a class="open-dropdown">
							<i class="icon-columns"></i>#{Tent.I18n.loc("tent.jqGrid.hideShowCaption")}
						</a>
						<div class="dropdown-menu columns pull-right">
							<div class="window"></div>
							<ul>
								{{#each columns}}
									<li><label><input type="checkbox" data-column="{{name}}" {{#unless hidden}}checked="checked"{{/unless}}/><span class="title">{{t}}</span></label></li>
								{{/each}}
							</ul>
						</div>
					</div>
			"""

			template = Handlebars.compile(button)
			columns = @get('columnModel').map((item)->
				item.t = Tent.I18n.loc(item.title)
				return item;
			)
			columns = columns.filter((item)->
				item.hideable != false
			)
			context = 
				columns: columns

			@$(".grid-header .column-chooser").remove()
			@$(".grid-header .header-buttons").append(template(context))

			@bindToggleVisibility(@$(".column-chooser .open-dropdown"), @.$(".column-chooser .dropdown-menu"))

			@$('.column-chooser input').click (e) -> 
				column = $(this).attr('data-column')
				if $(this).is(':checked')
					widget.showCol(column)
				else
					widget.hideCol(column)
				widget.columnsDidChange()
				widget.storeColumnDataToCollection()
				widget.resizeToContainer()
	).observes('columnModel','columnModel.@each')

	showCol: (column) ->
		@getTableDom().jqGrid("showCol",column);

	hideCol: (column) ->
		@getTableDom().jqGrid("hideCol",column);
