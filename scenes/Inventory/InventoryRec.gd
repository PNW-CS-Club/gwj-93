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
