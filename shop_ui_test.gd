extends CanvasLayer

@onready var dataDict = $"/root/DataDict"

@onready var shopButton: TextureButton = %shopButton
@onready var seedPanel: Panel = %seedPanel


#three random plants
@onready var firstRandomPlant: Control = $seedPanel/firstRandomPlant
@onready var secondRandomPlant: Control = $seedPanel/secondRandomPlant
@onready var thirdRandomPlant: Control = $seedPanel/thirdRandomPlant

#potions
@onready var healthPotion: Control = $seedPanel/healthPotion
@onready var evasPotion: Control = $seedPanel/evasionPotion


var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	seedPanel.hide()
	
	shopButton.pressed.connect(_on_shop_button_pressed)

func _on_shop_button_pressed():
	seedPanel.visible = not seedPanel.visible
	
	displayPlants()
	displayPotions()
	#display health potion and evasion poition 

func displayPlants() -> void:

	var duplicateDict = dataDict.buyablePlants.duplicate()
	var i = 0
	var empty = []
	
	var plantResults = displayPlantsHelper(duplicateDict, i, empty)

#recursive function that will display our random plants each time the player clicks on the shop
func displayPlantsHelper(duplicateDict: Dictionary, i: int, plantResults: Array) -> Array:
	var randNum = rng.randi_range(0,3)
	
	#firstRandomPlant.text = duplicateDict[randNum]["Name"]
	
	if i > 2:
		return plantResults
		
	elif !duplicateDict.has(randNum):
		displayPlantsHelper(duplicateDict, i, plantResults)
	
	elif duplicateDict.has(randNum):
		if i == 0:
			firstRandomPlant.get_node("name1").text = duplicateDict[randNum]["Name"]
			firstRandomPlant.get_node("firstPlantPicture").texture = duplicateDict[randNum]["Icon"]
			firstRandomPlant.get_node("desc1").text = duplicateDict[randNum]["Desc"]
			duplicateDict.erase(randNum)
			plantResults.append(randNum)
			displayPlantsHelper(duplicateDict, i+1, plantResults)
		elif i == 1:
			secondRandomPlant.get_node("name2").text = duplicateDict[randNum]["Name"]
			secondRandomPlant.get_node("secondPlantPicture").texture = duplicateDict[randNum]["Icon"]
			secondRandomPlant.get_node("desc2").text = duplicateDict[randNum]["Desc"]
			duplicateDict.erase(randNum)
			plantResults.append(randNum)
			displayPlantsHelper(duplicateDict, i+1,plantResults)
	
		elif i == 2:
			thirdRandomPlant.get_node("name3").text = duplicateDict[randNum]["Name"]
			thirdRandomPlant.get_node("thirdPlantPicture").texture = duplicateDict[randNum]["Icon"]
			thirdRandomPlant.get_node("desc3").text = duplicateDict[randNum]["Desc"]
			duplicateDict.erase(randNum)
			plantResults.append(randNum)
			displayPlantsHelper(duplicateDict, i+1, plantResults)
	
	return []

func displayPotions() -> void:
	
	for i in range(dataDict.buyablePotions.size()):
		
		if i == 0:
			healthPotion.get_node("healthPotionName").text = dataDict.buyablePotions[i]["Name"]
			healthPotion.get_node("healthPicture").texture = dataDict.buyablePotions[i]["Icon"]
			
		elif i == 1:
			evasPotion.get_node("evasionPotionName").text = dataDict.buyablePotions[i]["Name"]
			evasPotion.get_node("evasionPicture").texture = dataDict.buyablePotions[i]["Icon"]
			

#func _on_buy_pressed() -> void:
	#TYPE_NIL
