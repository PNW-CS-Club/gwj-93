extends Control

signal new_item_added(plants: plantItem)

@onready var shopButton: TextureButton = %shopButton
@onready var shopPanel: PanelContainer = %shopPanel
@onready var shopItemGrid: GridContainer = %shopItemGrid
@onready var confirmWindow: PanelContainer = %confirmWindow

const SHOP_ITEM = preload("res://shop_item.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shopPanel.hide()
	confirmWindow.hide()
	
	shopButton.pressed.connect(_on_shop_button_pressed)
	
func _on_shop_button_pressed():
	shopPanel.visible = not shopPanel.visible
	
