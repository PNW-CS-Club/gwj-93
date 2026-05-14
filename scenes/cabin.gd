extends Control

@onready var cabinButton: TextureButton = %transCabinButton

func _ready() -> void:
	
	cabinButton.pressed.connect(_on_pressed_cabin)
	 
	
func _on_pressed_cabin() -> void:
	
	get_tree().change_scene_to_file("res://cabinScence.tscn")
	
	
	
