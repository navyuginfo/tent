((loader) -> 

	date = new Date()
	Pad.model0 = []
	Pad.model100 = []
	for i in [0...100]
		Pad.model100.push Pad.Models.TaskModel.createRecord
				id: i
				title: "Task " + i
				amount: 123456.789
				duration: "5"
				percentcomplete: Math.round(Math.random() * 100)
				start: date
				finish: date
				effortdriven: -1
				completed: true

	Pad.model200 = []
	for i in [0...200]
		Pad.model200.push Pad.Models.TaskModel.createRecord
				id: i
				title: "Task " + i
				amount: 123456.789
				duration: "5"
				percentcomplete: Math.round(Math.random() * 100)
				start: date
				finish: date
				effortdriven: -1
				completed: true
	Pad.model500 = []
	for i in [0...500]
		Pad.model500.push Pad.Models.TaskModel.createRecord
				id: i
				title: "Task " + i
				amount: 123456.789
				duration: "5"
				percentcomplete: Math.round(Math.random() * 100)
				start: date
				finish: date
				effortdriven: -1
				completed: true
	Pad.model1000 = []
	for i in [0...1000]
		Pad.model1000.push Pad.Models.TaskModel.createRecord
				id: i
				title: "Task " + i
				amount: 123456.789
				duration: "5"
				percentcomplete: Math.round(Math.random() * 100)
				start: date
				finish: date
				effortdriven: -1
				completed: true

)(minispade)
