extends PanelContainer


func _make_custom_tooltip(_for_text: String) -> Object:
	
	var label = Label.new()
	label.text = "Would you like to start crafting?"
	label.add_theme_font_size_override("font_size", 16)

	return label
