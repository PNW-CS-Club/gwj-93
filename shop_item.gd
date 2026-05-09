extends PanelContainer

signal pressed()



@onready var texture_rect: TextureRect = %TextureRect
@onready var label: Label = %Label
@onready var button: Button = %Button

func  _ready() -> void:
	button.pressed.connect(_on_button_pressed)
	
func _on_button_pressed():
	pressed.emit("icon.svg")
