class_name InventorySlot extends Button

var stack: ItemStack
var index: int

@onready var _container = $CenterContainer

func put_stack(new_stack: ItemStack):
	stack = new_stack
	_container.add_child(stack)
	
func take_stack():
		var old_stack = stack
		if old_stack:
			_container.remove_child(stack)
			stack = null
		
		return old_stack

func is_empty():
	return !stack
