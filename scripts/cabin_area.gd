class_name CabinArea extends Area2D

@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(select)
	mouse_exited.connect(deselect)
	deselect()

func select(): sprite.frame = 1
func deselect(): sprite.frame = 0
