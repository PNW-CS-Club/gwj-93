extends PanelContainer

signal pressed()

@export var item:Item

@onready var texture_rect: TextureRect = %TextureRect
@onready var label: Label = %Label
@onready var button: Button = $Button

func _ready() -> void: #this will display the picture and the label if we want we can also add specific stats as labels
	texture_rect.texture = item.texture
	label.text = item.itemName
	
	button.pressed.connect(_on_button_pressed)
	
func _on_button_pressed():
	pressed.emit(item)
	
