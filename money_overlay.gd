extends Control

@onready var moneyLabel: Label = %moneyLabel
@onready var testButton: Button = %testButton

var coins = 1000

func _ready() -> void:
	
	moneyLabel.text = str(coins)
	testButton.pressed.connect(_test_button_click.bind())


func _test_button_click() -> void:
	coins = coins+10
	moneyLabel.text = str(coins)
	print("clicked")
	print(coins)

func _subtract_amount(subtract: int) -> void:
	coins = coins-subtract
	moneyLabel.text = str(coins)
	
	
	
