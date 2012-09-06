
((loader) -> 
	
	loader.require('coffeescript/app')
	loader.require('coffeescript/models/paging_adapter')
	loader.require('coffeescript/models/task_model')

	# TODO: Asynch binding is not functioning with this fixtureAdapter
	# Ensure the Rest adapter is working correctly 
	Pad.pagingAdapter.simulateRemoteResponse = false;
	Pad.store = DS.Store.create({
		revision: 4,
		adapter: Pad.pagingAdapter
	});

	loader.require('coffeescript/view/task_list')
	loader.require('coffeescript/controllers/task_list_controller')
	loader.require('coffeescript/controllers/task_multiselect_list_controller')

	Pad.appName = "Tent Editable"
	Pad.editableName = "Tent Uneditable"
	Pad.email = "test@test.com"
	Pad.numeric = 123.456
	Pad.dateFormat= "dd/mm/yy"
	Pad.date = new Date()

	Pad.people = [
		Ember.Object.create({name: 'Matt', age: 22})
		Ember.Object.create({name: 'Raghu', age: 1000})
		Ember.Object.create({name: 'Sakshi', age: 21})
		Ember.Object.create({name: 'Amit', age: 30})
		Ember.Object.create({name: 'Khajan', age: 31})          
	]

	Pad.columns = "name,age"

	selectedPerson = {}
	Tent.Enumeration =
		YESNO: ['Yes', 'No']
		STATES: ['AL', 'AK', 'CA', 'GA', 'HI']

	Pad.content = [
		Ember.Object.create({stateName: "Georgia", stateCode: "GA"}),
		Ember.Object.create({stateName: "Arkansas", stateCode: "AR"}),
		Ember.Object.create({stateName: "Florida", stateCode: "FL"})
	]

	Pad.contents = [
		Ember.Object.create({stateName: "Georgia", stateCode: "GA"}),
		Ember.Object.create({stateName: "Arkansas", stateCode: "AR"}),
		Ember.Object.create({stateName: "Florida", stateCode: "FL"})
	]

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

	Pad.reopen(
		ready: -> 
			this._super();
			console.log('initializing ...');
		taskListController: Pad.Controllers.TaskListController.create()
		taskMultiSelectListController: Pad.Controllers.TaskMultiSelectListController.create()
	)

)(minispade)

