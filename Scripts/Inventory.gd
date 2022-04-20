extends GridContainer

var inventory_slots = []

func _ready():
	for n in 12:
		inventory_slots.append(get_child(n).get_child(0))

func addItems(inv_slots):
	for n in inv_slots.size():
		inventory_slots[n].set_texture(inv_slots[n]) 
		
