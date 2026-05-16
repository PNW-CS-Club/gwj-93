extends Control

#signal hideDayCounter()

#func _ready() -> void:
	#cabinScence.hide()
	#cabinButton.pressed.connect(_on_pressed_cabin)
	 
#func _on_pressed_cabin() -> void:
	#emit_signal("hideDayCounter")
	#cabinScence.show()
	#cabinButton.hide()
#
#func showCabin() -> void:
	#cabinScence.hide()
	#cabinButton.show()
#
#func hideCabin() -> void:
	#cabinScence.hide()
