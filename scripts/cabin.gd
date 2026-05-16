extends Control

@onready var cabinButton: TextureButton = %transCabinButton
@onready var cabinScence: Panel = %cabinScene

signal hideDayCounter()
signal showDays()

func _ready() -> void:
	cabinScence.hide()
	cabinButton.pressed.connect(_on_pressed_cabin)
	 
func _on_pressed_cabin() -> void:
	emit_signal("hideDayCounter")
	cabinScence.show()
	cabinButton.hide()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		cabinScence.hide()
		cabinButton.show()
		emit_signal("showDays")
