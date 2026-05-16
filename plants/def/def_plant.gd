class_name DefensePlant extends Plant

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	stats.level_changed.connect(_on_level_changed)
	sprite.frame = stats.level - 1

func _on_level_changed(level: int) -> void:
	sprite.frame = level - 1

func ability():
	print("I'm Doug the Defense Plant!!")
