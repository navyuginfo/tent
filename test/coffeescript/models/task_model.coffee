
Pad.Models.TaskModel = DS.Model.extend
	id: DS.attr('number')
	title: DS.attr('string')
	duration: DS.attr('string')
	percentComplete: DS.attr('string')
	start: DS.attr('string')
	finish: DS.attr('string')
	effortDriven: DS.attr('string')

Pad.Models.TaskModel.FIXTURES = [{
			id: 51,
			title: "Task 1",
			duration: "5 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 52,
			title: "Task 2",
			duration: "6 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 53,
			title: "Task 3",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 54,
			title: "Task 4",
			duration: "14 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 55,
			title: "Task 5",
			duration: "27 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 56,
			title: "Task 6",
			duration: "2 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 57,
			title: "XTask 7",
			duration: "75 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 58,
			title: "YTask 8",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 59,
			title: "ZTask 9",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		}]