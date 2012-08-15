
Pad.TaskList = Tent.SlickGrid.extend(
	columnsBinding: 'controller.columns'

	rowSelectionCallback: (e, args) ->
		@_super(e, args)

	logRowSelection: (->
		#console.log "Title = #{@rowSelection.title}"
	).observes('rowSelection')
)