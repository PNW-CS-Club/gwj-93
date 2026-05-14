extends Control

var objDict = preload("res://objectiveDict.gd").new()

@onready var obj1Label: Label = %obj1
@onready var obj2Label: Label = %obj2
@onready var obj3Label: Label = %obj3

@onready var checkBox1: TextureRect = %uncheck1
@onready var checkBox2: TextureRect = %uncheck2
@onready var checkBox3: TextureRect = %uncheck3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var objectDictionary = objDict.objectives
	
	displayObj(objectDictionary)
	

func displayObj(objectiveDictionary: Dictionary) -> void:
	
	for i in range(1):
		
		obj1Label.text = objectiveDictionary["obj1"]["Desc"]
		obj2Label.text = objectiveDictionary["obj2"]["Desc"]
		obj3Label.text = objectiveDictionary["obj3"]["Desc"]
		
	
	
