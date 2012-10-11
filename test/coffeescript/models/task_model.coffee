	
Pad.Models.TaskModel = DS.Model.extend
	id: DS.attr('number')
	title: DS.attr('string')
	amount: DS.attr('number')
	duration: DS.attr('string')
	percentcomplete: DS.attr('string')
	start: DS.attr('date')
	finish: DS.attr('date')
	effortdriven: DS.attr('string')
	completed: DS.attr('boolean')

Pad.Models.TaskModel.FIXTURES = [{
			id: 51
			title: "Task 1"
			amount: 123456.789
			duration: "5"
			percentcomplete: Math.round(Math.random() * 100)
			start: new Date("01/01/2009")
			finish: new Date("01/05/2009")
			effortdriven: 1
			completed: true
		},
		{
			id: 52,
			title: "Task 2",
			amount: 123456.789,
			duration: "6",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: true
		},
		{
			id: 53,
			title: "Task 3",
			amount: 123456.789,
			duration: "7",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 54,
			title: "Task 4",
			amount: 123456.789,
			duration: "14",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 55,
			title: "Task 5",
			amount: 123456.789,
			duration: "27",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 56,
			title: "Task 6",
			amount: 123456.789,
			duration: "2",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 57,
			title: "XTask 7",
			amount: 123456.789,
			duration: "75",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 58,
			title: "YTask 8",
			amount: 123456.789,
			duration: "7",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 59,
			title: "ZTask 9",
			amount: 123456.789,
			duration: "7 days",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 60,
			title: "Task 10",
			amount: 123456.789,
			duration: "7 days",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 61,
			title: "Task 11",
			amount: 123456.789,
			duration: "7 days",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 62,
			title: "Task 12",
			amount: 123456.789,
			duration: "7 days",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 63,
			title: "Task 13",
			amount: 123456.789,
			duration: "7 days",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 64,
			title: "Task 14",
			amount: 123456.789,
			duration: "7 days",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 65,
			title: "Task 15",
			amount: 123456.789,
			duration: "7 days",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 66,
			title: "Task 16",
			amount: 123456.789,
			duration: "7 days",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 67,
			title: "Task 17",
			amount: 123456.789,
			duration: "7 days",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 68,
			title: "Task 18",
			amount: 123456.789,
			duration: "7 days",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 69,
			title: "Task 19",
			amount: 123456.789,
			duration: "7 days",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 70,
			title: "Task 20",
			amount: 123456.789,
			duration: "7 days",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 71,
			title: "Task 21",
			amount: 123456.789,
			duration: "7 days",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 72,
			title: "Task 22",
			amount: 123456.789,
			duration: "7 days",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
		},
		{
			id: 73,
			title: "Task 23",
			amount: 123456.789,
			duration: "7 days",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 74,
			title: "Task 24",
			amount: 123456.789,
			duration: "7 days",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 75,
			title: "Task 25",
			amount: 123456.789,
			duration: "7 days",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 76,
			title: "Task 26",
			amount: 123456.789,
			duration: "7 days",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		},
		{
			id: 77,
			title: "Task 27",
			amount: 123456.789,
			duration: "7 days",
			percentcomplete: Math.round(Math.random() * 100),
			start: new Date("01/01/2009"),
			finish: new Date("01/05/2009"),
			effortdriven: 1
			completed: false
		}
	]