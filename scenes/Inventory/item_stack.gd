extends Panel

class_name ItemStack

@onready var item_sprite: Sprite2D = $Item
@onready var amount_label: Label = $Label

# item and amount automatically update the gui when they are set
var item: InventoryItem: set = _update_item
var amount: int: set = _update_amount

func _update_item(value: InventoryItem): 
	item = value
	item_sprite.visible = true
	item_sprite.texture = item.texture
	
func _update_amount(value: int): 
	amount = value
	if amount > 1:
		amount_label.visible = true
		amount_label.text = str(amount)
	else:
		amount_label.visible = false
