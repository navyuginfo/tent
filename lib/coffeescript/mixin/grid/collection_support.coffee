Tent.Grid = Ember.Namespace.create()

###*
* @class Tent.Grid.CollectionSupport
* 
* A mixin which allows the use of a collection to provide content and 
* functionality for a grid
*
* The grid will bind to the following properties of the collection:
* 	
* - columnsDescriptor: an array of descriptor objects defining the columns to be displayed
* 			e.g. [
				{id: "id", name: "id", title: "_hID", field: "id", sortable: true, hideable: false},
				{id: "title", name: "title", title: "_hTitle", field: "title", sortable: true},
				{id: "amount", name: "amount", title: "_hAmount", field: "amount", sortable: true, formatter: "amount",  align: 'right'},
			]
* - totalRows: the total number of rows in the entire result set (including pages not visible)
* - totalPages: The total number of pages of data available
*
* The collection should also provide the following methods:
*
* - sort(sortdata): Sort the collection according to the sortdata provided
* 			e.g. 
				{fields: [
							sortAsc: true
							field: 'title'
					]
				}
*				
* - goToPage(pageNumber): Navigate to the pagenumber provided (1 = first page)
*
###


Tent.Grid.CollectionSupport = Ember.Mixin.create
	###*
	* @property {Object} collection The collection object providing the API to the data source
	###
	collection: null

	###*
	* @property {Boolean} paged Boolean to indicate the data should be presented as a paged list
	###
	paged: false

	###*
	* @property {Number} pageSize The number of items in each page
	###
	pageSize: 12

	pagingData: 
		page: 1 
	
	totalRowsBinding: 'collection.totalRows'
	totalPagesBinding: 'collection.totalPages'

	sortingData: {}

	init: ->
		@_super(arguments)
		if @get('collection')?
			if @get('paged')
				@get('collection').set('pageSize', @get('pageSize'))

	didInsertElement: ->
		if @get('collection')?
			@get('collection').goToPage(1)

	onPageOrSort: (postdata)->
		if @get('collection')?
			#	postdata is of the form:
			#       _search: false,	nd: 1349351912240, page: 1, rows: 12, sidx: "", sord: "asc"
			if @shouldSort(postdata)
				@getTableDom().jqGrid('groupingRemove', true);
				@get('collection').sort(
					fields: [
						sortDir: postdata.sord
						field: postdata.sidx
					])
			else 
				@get('pagingData').page = postdata.page
				@get('collection').goToPage(postdata.page)

			@get('sortingData').field = postdata.sidx
			@get('sortingData').asc = postdata.sord

	shouldSort: (postdata)->
		sortable = false
		for columnDef in @get('columns')
			if columnDef.name == postdata.sidx and columnDef.sortable? and columnDef.sortable
				sortable = true

		sortable and postdata.sidx!="" and (postdata.sidx != @get('sortingData').field or postdata.sord != @get('sortingData').asc)
		

