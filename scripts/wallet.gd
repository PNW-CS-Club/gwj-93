class_name Wallet extends Control

@onready var moneyLabel: Label = %moneyLabel

#our currency for the game
var coins: int

#the ready function will display the amount of coins on the screen
func _ready() -> void:
	
	moneyLabel.text = str(coins)


#this method will subtract the amount that is purchased
#this method is also being called in the shop_ui_test
func change_balance(amount: int) -> void:
	coins = coins + amount
	moneyLabel.text = str(coins)
	
