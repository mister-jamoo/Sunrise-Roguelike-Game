extends Node

var equipped = []

func _init():
	for i in 4:
		equipped.append(null)
	
func add_item(item):
	for n in equipped.size():
		if(equipped[n] == null):
			equipped[n] = item
			break

func add_item_to_slot(item, slot):
	equipped[slot] = item

func remove_item_from_slot(slot):
	var item = equipped[slot]
	equipped[slot] = null
	return item
			
func swap_equipment(from, to):
	var temp = equipped[to] 
	equipped[to] = equipped[from]
	equipped[from] = temp
