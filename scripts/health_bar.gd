extends Node2D

@onready var health_bar = %ProgressBar
@onready var label = %Label

func _process(delta: float) -> void:
	label.text = "%.0f" % health_bar.value
