extends Button


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	##tooltip_text = ("Would you like to end the day?")

func _make_custom_tooltip(_for_text: String) -> Object:
	
	var label = Label.new()
	label.text = "Would you like to end the day?"
	label.add_theme_font_size_override("font_size", 16)

	return label
