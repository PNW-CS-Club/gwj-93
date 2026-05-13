extends Node
class_name Wallet

var total: int = 0

func change(amount: int) -> void: 
	total = total + amount
