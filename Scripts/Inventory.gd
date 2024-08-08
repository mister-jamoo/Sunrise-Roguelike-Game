extends Node

var items = []

func _init():
	for i in 12:
		items.append(null)

func add_item(item):
	for n in items.size():
		if(items[n] == null):
			items[n] = item
			break

func add_item_to_slot(item, slot):
	items[slot] = item

func remove_item_from_slot(slot):
	var item = items[slot]
	items[slot] = null
	return item

func swap_items(from, to):
	var temp = items[to] 
	items[to] = items[from]
	items[from] = temp
