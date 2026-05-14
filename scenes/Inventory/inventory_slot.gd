extends Button

class_name InventorySlot

var stack: ItemStack
var index: int

@onready var bg_sprite: Sprite2D = $Background
@onready var container: CenterContainer = $CenterContainer


func put_stack(new_stack: ItemStack):
	stack = new_stack
	bg_sprite.frame = 1
	container.add_child(stack)
	
func take_stack():
		var old_stack = stack
		if old_stack:
			container.remove_child(stack)
			bg_sprite.frame = 0
			stack = null
		
		return old_stack

func is_empty():
	return !stack
