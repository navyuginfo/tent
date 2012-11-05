((loader) -> 

	loader.require('coffeescript/app')
	loader.require('coffeescript/router')
	loader.require('coffeescript/controllers/application_controller')
	loader.require('coffeescript/i18n/translations')
	loader.require('coffeescript/store/datastore')

	loader.require('coffeescript/models/paging_adapter')
	loader.require('coffeescript/models/task_model')
	loader.require('template/task_collection_filter')

	Pad.initialize()

	# TODO: Asynch binding is not functioning with this fixtureAdapter
	# Ensure the Rest adapter is working correctly
	Pad.pagingAdapter.simulateRemoteResponse = false;
	Pad.store = DS.Store.create({
		revision: 4,
		adapter: Pad.pagingAdapter
	});

	Tent.I18n.loadTranslations(Tent.translations)

	Pad.dataStore = Pad.DataStore.create()

	loader.require('coffeescript/view/task_list')
	loader.require('coffeescript/controllers/task_list_controller')
	loader.require('coffeescript/controllers/task_multiselect_list_controller')

	Pad.appName = "Tent Editable"
	Pad.editableName = "Tent Uneditable"
	Pad.email = "test@test.com"
	Pad.numeric = "qwe"
	Pad.dateFormat= "dd/mm/yy"
	Pad.date = new Date()
	Pad.amount = '1234567.67'
	Pad.isRequired = true
	Pad.isReadOnly = false
	Pad.isDisabled = false
	Pad.textDisplay = false
	Pad.isFilter = false
	Pad.lowes = {name:'Lowes', program:'Lowes Pgm', total: '562849.46', min: '2,000.00 USD'}

	Pad.modalSubmit = ->
		console.log("Submit button clicked")
	Pad.modalCancel = ->
		console.log("Cancel button clicked")

	#Pad.gridSelection = Ember.Object.create({id: 52,title: "Task 2"})
	#Pad.gridRemoteSelection = Ember.Object.create({id: 52,title: "Task 2"})

	Pad.jqGridSelection = [
		Ember.Object.create
			id: 53,
			title: "Task 3",
			amount: 123456.789,
			duration: "7 days",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
	]

	Pad.jqGridSelectionNoCollection = [
		Ember.Object.create
			id: 53,
			title: "Task 3",
			amount: 123456.789,
			duration: "7 days",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
	]

	Pad.jqOnEditRow = (rowId, grid) ->
		console.log 'pad  onedit'
		initialValue = grid.getCell(rowId, 'amount')
		calcCell = grid.find('#'+rowId + '_calc')
		calcCell.val(initialValue)
		@saveEditedRow(rowId)

	Pad.jqOnRestoreRow = (rowId, grid) ->
		console.log "restoring row ["+rowId+"]"
		
	Pad.jqOnSaveCell = (rowId, grid, cellName, iCell) ->
		console.log "Cell ["+cellName+"] was saved"

	Pad.gridSelection = Ember.Object.create({
			id: 52,
			title: "Task 2",
			duration: "6 days",
			percentComplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortDriven: 1
	})

	Pad.gridRemoteSelection = Ember.Object.create({
			id: 56,
			title: "Task 6",
			duration: "2 days",
			percentComplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortDriven: 1
	})

	Pad.gridRemoteSelectionMultiple = [Ember.Object.create({
			id: 54,
			title: "Task 4",
			duration: "2 days",
			percentComplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortDriven: 1
	})]
 
	Pad.jqGridContent = [ 
		Ember.Object.create({
			id: 51
			title: "Task 1"
			amount: 123456.789
			duration: "5"
			percentcomplete: Math.round(Math.random() * 100)
			start: new Date("01/01/2009")
			finish: new Date("01/05/2009")
			effortdriven: 1
			completed: true
		}),
		Ember.Object.create({
			id: 52,
			title: "Task 2",
			amount: 123456.789,
			duration: "6",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: true
		}),
		Ember.Object.create({
			id: 53,
			title: "Task 3",
			amount: 123456.789,
			duration: "7",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		}),
		Ember.Object.create({
			id: 54,
			title: "Task 4",
			amount: 123456.789,
			duration: "14",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		}),
		Ember.Object.create({
			id: 55,
			title: "Task 5",
			amount: 123456.789,
			duration: "27",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		}),
		Ember.Object.create({
			id: 56,
			title: "Task 6",
			amount: 123456.789,
			duration: "2",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		}),
		Ember.Object.create({
			id: 57,
			title: "XTask 7",
			amount: 123456.789,
			duration: "75",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		})
	]


	Pad.jqRemoteCollection = Tent.Data.Collection.create
		store: Pad.dataStore
		dataType: Pad.Models.TaskModel
		paged: true




	Pad.remoteCollection = Tent.Data.Collection.create
		store: Pad.dataStore
		dataType: Pad.Models.TaskModel
		paged: true

	Pad.remoteMultiselectCollection = Tent.Data.Collection.create
		store: Pad.dataStore
		dataType: Pad.Models.TaskModel
		paged: true

	Pad.clientSideCollection = Tent.Data.Collection.create
		store: Pad.dataStore
		dataType: Pad.Models.TaskModel
		paged: false

	Pad.gridColumnDescriptor = [
			{id: "id", name: "id", title: "_hID", field: "id", width:5, sortable: true, hidden: true, formatter: "action", formatoptions: {action: "showInvoiceDetails"}, hideable: true},
			{id: "title", name: "title", title: "_hTitle", field: "title", width:5, sortable: true, hideable: false},
			{id: "amount", name: "amount", title: "_hAmount", field: "amount", width:5, editable: true, hideable: false, sortable: true, formatter: "amount", align: 'right' },
			{id: "calc", name: "calc", title: "calc", width:5, editable: true, formatter: "amount", align: 'right', editoptions:{dataInit: @calc} },

			{id: "duration", name: "duration", title: "_hDuration",field: "duration", width:10, sortable: true, align: 'right', formatter: 'selectEdit', editoptions:{value: {1:'One',2:'Two',3:'Three',4:'Four',5:'Five',6:'Six',7:'Seven',8:'Eight'}}},
			{id: "%", name: "percentcomplete", title: "_hPercentComplete",field: "percentcomplete", width:10},
			{id: "effortdriven", name: "effortdriven", title: "_hEffortDriven", field: "effortdriven", width:10},
			{id: "start", name: "start", title: "_hStart",field: "start", width:10, formatter: "date"},
			{id: "finish", name: "finish", title: "_hFinish",field: "finish", width:10, hideable: true, formatter:"date"}
			{id: "completed", name: "completed", title: "_hCompleted",field: "completed", width:30, hideable: true, formatter: 'checkboxEdit', align: 'center', editable: false}
	]

	Pad.people = [
		Ember.Object.create({name: 'Matt', age: 22})
		Ember.Object.create({name: 'Raghu', age: 1000})
		Ember.Object.create({name: 'Sakshi', age: 21})
		Ember.Object.create({name: 'Amit', age: 30})
		Ember.Object.create({name: 'Khajan', age: 31})          
	]

	Pad.columns = "name,age"

	Pad.selectedPerson = [Pad.people[2]]
	Pad.multiSelectedPerson = [Pad.people[2], Pad.people[3]]

	Tent.Enumeration =
		YESNO: ['Yes', 'No']
		STATES: ['AL', 'AK', 'CA', 'GA', 'HI']

	Pad.content = [
		Ember.Object.create({stateName: "_georgia", stateCode: "GA"}),
		Ember.Object.create({stateName: "_arkansas", stateCode: "AR"}),
		Ember.Object.create({stateName: "_florida", stateCode: "FL"})
	]

	Pad.stateSelection = Pad.content[1]	

	Pad.contents = [
		Ember.Object.create({stateName: "_georgia", stateCode: "GA"}),
		Ember.Object.create({stateName: "_arkansas", stateCode: "AR"}),
		Ember.Object.create({stateName: "_florida", stateCode: "FL"})
	]

	Pad.statesSelection = [Pad.contents[1], Pad.contents[2]]
	Pad.radioSelection = Pad.contents[2]

	Pad.checkGroupContent = ["AP", "AL", "AT"]
	count = 1

	Pad.clickEvent = ()->
		$('#click-label').text('clicked '+(count++)+' times')

	Pad.btnOptions = [
		Ember.Object.create({label: "Add", target: "Pad.groupTarget", action: "addEvent"}),
		Ember.Object.create({label: "Edit", target: "Pad.groupTarget", action: "editEvent"}),
		Ember.Object.create({label: "Delete", target: "Pad.groupTarget", action: "deleteEvent"})
	]
	Pad.optionsMissingLabel = [
		Ember.Object.create({target: "Pad.groupTarget", action: "addEvent"}),
		Ember.Object.create({target: "Pad.groupTarget", action: "editEvent"}),
		Ember.Object.create({target: "Pad.groupTarget", action: "deleteEvent"})
	]
	Pad.optionsMissingTarget = [
		Ember.Object.create({label: "Add", action: "addEvent"}),
		Ember.Object.create({label: "Edit", action: "editEvent"}),
		Ember.Object.create({label: "Delete", action: "deleteEvent"})
	]

	Pad.groupTarget = Ember.Object.create({
		addEvent: ->
			alert("action add clicked");
			return false
		,
		editEvent: ->
			alert("action edit clicked");
			return false
		,
		deleteEvent: ->
			alert("action delete clicked");
			return false
	})

	Pad.uploadSuccessFunction = (result, textStatus, jqXHR) ->
	  alert(textStatus)

	Pad.reopen(
		ready: ->
			this._super();
			console.log('initializing ...');
		 
	)

)(minispade)
