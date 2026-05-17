extends Button

@onready var doorButton: Button = %BackButton
@onready var cabin: Control = $"../.."

func _make_custom_tooltip(_for_text: String) -> Object:
	
	var label = Label.new()
	label.text = "Return to field"
	label.add_theme_font_size_override("font_size", 16)

	return label

func _ready() -> void:
	doorButton.pressed.connect(_on_pressed_Door)

func _on_pressed_Door() -> void:
	cabin.hide()
