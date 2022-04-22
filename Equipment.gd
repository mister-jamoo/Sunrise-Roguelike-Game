extends Node

var equipment = []

func _init():
	for i in 4:
		equipment.append(null)
	
	print(equipment)

func add_item(item):
	for n in equipment.size():
		if(equipment[n] == null):
			equipment[n] = item
			break
			
func swap_items(from, to):
	var temp = equipment[to] 
	equipment[to] = equipment[from]
	equipment[from] = equipment
