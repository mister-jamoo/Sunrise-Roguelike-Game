extends Node

var player

	

func _physics_process(_delta):
	player = get_node("/root/level_1/YSort/Player")
	
	
	if Input.is_action_just_pressed("Debug_AddAxe"):
		player.inventory.add_item(Armory.all_items_array[2])
	if Input.is_action_just_pressed("Debug_AddSword"):
		player.inventory.add_item(Armory.all_items_array[0])
	if Input.is_action_just_pressed("Debug_AddBow"):
		player.inventory.add_item(Armory.all_items_array[1])
	if Input.is_action_just_pressed("Debug_AddStaff"):
		player.inventory.add_item(Armory.all_items_array[3])
	if Input.is_action_just_pressed("Debug_AddShield"):
		player.inventory.add_item(Armory.all_items_array[4])
	if Input.is_action_just_pressed("Debug_AddBoots"):
		player.inventory.add_item(Armory.all_items_array[5])
	
	
