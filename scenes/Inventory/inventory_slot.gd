extends Button

class_name InventorySlot

var stack: ItemStack
var index: int

@onready var _bg_sprite: Sprite2D = $Background
@onready var _container: CenterContainer = $CenterContainer


func put_stack(new_stack: ItemStack):
	stack = new_stack
	_bg_sprite.frame = 1
	_container.add_child(stack)
	
func take_stack():
		var old_stack = stack
		if old_stack:
			_container.remove_child(stack)
			_bg_sprite.frame = 0
			stack = null
		
		return old_stack

func is_empty():
	return !stack
