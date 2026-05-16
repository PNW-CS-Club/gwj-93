@abstract class_name Plant extends Node

@export var stats: Stats

# Note: all plants must have a Sprite2D child
@onready var sprite: Sprite2D = $Sprite2D

## Make sure to call super._ready() in all subclasses!
func _ready():
	stats.level_changed.connect(_on_level_changed)
	sprite.frame = stats.level - 1

func _on_level_changed(level: int) -> void:
	sprite.frame = level - 1

## The ability of the plant. Does not always require implementation
func ability():
	pass
