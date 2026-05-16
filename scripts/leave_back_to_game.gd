extends Button

@onready var doorButton: Button = %leaveBackToGame
@onready var cabinScence: Panel = %cabinScene
@onready var cabinButton: TextureButton = %transCabinButton

signal showDaysSignal()

func _make_custom_tooltip(_for_text: String) -> Object:
	
	var label = Label.new()
	label.text = "Leave back to game"
	label.add_theme_font_size_override("font_size", 16)

	return label

func _ready() -> void:
	doorButton.pressed.connect(_on_pressed_Door)

func _on_pressed_Door() -> void:
	emit_signal("showDaysSignal")
	cabinScence.hide()
	cabinButton.show()
