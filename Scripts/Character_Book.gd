extends CanvasLayer



func _ready():
	pass
	
func populateInventory(inv_slots):
	$OpenBook/Inventory.addItems(inv_slots)
