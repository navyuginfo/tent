((loader) -> 

	loader.require('coffeescript/app')
	loader.require('coffeescript/router')
	loader.require('coffeescript/controllers/application_controller')
	loader.require('coffeescript/i18n/translations')
	loader.require('coffeescript/store/datastore')

	loader.require('coffeescript/models/paging_adapter')
	loader.require('coffeescript/models/task_model')
	loader.require('template/task_collection_filter')
	loader.require('coffeescript/view/common/collection_panels/task_collection_panel_view')

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

	#loader.require('coffeescript/view/task_list')
	loader.require('coffeescript/controllers/task_list_controller')
	loader.require('coffeescript/controllers/task_multiselect_list_controller')

	Pad.appName = "Tent Editable"
	Pad.editableName = "Tent Uneditable"
	Pad.email = "test@test.com"
	Pad.numeric = "qwe"
	Pad.dateFormat= "dd/mm/yy"
	Pad.date = new Date()
	Pad.spinner = 27	 
	Pad.startDate = new Date("12/6/2012")
	Pad.endDate = new Date("12/21/2012")
	Pad.amount = '1234567.67'
	Pad.isRequired = true
	Pad.isReadOnly = false
	Pad.isDisabled = false
	Pad.textDisplay = false
	Pad.isFilter = false
	Pad.isMultiselect = true
	Pad.isEditable = false
	Pad.showGrid = true
	Pad.lowes = {name:'Lowes', program:'Lowes Pgm', total: '562849.46', min: '2,000.00 USD'}
	Pad.currencies = ['USD','JPY','XXX','CNY', 'YYY']
	Pad.changingCurrency = 'XXX'
	Pad.stateValue = 'GA'
	Pad.enabledExports=['csv']
	#Pad.presetRanges = [
    #	{text: 'My Range', dateStart: '03/07/08', dateEnd: 'Today' }
  	#]
  	#Pad.presets = {specificDate: 'Pick a date'}

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
		pageSize: 5



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

	Pad.colorContent = [
		Ember.Object.create({colorName: "Red", colorCode: "rd"}),
		Ember.Object.create({colorName: "Green", colorCode: "gr"}),
		Ember.Object.create({colorName: "Blue", colorCode: "bl"})
		Ember.Object.create({colorName: "Brown", colorCode: "br"})
		Ember.Object.create({colorName: "Black", colorCode: "bk"})
		Ember.Object.create({colorName: "Orange", colorCode: "or"})
		Ember.Object.create({colorName: "Grey", colorCode: "gy"})
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

	Pad.clickCancelOuter = ->
		#alert('cancel outer.')
	Pad.clickCancelInner = ->
		#alert('cancel inner.')

	Pad.FolderClickOptions = [
		Em.Object.create({value: "activate", label:"Activate"}),
		Em.Object.create({value: "expand", label:"Expand"}),
		Em.Object.create({value: "activateAndExpand", label:"Activate & Expand"}),
		Em.Object.create({value: "expandOnDblClick", label:"Expand on Double Click"})
	]

	Pad.FolderSelection = Pad.FolderClickOptions[3]

	Pad.SelectOptions = [
		Em.Object.create({value: "singleSelect", label:"Single Select"}),
		Em.Object.create({value: "multiSelect", label:"Multi Select"}),
		Em.Object.create({value: "heirMultiSelect", label:"Heirarchical Multi Select"}),
	]

	Pad.NodeSelection = Pad.SelectOptions[1]

	Pad.TreeOptions = Ember.Object.create({
    activeVisible: true,
    aria: false,
    autoActivate: true,
    autoCollapse: false,
    autoScroll: false,
    checkbox: false,
    disabled: false,
    icons: false,
    keyboard: true,
    tabbable: true,
    hideDefaults: false,
    radio: false,
    defaultCode: (->
      defaultOptionHash = {
        activeVisible: true,
        aria: false,
        autoActivate: true,
        autoCollapse: false,
        autoScroll: false,
        checkbox: false,
        disabled: false,
        icons: false,
        keyboard: true,
        tabbable: true,
        radio: false,
        nodeSelection: 'multiSelect',
        folderOnClickShould: 'expandOnDblClick'
      }
      optionsString = ""
      for own option, value of defaultOptionHash
        selectedValue = @get(option)
        selectedValue = @get('treeFolderValue') || 'expandOnDblClick' if option is 'folderOnClickShould'
        selectedValue = @get('treeSelectValue') || 'multiSelect' if option is 'nodeSelection'      	
        unless value is selectedValue
          selectedValue = "\"#{selectedValue}\"" if option is 'folderOnClickShould' or option is 'nodeSelection'
          optionsString += " #{option}=#{selectedValue} \n"
      return "\n{{view Tent.Tree}}" if optionsString is ""
      "\n{{view Tent.Tree \n#{optionsString[..-2]}\n}}"
    ).property('activeVisible','aria', 'autoActivate','autoCollapse','autoScroll','checkbox',
      'disabled', 'icons','radio', 'keyboard', 'tabbable', 'treeSelectValue', 'treeFolderValue')
    handlebarsCode: (->
      options = ['radio','activeVisible', 'aria', 'autoActivate', 'autoCollapse', 'autoScroll',
        'checkbox', 'disabled', 'radio','icons', 'keyboard', 'tabbable', 'nodeSelection', 'folderOnClickShould']
      optionsString = ""
      for option in  options
        value = @get(option)
        if option is 'folderOnClickShould'
          value = "\"#{@get('treeFolderValue') || 'expandOnDblClick'}\""
        if option is 'nodeSelection'
        	value = "\"#{@get('treeSelectValue') || 'multiSelect'}\""
        optionsString += "  #{option}=#{value} \n"
      "\n{{view Tent.Tree \n#{optionsString[..-2]}\n}}"
    ).property('radio','activeVisible','aria', 'autoActivate','autoCollapse','autoScroll','checkbox',
      'disabled', 'icons', 'keyboard', 'tabbable', 'treeSelectValue', 'treeFolderValue')
	})

	Pad.treeTarget = Em.Object.create({
		addRootChild: ->
			Em.View.views["testpad-tree"].addChildrenToRootNode([{
				title: "programmatically added node", 
				folder: true,
				children:[{title: "Child-1", value: 'child-1'}]
			}])
		addActiveChild: ->
			Em.View.views["testpad-tree"].addChildrenToActiveNode([{
				title: "programmatically added node", 
				folder: true,
				children:[{title: "Child-1", value: 'child-1'}]
			}])
		initialize: ->
			Em.View.views["testpad-tree"].reinitialize()
		expandAll: ->
			Em.View.views["testpad-tree"].expandAll()
		collapseAll: ->
			Em.View.views["testpad-tree"].collapseAll()
		toggleExpand: ->
			Em.View.views["testpad-tree"].toggleExpand()
		selectAll: ->
			Em.View.views["testpad-tree"].selectAll()
		deselectAll: ->
			Em.View.views["testpad-tree"].deselectAll()
		toggleSelection: ->
			Em.View.views["testpad-tree"].toggleSelect()
	})

	Pad.treeActions = [
		Ember.Object.create({label: "Add Child to Root", target: "Pad.treeTarget", action: "addRootChild"}),
		Ember.Object.create({label: "Add Child to Active Node", target: "Pad.treeTarget", action: "addActiveChild"}),
		Ember.Object.create({label: "Init", target: "Pad.treeTarget", action: "initialize"})
		Ember.Object.create({label: "Expand All", target: "Pad.treeTarget", action: "expandAll"})
		Ember.Object.create({label: "Collapse All", target: "Pad.treeTarget", action: "collapseAll"})
		Ember.Object.create({label: "Toggle Expand", target: "Pad.treeTarget", action: "toggleExpand"})
		Ember.Object.create({label: "Select All", target: "Pad.treeTarget", action: "selectAll"})
		Ember.Object.create({label: "Deselect All", target: "Pad.treeTarget", action: "deselectAll"})
		Ember.Object.create({label: "Toggle Selection", target: "Pad.treeTarget", action: "toggleSelection"})
	]

	Pad.TreeData = [
		{
		  title: "RBS"
		  tooltip: "Look, a tool tip!"
		  folder: true
		  children: [
		  	{title: 'Node', tooltip: 'Just a plain normal node with a tooltip', value: 'tooltip'},
		  ]
		},
		{
		  title: "Jabil"
		  tooltip: "Look, a tool tip!"
		  folder: true
		  expanded: true
		  children: [
		  	{title: 'Jabil Committed(SU)', value: 'Jabil Committed(SU)'},
		  	{title: '<span>Some <b>html</b> using <code>span</code> tag</span>', value: 'node with html'}
		  ]
		},
		{
		  title: "Node at Level-1"
		  tooltip: "Look, a tool tip!"
		  folder: true
		  expanded: true
		  children: [
		  	{
		  		title: 'Node at Level-2'
		  		folder: true
		  		children: [
		  			{
		  				title: 'Node at Level-3',
		  				folder: true
		  				children: [
		  					{title: 'Leaf Node at Level-4', value: 'leaf node at Level-4'}
		  				]
		  			}
		  		]
		  	},
		  	{title: 'Can apply classes to node !', "extraClasses": 'btn-primary', value: 'node with extraClasses'}
		  ]
		}
	]


)(minispade)
