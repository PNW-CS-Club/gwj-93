extends Control

signal new_item_added(plants: plantItem)

@onready var shopButton: TextureButton = %shopButton
@onready var shopPanel: PanelContainer = %shopPanel
@onready var shopItemGrid: GridContainer = %shopItemGrid
@onready var confirmWindow: PanelContainer = %confirmWindow

const SHOP_ITEM = preload("res://shop_scence_full.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shopPanel.hide()
	confirmWindow.hide()
	
	shopButton.pressed.connect(_on_shop_button_pressed)
	
	_refresh_shop_item()

func _on_shop_button_pressed():
	shopPanel.visible = not shopPanel.visible
	
func _refresh_shop_item():
	for child in shopItemGrid.get_children():
		child.queue_free()
	
	for plants: plantItem in AllPlants.shopItems:
		var shopItemsNode = SHOP_ITEM.instantiate()
		print(plants)
		shopItemsNode.plants = plants
		shopItemGrid.add_child(shopItemsNode)
		shopItemsNode.pressed.connect(_on_item_selected)
		
func _on_item_selected(plantResource: plantItem):
	confirmWindow.text = "Are you sure you want to buy %s ?" % plantResource.itemName
	confirmWindow.show()
	
	var confirm = await confirmWindow.confirmed
	
	if confirm:
		_item_bought(plantResource)
		
func _item_bought(plantResource: plantItem):
	AllPlants.shopItems.erase(plantResource)
	
	_refresh_shop_item()
	
	new_item_added.emit()
