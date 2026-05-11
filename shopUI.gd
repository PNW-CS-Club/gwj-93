extends Control

signal new_item_added(item: Item)

@onready var shopButton: TextureButton = %ShopButton
@onready var shopPage: PanelContainer = %ShopPage
@onready var shopItemGrid: GridContainer = %ShopItemGrid

@onready var confirmWindow: PanelContainer = %ConfirmWindow

const SHOP_ITEM = preload("res://ShopItem.tscn") #what is going on here

#when this starts the UI will be hidden but when the button is clicked the shop will come up and will then be refreshed each time
func _ready() -> void:
	shopPage.hide()
	confirmWindow.hide()
	
	shopButton.pressed.connect(_on_shop_button_pressed)
	
	_refresh_shop_item()
	
func _refresh_shop_item():
	for child in shopItemGrid.get_children():
		child.queue_free()
	
	for item: Item in PlantManager.shopItems:
		var shopItemsNode = SHOP_ITEM.instantiate()
		shopItemsNode.PlantResource = item
		shopItemGrid.add_child(shopItemsNode)
		shopItemsNode.pressed.connect(_on_item_selected)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if shopPage.visible: shopPage.hide()

func _on_item_selected(itemResource: Item):
	confirmWindow.text = "Are you sure you want to buy %s ?" % itemResource.itemName
	confirmWindow.show()
	
	var confirm = await confirmWindow.confirmed
	
	if confirm:
		_item_bought(itemResource)

	
func _on_shop_button_pressed():
	shopPage.visible = not shopPage.visible

func _item_bought(item: Item):
	PlantManager.shopItems.erase(item)
	
	_refresh_shop_item()
	
	new_item_added.emit()
