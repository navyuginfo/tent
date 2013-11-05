require '../template/pager'


Tent.Pager = Ember.View.extend
    templateName: 'pager'
    prevTitle: Tent.I18n.loc('tent.jqGrid.paging.prev')
    nextTitle: Tent.I18n.loc('tent.jqGrid.paging.next')
    firstTitle: Tent.I18n.loc('tent.jqGrid.paging.first')
    lastTitle: Tent.I18n.loc('tent.jqGrid.paging.last')

    first: ->
        @get('collection').goToPage(1)
        console.log('first')
    prev: ->
        if @get('collection.pagingInfo.page') > 1
          @get('collection').prevPage()
    next: ->
        if @get('collection.pagingInfo.page') < @get('collection.pagingInfo.totalPages')
          @get('collection').nextPage()
    last: ->
        @get('collection').goToPage(@get('collection.pagingInfo.totalPages'))

    getPage: ->
      @get('collection.pagingInfo.page')

