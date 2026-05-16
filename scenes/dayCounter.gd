extends Control

@onready var dayUIPanel: PanelContainer = %PanelContainer
@onready var dayCounterIU: Label = %dayLabel

var day = 2

func _ready() -> void:
	
	dayCounterIU.text = " Day %s " % [str(day)]

#update the day when the signal is called
func updateDay() -> void:
	day = day + 1
	dayCounterIU.text = " Day %s " % [str(day)]

#hide the day label when the cabin is opened
func hideDayLabel() -> void:
	dayUIPanel.hide()

#show the day label when pressing ESC to leave the cabin
func showDaysAgain() -> void:
	dayUIPanel.show()
