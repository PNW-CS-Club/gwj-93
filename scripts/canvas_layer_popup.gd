extends CanvasLayer

@onready var cabin_area: CabinArea = %CabinArea
@onready var shop_button: BaseButton = %ShopButton
@onready var cabin: BaseButton = %Cabin
@onready var shop: BaseButton = %Shop

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cabin.hide()
	shop.hide()
	
	cabin_area.input_event.connect(_handle_cabin_input)
	shop_button.pressed.connect(func(): shop.show())
	cabin.pressed.connect(func(): cabin.hide())
	shop.pressed.connect(func(): shop.hide())

func _handle_cabin_input(_viewport: Node, event: InputEvent, _index: int):
	if cabin.visible or shop.visible: return
	var left_clicked = event is InputEventMouseButton && event.is_pressed() && event.button_index == MOUSE_BUTTON_LEFT
	if left_clicked: 
		cabin.show()
