	
Pad.Models.TaskModel = DS.Model.extend
	title: DS.attr('string')
	amount: DS.attr('number')
	duration: DS.attr('string')
	percentcomplete: DS.attr('string')
	start: DS.attr('date')
	finish: DS.attr('date')
	effortdriven: DS.attr('string')
	completed: DS.attr('boolean')

defaultModel = []

for i in [0...99]
	defaultModel.push 
		id: i
		title: "Task " + i
		amount: 123456.789
		duration: "5"
		percentcomplete: Math.round(Math.random() * 100)
		start: "01/01/2009"
		finish: "01/05/2009"
		effortdriven: -1
		completed: true

Pad.Models.TaskModel.FIXTURES = defaultModel