extends Resource

var objectives = {
	"obj1" : {
		"Desc": "Kill a number of mobs %s",
		"Max Number": 10,
		"Completed": false,
		"finished": preload("res://Screenshot 2026-05-13 201245.jpg")
	},
	"obj2": {
		"Desc": "Pick a certain number of plants %s",
		"Max Number": 20,
		"Completed": false,
		"finished": preload("res://Screenshot 2026-05-13 201245.jpg")
	},
	"obj3": {
		"Desc": "Pay your dues to the God or DIE %s",
		"Max Number": 100,
		"Completed": false,
		"finished": preload("res://Screenshot 2026-05-13 201245.jpg")
	} 
}

func updateMaxNumber(newMax: int, whichKeyObj: String) -> void:
	
	objectives[whichKeyObj]["Max Number"] = newMax
	
