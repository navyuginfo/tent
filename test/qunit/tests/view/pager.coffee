setup = ->
teardown = ->  
    
module 'Tent.Pager', setup, teardown

test '...', ->
  collection = Ember.Object.create
                  pagingInfo:
                    page: 1
                    totalPages: 3
                  nextPage: ->
                    @set('pagingInfo.page', @get('pagingInfo.page') + 1)
                  prevPage: ->
                    @set('pagingInfo.page', @get('pagingInfo.page') - 1)
                  goToPage: (page)->
                    @set('pagingInfo.page', page)



  pager = Tent.Pager.create
            collection: collection

  equal pager.getPage(), 1, "Start at first page"
  pager.next()
  equal pager.getPage(), 2, "Move to page 2"
  pager.next()
  equal pager.getPage(), 3, "Move to page 3"
  pager.next()
  equal pager.getPage(), 3, "Still on page 3"
  pager.prev()
  equal pager.getPage(), 2, "Previous"
  pager.first()
  equal pager.getPage(), 1, "First"
  pager.prev()
  equal pager.getPage(), 1, "Remain on first"
  pager.last()
  equal pager.getPage(), 3, "Last"


  