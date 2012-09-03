	
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
		},
		{
			id: 60,
			title: "Task 10",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 61,
			title: "Task 11",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 62,
			title: "Task 12",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 63,
			title: "Task 13",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 64,
			title: "Task 14",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 65,
			title: "Task 15",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 66,
			title: "Task 16",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 67,
			title: "Task 17",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 68,
			title: "Task 18",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 69,
			title: "Task 19",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 70,
			title: "Task 20",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 71,
			title: "Task 21",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 72,
			title: "Task 22",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 73,
			title: "Task 23",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 74,
			title: "Task 24",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 75,
			title: "Task 25",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 76,
			title: "Task 26",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 77,
			title: "Task 27",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		}
	]