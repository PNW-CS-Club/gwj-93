extends Control

var challengeDictFile

#labels for each of the challenges
@onready var chal1Label: Label = %chal1
@onready var chal2Label: Label = %chal2
@onready var chal3Label: Label = %chal3

#the uncheck boxes
@onready var uncheck1: TextureRect = %uncheck1
@onready var uncheck2: TextureRect = %uncheck2
@onready var uncheck3: TextureRect = %uncheck3

#constact check mark image that will load in when the player finishes the challenge
const checkMark: Texture2D = preload("res://Screenshot 2026-05-13 201245.jpg")

#var used to track the amount for hte challenge
var chal1Track = 10
var chal2Track = 0
var chal3Track = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	challengeDictFile = preload("uid://cwefb8hhlbqqx").new()
	var challengeDict = challengeDictFile.challenge
	
	displayObj(challengeDict)
	checkifCompleted()
	

#this will display all the challenges in the panel
func displayObj(challengeDict: Dictionary) -> void:
	
	for i in range(1):
		chal1Label.text = challengeDict["challenge1"]["Desc"]
		chal2Label.text = challengeDict["challenge2"]["Desc"]
		chal3Label.text = challengeDict["challenge3"]["Desc"]

#function to show if the objective has been completed or not 
func checkifCompleted() -> void:
	if chal1Track >= challengeDictFile.maxNumber1:
		uncheck1.texture = checkMark
		
	elif chal2Track >= challengeDictFile.maxNumber2:
		uncheck2.texture = checkMark
		
	elif chal3Track >= challengeDictFile.maxNumber3:
		uncheck3.texture = checkMark
	
