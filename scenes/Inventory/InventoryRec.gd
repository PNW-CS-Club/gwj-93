extends Resource

class_name Inventory

@export var slots: Array[InventorySlot]

func insert(item: InventoryItem):
	for slot in slots:
		if slot.item == item:
			slot.amount += 1
			return
			
		for i in range(slots.size()):
			if !slots[i].item:
				slots[i].item = item
				slots[i].amount = 1
				return

# Allows items to be inserted in slots and get rid of the old ones
func removeItemAtIndex(index: int):
	slots[index] = InventorySlot.new()
	
	
func insertSlot(index: int, inventorySlot: InventorySlot):
	var oldIndex: int = slots.find(inventorySlot)
	removeItemAtIndex(oldIndex)
	
	slots[index] = inventorySlot
	
