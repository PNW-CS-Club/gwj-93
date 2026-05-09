extends MenuButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ShopButton.get_popup().add_item()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	pass # Replace with function body.
