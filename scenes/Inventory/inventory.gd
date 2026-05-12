extends Control

var isOpen: bool = false

@onready var inventory: Inventory = preload("res://scenes/Inventory/playerInventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
func _ready():
	update()

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])

func open():
	visible = true
	isOpen = true
	
func close():
	visible = false
	isOpen = false
