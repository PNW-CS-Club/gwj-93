extends Button

@onready var bedButton: Button = %bedButton
@onready var cabinScene: Panel = %cabinScene
@onready var cabinButton: TextureButton = %transCabinButton

#signals called in order to update the day counter and the day panel when you click the bed to go to the night
signal updateDayCounter()
signal showDaysSignal()

func _ready() -> void:
	bedButton.pressed.connect(_bedClicked)

#the custom tool tip in which will show the player if he would like to end the day
func _make_custom_tooltip(_for_text: String) -> Object:
	
	var label = Label.new()
	label.text = "Would you like to end the day?"
	label.add_theme_font_size_override("font_size", 16)

	return label

#when the bed is clicked to end the day it will update the day counter we can change this because 
#we wanted to it to switch to night but this is kind of what i have so far
func _bedClicked() -> void:
	
	emit_signal("showDaysSignal")
	emit_signal("updateDayCounter")
	cabinButton.show()
	cabinScene.hide()
	
	
	
