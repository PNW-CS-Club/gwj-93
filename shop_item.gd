extends PanelContainer

signal pressed()

@export var plants: plantItem

@onready var texture_rect: TextureRect = %TextureRect
@onready var label: Label = %Label
@onready var button: Button = %Button

func _ready() -> void:
	texture_rect.texture = plants.texture
	label.text = plants.itemName
	
	button.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	pressed.emit(plantItem)
