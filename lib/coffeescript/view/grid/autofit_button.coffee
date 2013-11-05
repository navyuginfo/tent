require '../../template/grid/autofit_button'

Tent.Grid.AutofitButton = Ember.View.extend
    template: Ember.Handlebars.compile('<a {{bindAttr title="view.title"}} {{bindAttr class=":horizontal-scroll-button :button-control view.active:active"}}><i class="icon-resize-horizontal"></i></a>')
    title: Tent.I18n.loc("tent.jqGrid.horizontalScroll")
    grid: null

    active: (->
        return !@get('grid.horizontalScrolling')
    ).property('grid.horizontalScrolling')

    click: ->
        @get('grid').set('horizontalScrolling', !@get('grid').get('horizontalScrolling'))