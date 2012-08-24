
Pad.TaskList = Tent.SlickGrid.extend(
	columnsBinding: 'controller.columns'

	rowSelectionCallback: (e, args) ->
		@_super(e, args)

	logRowSelection: (->
		#console.log "Title = #{@rowSelection.title}"
	).observes('rowSelection')
)

Pad.InvoiceGridView = Tent.SlickGrid.extend(
	columnsBinding: 'controller.columns'
	 
)

Pad.InvoiceGridController = Tent.Controllers.GridController.extend (
	modelType: Pad.Models.TaskModel
	#content: Pad.store.findAll(Pad.Models.TaskModel)
	store: Pad.store 
	columns: [
		{id: "id", name: "ID", field: "id", sortable: true},
		{id: "title", name: "Title", field: "title", sortable: true},
		{id: "duration", name: "Duration", field: "duration", sortable: true},
		{id: "%", name: "% Complete", field: "percentComplete"},
		{id: "start", name: "Start", field: "start"},
		{id: "finish", name: "Finish", field: "finish"},
		{id: "effort-driven", name: "Effort Driven", field: "effortDriven"}
	]
)