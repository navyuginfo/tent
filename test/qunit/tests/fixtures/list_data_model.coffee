Tent.Fixtures = Tent.Fixtures || {}

Tent.Fixtures.ListDataModel = DS.Model.extend
	id: DS.attr('number')
	title: DS.attr('string')
	duration: DS.attr('string')
	percentComplete: DS.attr('string')
	start: DS.attr('string')
	finish: DS.attr('string')
	effortDriven: DS.attr('string')

Tent.Fixtures.ListDataModel.FIXTURES = [{
			id: 1,
			title: "Task 1",
			duration: "5 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 2,
			title: "Task 2",
			duration: "6 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 3,
			title: "Task 3",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 4,
			title: "Task 4",
			duration: "14 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 5,
			title: "Task 5",
			duration: "27 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 6,
			title: "Task 6",
			duration: "2 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 7,
			title: "Task 7",
			duration: "75 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 8,
			title: "Task 8",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 9,
			title: "Task 9",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 10,
			title: "Task 10",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 11,
			title: "Task 11",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 12,
			title: "Task 12",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 13,
			title: "Task 13",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 14,
			title: "Task 14",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 15,
			title: "Task 15",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 16,
			title: "Task 16",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 17,
			title: "Task 17",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 18,
			title: "Task 18",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 19,
			title: "Task 19",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 20,
			title: "Task 20",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 21,
			title: "Task 21",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 22,
			title: "Task 22",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 23,
			title: "Task 23",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 24,
			title: "Task 24",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		},
		{
			id: 25,
			title: "Task 25",
			duration: "7 days",
			percentComplete: Math.round(Math.random() * 100),
			start: "01/01/2009",
			finish: "01/05/2009",
			effortDriven: 1
		}
	]