extends CanvasLayer

@onready var dayUI: Control = %DayUI
@onready var coinOverlay: Control = %CoinOverlay
@onready var challengeUI: Control = %ChallengeUI
@onready var hotBar: Inventory = %Hotbar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dayUI.show()
	coinOverlay.show()
	challengeUI.show()
	hotBar.show()
	
