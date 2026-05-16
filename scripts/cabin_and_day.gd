extends Control


#this is the main in which handles all of the signals for the childs in cabin and day 
func _ready() -> void:
	$Cabin/cabinScene/bedPanel/bedButton.updateDayCounter.connect($DayUI.updateDay)
	$Cabin/cabinScene.hideDayCounter.connect($DayUI.hideDayLabel)
	$Cabin/cabinScene/doorPanel/leaveBackToGame.showDaysSignal.connect($DayUI.showDaysAgain)
	$Cabin/cabinScene/bedPanel/bedButton.showDaysSignal.connect($DayUI.showDaysAgain)
	
