###*
* @class Tent.Grid.ColumnChooserSupport
* Adds a column choooser to a grid
###

Tent.Grid.ColumnChooserSupport = Ember.Mixin.create
    addNavigationBar: ->
        @_super()
        tableDom = @getTableDom()
        #if not @get('title')?
        #	tableDom.setCaption('&nbsp;')
        @renderColumnChooser()

    renderColumnChooser: (->
        tableDom = @getTableDom()
        widget = this
        button = """
                    <a class="open-dropdown" href="#">
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
        """

        @$(".grid-header .header-buttons").append('<div class="btn-group column-chooser"></div>') if @$(".grid-header .column-chooser").length == 0

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

        @$(".grid-header .column-chooser").empty()
        @$(".grid-header .header-buttons .column-chooser").append(template(context))

        @bindToggleVisibility(@$(".column-chooser .open-dropdown"), @.$(".column-chooser .dropdown-menu"))

        @$('.column-chooser input').click (e) ->
            column = $(this).attr('data-column')
            if $(this).is(':checked')
                widget.showCol(column)
            else
                widget.hideCol(column)
            widget.columnsDidChange()
            widget.resizeToContainer()
    ).observes('columnModel','columnModel.@each')

    showCol: (column) ->
        @getTableDom().jqGrid("showCol",column);

    hideCol: (column) ->
        @getTableDom().jqGrid("hideCol",column);
