extends Node

const Item = preload("Item.gd")
const Trait = preload("Trait.gd")

onready var sword_of_dread_texture = load("res://Assets/16x16 RPG Item Pack/Item__0.png")
onready var bow_of_wisdom_texture = load("res://Assets/16x16 RPG Item Pack/Item__17.png")
onready var axe_of_savagery_texture = load("res://Assets/16x16 RPG Item Pack/Item__13.png")
onready var staff_of_solar_texture = load("res://Assets/16x16 RPG Item Pack/Item__23.png")
onready var shield_of_slowing_texture = load("res://Assets/16x16 RPG Item Pack/Item__25.png")
onready var boots_of_speed_texture = load("res://Assets/16x16 RPG Item Pack/Item__50.png")

onready var health_texture = load("res://Assets/16x16 RPG Item Pack/Item__67.png")
onready var health_regen_texture = load("res://Assets/16x16 RPG Item Pack/Item__29.png")
onready var attack_speed_texture = load("res://Assets/16x16 RPG Item Pack/Item__16.png")
onready var damage_texture = load("res://Assets/16x16 RPG Item Pack/Item__8.png")
onready var hit_rating_texture = load("res://Assets/16x16 RPG Item Pack/Item__61.png")
onready var movement_speed_texture = load("res://Assets/16x16 RPG Item Pack/Item__48.png")
onready var armor_texture = load("res://Assets/16x16 RPG Item Pack/Item__57.png")
onready var crit_chance_texture = load("res://Assets/16x16 RPG Item Pack/Item__45.png")
onready var solar_energy_texture = load("res://Assets/16x16 RPG Item Pack/Item__27.png")

var all_items_array = []
var all_traits_array = []

func _ready():
	generate_all_items_and_traits()

func generate_all_items_and_traits():
	var item 
	item = generate_items("Sword of Dread", sword_of_dread_texture, "Gain the 'Sword of Dread' ability" ,"crit_chance", 0.3, null,null,null,null)
	all_items_array.append(item)
	item = generate_items("Bow of Wisdom", bow_of_wisdom_texture, "Gain the 'Bow of Wisdom' ability" ,"attack_speed", 1.5, null,null,null,null)
	all_items_array.append(item)
	item = generate_items("Axe of Savagery", axe_of_savagery_texture,"Gain the 'Axe of Savagery' ability" , "base_damage", 100, null,null,null,null)
	all_items_array.append(item)
	item = generate_items("Staff of Solar", staff_of_solar_texture,"Gain the 'Staff of Solar' ability" , "solar_energy", 200, null,null,null,null)
	all_items_array.append(item)
	item = generate_items("Shield of Slowing", shield_of_slowing_texture,"Gain the 'Shield of Slowing' ability" , "armor", 0.20, null,null,null,null)
	all_items_array.append(item)
	item = generate_items("Boots of Speed", boots_of_speed_texture,"Gain the 'Boots of Speed' ability" , "movement_speed", 30, null,null,null,null)
	all_items_array.append(item)
	
	item = generate_traits("Health", health_texture, "+50 to Max Health" , "max_health", 50)
	all_traits_array.append(item)
	item = generate_traits("Health Regen", health_regen_texture, "+0.5 to Health Regen" , "health_regen", 0.05)
	all_traits_array.append(item)
	item = generate_traits("Attack Speed", attack_speed_texture,"+5 to Attack Speed" , "attack_speed", 0.5)
	all_traits_array.append(item)
	item = generate_traits("Damage", damage_texture,"+5 to Base Damage" , "base_damage", 5)
	all_traits_array.append(item)
	item = generate_traits("Hit Rating", hit_rating_texture,"+5% to Hit Rating" , "hit_rating", 0.05)
	all_traits_array.append(item)
	item = generate_traits("Movement Speed", movement_speed_texture,"+10 to Movement Speed" ,  "movement_speed", 10)
	all_traits_array.append(item)
	item = generate_traits("Armor", armor_texture,"+5% to Armor", "armor",   0.05)
	all_traits_array.append(item)
	item = generate_traits("Crit Chance", crit_chance_texture,"+10% to Crit Chance" , "crit_chance", 0.1)
	all_traits_array.append(item)
	item = generate_traits("Solar Energy", solar_energy_texture,"+50 to Max Solar Energy" , "max_solar_energy", 50)
	all_traits_array.append(item)



func generate_items(item_name, item_texture, item_description, item_stat_1_name, item_stat_1_value, item_stat_2_name, item_stat_2_value, item_stat_3_name, item_stat_3_value):
	var item = Item.new()
	item.title = item_name
	item.texture = item_texture
	item.description = item_description
	item.stat1 = [item_stat_1_name, item_stat_1_value]
	item.stat2 = [item_stat_2_name, item_stat_2_value]
	item.stat3 = [item_stat_3_name, item_stat_3_value]
	return item
	
func generate_traits(trait_name, trait_texture, trait_description, trait_stat_name, trait_stat_value):
	var trait = Trait.new()
	trait.title = trait_name
	trait.texture = trait_texture
	trait.description = trait_description
	trait.stat1 = [trait_stat_name, trait_stat_value]
	return trait



