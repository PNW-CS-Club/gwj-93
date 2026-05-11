class_name DefensePlant extends Plant
@export var stats: Stats

func _ready():
	%HealthBar.value = stats.base_max_health

func _process(delta: float) -> void:
	%HealthBar.value = stats.health

func ability():
	pass
