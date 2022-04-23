extends CanvasLayer

onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var playerStats = get_tree().get_nodes_in_group("PlayerStats")[0]

var character_book = preload ("res://Scenes/Character_Book.tscn")
var level_up_panel = preload("res://Scenes/Level_Up_Panel.tscn")

var path = "res://Assets/16x16 RPG Item Pack/"

var traits_array = []

func _process(_delta):
	if Input.is_action_just_pressed("character_book"):
		if(get_node_or_null("Character_Book")):
			$Tween.interpolate_property($Character_Book, "rect_position:x", $Character_Book.rect_position.x, 1200, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
			$Tween.start()
			yield($Tween,"tween_all_completed")
			$Character_Book.queue_free()
			get_tree().paused = false
		else:
			var character_book_instance = character_book.instance()
			add_child(character_book_instance)
			populateInventory(player.inventory.items, player.equipment.equipped, player.traits.traits)
			$Character_Book.update_character_stats(
			playerStats.level, 
			playerStats.base_damage, 
			playerStats.attack_speed, 
			playerStats.crit_chance,
			playerStats.hit_rating, 
			playerStats.max_health, 
			playerStats.health_regen, 
			playerStats.movement_speed, 
			playerStats.max_solar_energy,
			playerStats.armor * 10)
			$Tween.interpolate_property($Character_Book, "rect_position:x", $Character_Book.rect_position.x, 124.5, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
			$Tween.start()
		
			get_tree().paused = true

func _ready():
	$HealthBar.max_value = playerStats.max_health
	$HealthBar.value = playerStats.current_health
	$HealthBar/HealthBarText.text = str(playerStats.current_health) + "/" + str(playerStats.max_health) 
	
	$SolarBar.value = playerStats.current_solar_energy * 100
	$SolarBar.max_value = playerStats.max_solar_energy
	$SolarBar/SolarBarText.text = str(playerStats.current_solar_energy * 100)  + "/" + str(playerStats.max_solar_energy)
	
	$XpBar.value = playerStats.current_xp
	$XpBar.max_value = playerStats.max_xp
	$XpBar/XpBarText.text = str(playerStats.current_xp)  + "/" + str(playerStats.max_xp)
	$XpBar/LevelText.text = "Level: " + str(playerStats.level)

	player.connect("take_damage", self, "update_GUI")
	playerStats.connect("regen_health", self, "update_GUI")
	playerStats.connect("set_solar_energy", self, "update_GUI")
	playerStats.connect("set_xp", self, "update_GUI")
	playerStats.connect("level_up", self, "level_up_GUI")
	
func populateInventory(items, equipped, traits):
	var inventory = $Character_Book/Page_1/Inventory
	var equipmentInv = $Character_Book/Page_1/Equipment
	var traitsPage = $Character_Book/Page_2/Traits
	
	for i in items.size():
		var slot = inventory.get_child(i).get_child(0)
		slot.connect("item_moved", self, "swap_items")
		slot.connect("item_unequipped", self,"unequip_item")
		slot.index = i
		slot.type = "inventory"
		if(items[i] != null):	
			slot.texture = items[i].texture
	
	for i in equipped.size():
		var slot = equipmentInv.get_child(i).get_child(0)
		slot.connect("equipment_moved", self, "swap_equipment")
		slot.connect("item_equipped", self, "equip_item")
		slot.index = i
		slot.type = "equipped"
		if(equipped[i] != null):	
			slot.texture = equipped[i].texture
			
	for i in traits.size():
		var slot = traitsPage.get_child(i).get_child(0)
		slot.index = i
		slot.type = "trait"
		if(traits[i] != null):	
			slot.texture = traits[i].texture
			
func unequip_item(data):
	var equipment_slot = data["from"]
	var inventory_slot = data["to"]

	var moved_item = player.equipment.remove_item_from_slot(equipment_slot)
	var swapped_item = player.inventory.remove_item_from_slot(inventory_slot)
	player.inventory.add_item_to_slot(moved_item, inventory_slot)
	player.equipment.add_item_to_slot(swapped_item, equipment_slot)
	
	var equipment = $Character_Book/Page_1/Equipment
	var inventory = $Character_Book/Page_1/Inventory
	var from = equipment.get_child(equipment_slot).get_child(0)
	var to = inventory.get_child(inventory_slot).get_child(0)
	var temp = to.texture
	to.texture = from.texture
	from.texture = temp
	
	player.remove_weapon(moved_item)
	if(swapped_item != null):
		player.instance_weapon(swapped_item)
	
func equip_item(data):
	var equipment_slot = data["to"]
	var inventory_slot = data["from"]

	var moved_item = player.inventory.remove_item_from_slot(inventory_slot)
	var swapped_item = player.equipment.remove_item_from_slot(equipment_slot)
	player.equipment.add_item_to_slot(moved_item, equipment_slot)
	player.inventory.add_item_to_slot(swapped_item, inventory_slot)

	var equipment = $Character_Book/Page_1/Equipment
	var inventory = $Character_Book/Page_1/Inventory 
	var from = inventory.get_child(inventory_slot).get_child(0)
	var to = equipment.get_child(equipment_slot).get_child(0)
	var temp = to.texture
	to.texture = from.texture
	from.texture = temp
	
	if(swapped_item != null):
		player.remove_weapon(swapped_item)
	player.instance_weapon(moved_item)

func swap_items(data):
	player.inventory.swap_items(data["from"], data["to"])
	
	var inventory = $Character_Book/Page_1/Inventory
	var from = inventory.get_child(data["from"]).get_child(0)
	var to = inventory.get_child(data["to"]).get_child(0)
	var temp = to.texture
	to.texture = from.texture
	from.texture = temp

func swap_equipment(data):
	player.equipment.swap_equipment(data["from"], data["to"])
	
	var equipmentInv = $Character_Book/Page_1/Equipment
	var from = equipmentInv.get_child(data["from"]).get_child(0)
	var to = equipmentInv.get_child(data["to"]).get_child(0)
	var temp = to.texture
	to.texture = from.texture
	from.texture = temp

func pick_trait(trait):
	player.traits.add_trait(trait)
	print(trait.stat1)
	var stat_name = trait.stat1[0]
	var stat_value = trait.stat1[1]
	playerStats.set(stat_name, playerStats.get(stat_name) + stat_value)
	
	update_GUI()
	
	
func pick_item(item):
	player.inventory.add_item(item)
	

func update_GUI():
#	HEALTH
	var initial_value = $HealthBar.value
	var final_value = playerStats.current_health
	var duration = 0.2
	$HealthBar/HealthBarText.text = str(clamp(playerStats.current_health, 0, playerStats.max_health)) + "/" + str(playerStats.max_health) 
	$Tween.interpolate_property($HealthBar, "value", initial_value, final_value, duration, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	
#	SOLAR ENERGY
	initial_value = $SolarBar.value
	final_value = playerStats.current_solar_energy * 100
	$SolarBar/SolarBarText.text = str(clamp(playerStats.current_solar_energy * 100, 0, playerStats.max_solar_energy)) + "/" + str(playerStats.max_solar_energy) 
	$Tween.interpolate_property($SolarBar, "value", initial_value, final_value, duration, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$Tween.start()
	
#	XP
	initial_value = $XpBar.value
	final_value = playerStats.current_xp
	$XpBar/XpBarText.text = str(clamp(playerStats.current_xp, 0, playerStats.max_xp)) + "/" + str(playerStats.max_xp) 
	$Tween.interpolate_property($XpBar, "value", initial_value, final_value, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	
func level_up_GUI():
	$XpBar.value = 0
	$XpBar.max_value = playerStats.max_xp
	$XpBar/XpBarText.text = str(playerStats.current_xp)  + "/" + str(playerStats.max_xp)
	$XpBar/LevelText.text = "Level: " + str(playerStats.level)
	
	var level_up_panel_instance = level_up_panel.instance()
	add_child(level_up_panel_instance)
	level_up_panel_instance.connect("item_picked", self, "pick_item")
	level_up_panel_instance.connect("trait_picked", self, "pick_trait")
	
	level_up_panel_instance.update_level(playerStats.level)
	get_tree().paused = true
	
