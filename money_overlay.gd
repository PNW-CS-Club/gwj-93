extends Control

@onready var moneyLabel: Label = %moneyLabel
@onready var testButton: Button = %testButton

#our currency for the game
var coins = 1000

#the ready function will display the amount of coins on the screen
func _ready() -> void:
	
	moneyLabel.text = str(coins)
	testButton.pressed.connect(_test_button_click.bind())

#NOTE will remove this later
func _test_button_click() -> void:
	
	coins = coins+10
	moneyLabel.text = str(coins)
	print("clicked")
	print(coins)

#this method will subtract the amount that is purchased
#this method is also being called in the shop_ui_test
func subtractAmount(subtract: int) -> void:
	
	if subtract > coins:
		print("You do not have enough money")
	else:
		print("You have bought the item")
		coins = coins-subtract
		moneyLabel.text = str(coins)
	
	
	
