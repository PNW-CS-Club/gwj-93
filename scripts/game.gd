extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event):
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_0:
				print("key 0 pressed")
			KEY_1:
				print("key 1 pressed")
