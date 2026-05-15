extends Resource

var challengeUIFile = preload("res://challenge_ui.gd").new()

#here are the max to complete the challenges we can obviously increment the max
var maxNumber1 = 10
var maxNumber2 = 10
var maxNumber3 = 100

#dictionary of challenges that are basic
var challenge = {
	"challenge1" : {
		"Desc": "Kill a number of mobs %s / %s" % [str(challengeUIFile.chal1Track), str(maxNumber1)],
		"Completed": false,
		"finished": preload("res://Screenshot 2026-05-13 201245.jpg")
	},
	"challenge2": {
		"Desc": "Pick a certain number of plants %s / %s" % [str(challengeUIFile.chal2Track), str(maxNumber2)],
		"Completed": false,
		"finished": preload("res://Screenshot 2026-05-13 201245.jpg")
	},
	"challenge3": {
		"Desc": "Pay your dues to the God or DIE %s" % [str(maxNumber3)],
		"Completed": false,
		"finished": preload("res://Screenshot 2026-05-13 201245.jpg")
	} 
}

func updateMaxNumber(whichKeyChal: String) -> void:
	
	if whichKeyChal == "challenge1":
		maxNumber1 += 10
	elif whichKeyChal == "challenge2":
		maxNumber2 += 10
	elif whichKeyChal == "challenge3":
		maxNumber3 += 100

func completedChallenge(whichKeyChal: String) -> void:
	challenge[whichKeyChal]["Completed"] = true
	
