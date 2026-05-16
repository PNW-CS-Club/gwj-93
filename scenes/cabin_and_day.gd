extends Control


#this is the main in which handles all of the signals for the childs in cabin and day 
func _ready() -> void:
	$Cabin/cabinScene/PanelContainer/bedButton.updateDayCounter.connect($DayUI.updateDay)
	$Cabin/cabinScene.hideDayCounter.connect($DayUI.hideDayLabel)
	$Cabin/cabinScene.showDays.connect($DayUI.showDaysAgain)
