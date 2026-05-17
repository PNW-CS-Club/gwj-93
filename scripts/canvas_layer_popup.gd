extends CanvasLayer

@onready var cabinButton: TextureButton = %CabinButton
@onready var shopButton: TextureButton = %ShopButton
@onready var cabin: Panel = %Cabin
@onready var shop: Panel = %Shop

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cabinButton.show()
	shopButton.show()
	cabin.hide()
	shop.hide()
	
	cabinButton.pressed.connect(_on_cabin_button_pressed)
	shopButton.pressed.connect(_on_shop_button_pressed)

func _on_cabin_button_pressed() -> void:
	cabin.show()
	
func _on_shop_button_pressed() -> void:
	shop.show()
