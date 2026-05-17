extends Control

var challengeDictFile

#labels for each of the challenges
@onready var label1: Label = %chal1
@onready var label2: Label = %chal2
@onready var label3: Label = %chal3

@onready var uncheck1: TextureRect = %uncheck1
@onready var uncheck2: TextureRect = %uncheck2
@onready var uncheck3: TextureRect = %uncheck3

# check mark image that will load in when the player finishes the challenge
const checkMark: Texture2D = preload("res://Screenshot 2026-05-13 201245.jpg")

# var used to track the amount for the challenge
var chal1Track = 10
var chal2Track = 0
var chal3Track = 0

func _ready() -> void:

	challengeDictFile = preload("res://scripts/challengeDict.gd").new()
	var challengeDict = challengeDictFile.challenge
	
	displayObj(challengeDict)
	_check_completion()


# this will display all the challenges in the panel
func displayObj(challengeDict: Dictionary) -> void:
	
	for i in range(1):
		label1.text = challengeDict["challenge1"]["Desc"]
		label2.text = challengeDict["challenge2"]["Desc"]
		label3.text = challengeDict["challenge3"]["Desc"]

# shows whether the objective has been completed 
func _check_completion() -> void:
	if chal1Track >= challengeDictFile.maxNumber1:
		uncheck1.texture = checkMark
		
	elif chal2Track >= challengeDictFile.maxNumber2:
		uncheck2.texture = checkMark
		
	elif chal3Track >= challengeDictFile.maxNumber3:
		uncheck3.texture = checkMark
	
