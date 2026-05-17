class_name Cabin extends Control

#re-emit the end_day signal from the bed button so that the game script can change game state
signal end_day

@onready var bed: Bed = %BedButton

func _ready() -> void:
	bed.end_day.connect(end_day.emit)
