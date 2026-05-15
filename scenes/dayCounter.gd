extends Control

@onready var dayCounter: Label = %dayLabel

const day = 5

func _ready() -> void:
	
	dayCounter.text = " Day %s " % [str(day)]
