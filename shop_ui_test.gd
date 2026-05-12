extends CanvasLayer

@onready var shopButton: TextureButton = %shopButton
@onready var seedPanel: Panel = %seedPanel

#three random plants
@onready var firstRandomPlant: Control = $seedPanel/firstRandomPlant
@onready var secondRandomPlant: Control = $seedPanel/secondRandomPlant
@onready var thirdRandomPlant: Control = $seedPanel/thirdRandomPlant

#buy button
@onready var firstBuyButton: Button = %firstButton
@onready var secondBuyButton: Button = %secondButton
@onready var thirdBuyButton: Button = %thirdButton

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
	
	var duplicateDict = Global.buyablePlants.duplicate()
	var i = 0
	
	displayPlantsHelper(duplicateDict, i)

#recursive function that will display our random plants each time the player clicks on the shop
func displayPlantsHelper(duplicateDict: Dictionary, i: int) -> void:
	var randNum = randi_range(0, 2)
	
	if i > 2:
		return
		
	elif !duplicateDict.has(randNum):
		displayPlantsHelper(duplicateDict, i)
	
	elif duplicateDict.has(randNum):
		if i == 0:
			get_node("seedPanel/firstRandomPlant/name1").text = duplicateDict[randNum]["Name"]
			get_node("seedPanel/firstRandomPlant/firstPlantPicture").texture = duplicateDict[randNum]["Icon"]
			get_node("seedPanel/firstRandomPlant/desc1").text = duplicateDict[randNum]["Desc"]
			duplicateDict.erase(randNum)
			displayPlantsHelper(duplicateDict, i+1)
		elif i == 1:
			get_node("seedPanel/secondRandomPlant/name2").text = duplicateDict[randNum]["Name"]
			get_node("seedPanel/secondRandomPlant/secondPlantPicture").texture = duplicateDict[randNum]["Icon"]
			get_node("seedPanel/secondRandomPlant/desc2").text = duplicateDict[randNum]["Desc"]
			duplicateDict.erase(randNum)
			displayPlantsHelper(duplicateDict, i+1)
	
		elif i == 2:
			get_node("seedPanel/thirdRandomPlant/name3").text = duplicateDict[randNum]["Name"]
			get_node("seedPanel/thirdRandomPlant/thirdPlantPicture").texture = duplicateDict[randNum]["Icon"]
			get_node("seedPanel/thirdRandomPlant/desc3").text = duplicateDict[randNum]["Desc"]
			duplicateDict.erase(randNum)
			displayPlantsHelper(duplicateDict, i+1)

func displayPotions() -> void:
	
	for i in range(Global.buyablePotions.size()):
		
		if i == 0:
			get_node("seedPanel/healthPotion/healthPotionName").text = Global.buyablePotions[i]["Name"]
			get_node("seedPanel/healthPotion/healthPicture").texture = Global.buyablePotions[i]["Icon"]
		elif i == 1:
			get_node("seedPanel/evasionPotion/evasionPotionName").text = Global.buyablePotions[i]["Name"]
			get_node("seedPanel/evasionPotion/evasionPicture").texture = Global.buyablePotions[i]["Icon"]

#func _on_buy_pressed() -> void:
	#TYPE_NIL
