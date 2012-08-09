require '../template/list_filter'

convertQueryToWildcard = (query) ->
  query.replace(/([.^$])/,'\\$&').replace('*','.*').replace('?','.')
  
Tent.ListFilter = Ember.View.extend
  templateName: 'list_filter'
  classNames: ['list-filter']
  typeBinding: 'parentView.modelType'
  query: ''
  appBinding: 'parentView.app'
  contentBinding: 'parentView.content'
  filterKeyBinding:'parentView.filterKey'
  filter: (->
    query = convertQueryToWildcard(@get('query'))
    regex = new RegExp(query, 'i')
    type = @get('type')
    filterKey=@get('filterKey')
    if @get('app')? and @getPath('app.store')?
      @set('content', @get('app').store.filter(type, (data) ->
        query == '' || regex.test(data.get('_savedData')[filterKey])
      ))
    else
      filterData=[]
      for content in @get('content')
        if query == '' || regex.test(content[filterKey])
          filterData.push(content)
      @set('content',filterData)
  ).observes('query')
  searchBox: Ember.TextField.extend
    valueBinding: 'parentView.query'
    placeholderBinding: 'msg.filter'