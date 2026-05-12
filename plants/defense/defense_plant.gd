class_name DefensePlant extends Plant
@export var stats: Stats

@onready var health_bar: ProgressBar = %HealthBar/ProgressBar

func _ready():
	health_bar.max_value = stats.base_max_health
	health_bar.value = stats.base_max_health

func _process(_delta: float) -> void:
	health_bar.value = stats.health

func ability():
	pass
