extends PanelContainer

signal confirmed(boolean: bool)

@export var text: String

@onready var label: Label = %Label
@onready var confirmButton: Button = %ConfirmButton
@onready var cancelButton: Button = %CancelButton

func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)
	
	confirmButton.pressed.connect(_on_button_pressed.bind(true))
	cancelButton.pressed.connect(_on_button_pressed.bind(false))
	
	
func _on_visibility_changed():
	if visible:
		label.text = text
		
func _on_button_pressed(boolean: bool):
	hide()
	confirmed.emit(boolean)
