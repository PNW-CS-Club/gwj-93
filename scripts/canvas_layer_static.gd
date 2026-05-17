extends CanvasLayer

@onready var coinOverlay: Control = %CoinOverlay
@onready var hotBar: Inventory = %Hotbar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coinOverlay.show()
	hotBar.show()
