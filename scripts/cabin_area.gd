class_name CabinArea extends Area2D

@onready var _sprite = $Sprite2D
var can_select: bool = true
var is_in_menu: bool = false
var _is_hovering: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_select)
	mouse_exited.connect(_deselect)

func _process(_delta) -> void:
	if can_select and _is_hovering and not is_in_menu:
		_sprite.frame = 1
	else: 
		_sprite.frame = 0

func _select(): _is_hovering = true
func _deselect(): _is_hovering = false
