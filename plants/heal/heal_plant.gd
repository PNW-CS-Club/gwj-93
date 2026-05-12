class_name HealPlant extends Plant

@export var stats: Stats
@onready var health_bar: ProgressBar = %HealthBar/ProgressBar

func _ready():
	health_bar.max_value = stats.base_max_health
	health_bar.value = stats.base_max_health

func _process(delta: float) -> void:
	health_bar.value = stats.health

## Heal plants in adjacent squares for 30 HP
func ability():
	pass
