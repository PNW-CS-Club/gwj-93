extends CanvasLayer

@onready var shopButton: TextureButton = %shopButton
@onready var seedPanel: Panel = %seedPanel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	seedPanel.hide()
	
	shopButton.pressed.connect(_on_shop_button_pressed)

func _on_shop_button_pressed():
	seedPanel.visible = not seedPanel.visible
