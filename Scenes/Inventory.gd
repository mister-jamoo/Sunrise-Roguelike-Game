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
			
func swap_items(from, to):
	var temp = items[to] 
	items[to] = items[from]
	items[from] = temp
