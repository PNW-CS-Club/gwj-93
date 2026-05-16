extends CanvasLayer

#path used to access the data in the dictionaries
var dataDictionary = preload("res://scripts/dataDict.gd").new()

#used for opening opening up the shop
@onready var shopButton: TextureButton = %shopButton
@onready var seedPanel: Panel = %seedPanel

#three random plants
@onready var firstRandomPlant: Control = $seedPanel/firstRandomPlant
@onready var secondRandomPlant: Control = $seedPanel/secondRandomPlant
@onready var thirdRandomPlant: Control = $seedPanel/thirdRandomPlant

#potions
@onready var healthPotion: Control = $seedPanel/healthPotion
@onready var evasPotion: Control = $seedPanel/evasionPotion

#purchase buttons
@onready var firstButton: Button = $seedPanel/firstRandomPlant/firstButton
@onready var secondButton: Button = $seedPanel/secondRandomPlant/secondButton
@onready var thirdButton: Button = $seedPanel/thirdRandomPlant/thirdButton

#path used to access our currency
@onready var moneyOverlay = get_node("../CoinOverlay")

var rng = RandomNumberGenerator.new()

#TODO implement a close window button or panel 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	seedPanel.hide()
	
	shopButton.pressed.connect(_on_shop_button_pressed)

func _on_shop_button_pressed():
	seedPanel.visible = not seedPanel.visible
	
	displayPlants()
	displayPotions() 

func displayPlants() -> void:

	var duplicateDict = dataDictionary.buyablePlants.duplicate()
	var i = 0
	var empty = []
	
	var plantResults = displayPlantsHelper(duplicateDict, i, empty)
	
	#send a value as a parameter 
	firstButton.pressed.connect(_on_pressed_plant_purchase.bind(0, plantResults))
	secondButton.pressed.connect(_on_pressed_plant_purchase.bind(1, plantResults))
	thirdButton.pressed.connect(_on_pressed_plant_purchase.bind(2, plantResults))

func _on_pressed_plant_purchase(index: int, plantResults: Array) -> void:
	var buyablePlantKey
	
	if index == 0:
		print(0)
		buyablePlantKey = plantResults[index]
		print(dataDictionary.buyablePlants[buyablePlantKey]["Name"])
		moneyOverlay.subtractAmount(dataDictionary.buyablePlants[buyablePlantKey]["Cost"])
		
	elif index == 1:
		print(1)
		buyablePlantKey = plantResults[index]
		print(dataDictionary.buyablePlants[buyablePlantKey]["Name"])
		moneyOverlay.subtractAmount(dataDictionary.buyablePlants[buyablePlantKey]["Cost"])
		
	else:
		print(2)
		buyablePlantKey = plantResults[index]
		print(dataDictionary.buyablePlants[buyablePlantKey]["Name"])
		moneyOverlay.subtractAmount(dataDictionary.buyablePlants[buyablePlantKey]["Cost"])

#recursive function that will display our random plants each time the player clicks on the shop and will an array of the keys the plants can buy
#NOTE Here is where we would implement the calendar system, the seeds should be set to a specific amount and should not rotate until the next day
func displayPlantsHelper(duplicateDict: Dictionary, i: int, plantResults: Array) -> Array:
	var randNum = rng.randi_range(0,3)
	
	if !duplicateDict.has(randNum):
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
			
	
	return plantResults

#this function will display all the potions
func displayPotions() -> void:
	
	for i in range(dataDictionary.buyablePotions.size()):
		
		if i == 0:
			healthPotion.get_node("healthPotionName").text = dataDictionary.buyablePotions[i]["Name"]
			healthPotion.get_node("healthPicture").texture = dataDictionary.buyablePotions[i]["Icon"]
			
		elif i == 1:
			evasPotion.get_node("evasionPotionName").text = dataDictionary.buyablePotions[i]["Name"]
			evasPotion.get_node("evasionPicture").texture = dataDictionary.buyablePotions[i]["Icon"]
	
	#have to put the method for decreassing the money here as well

#func _on_buy_pressed() -> void:
	#TYPE_NIL
