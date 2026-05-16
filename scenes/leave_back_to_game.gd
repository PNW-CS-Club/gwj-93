extends Button

@onready var doorButton: Button = %leaveBackToGame
@onready var cabinScence: Panel = %cabinScene
@onready var cabinButton: TextureButton = %transCabinButton

signal showDaysSignal()


func _ready() -> void:
	doorButton.pressed.connect(_on_pressed_Door)

func _on_pressed_Door() -> void:
	emit_signal("showDaysSignal")
	cabinScence.hide()
	cabinButton.show()
