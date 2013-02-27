###*
* @class Tent.Grid.ColumnChooserSupport
* Adds a column choooser to a grid
###

Tent.Grid.ColumnChooserSupport = Ember.Mixin.create
	addNavigationBar: ->
		 
		tableDom = @getTableDom()
		if not @get('title')?
			tableDom.setCaption('&nbsp;')
		@renderColumnChooser(tableDom)

	renderColumnChooser: (tableDom)->
		widget = this
		button = """
				<div class="btn-group column-chooser">
					<a class="" data-toggle="dropdown" href="#">
						<i class="icon-columns"></i>#{Tent.I18n.loc("tent.jqGrid.hideShowCaption")}
					</a>
					<div class="dropdown-menu columns">
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
		columns = @get('columns').map((item)->
			item.t = Tent.I18n.loc(item.title)
			return item;
		)

		columns = columns.filter((item)->
			item.hideable ==true
		)
		context = 
			columns: columns

		@$(".ui-jqgrid-titlebar").append(template(context))

		@$('.column-chooser input').click (e) -> 
			column = $(this).attr('data-column')
			if $(this).is(':checked')
				tableDom.jqGrid("showCol",column);
			else
				tableDom.jqGrid("hideCol",column);

			e.stopPropagation()
			widget.columnsDidChange()
			widget.resizeToContainer()

		@$('.column-chooser label').click (e) -> 
			e.stopPropagation()
			 