extends CanvasLayer

@onready var cabinButton: TextureButton = %cabinButton
@onready var cabinScene: Panel = %cabinScene2
@onready var seedPanel: Panel = %seedPanel2
@onready var shopButton: TextureButton = %shopButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cabinButton.show()
	seedPanel.hide()
	
	cabinButton.pressed.connect(_on_cabin_button_pressed)
	shopButton.pressed.connect(_on_shop_button_pressed)

func _on_cabin_button_pressed() -> void:
	cabinScene.show()
	
func _on_shop_button_pressed() -> void:
	seedPanel.show()
