extends CanvasLayer

onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var playerStats = get_tree().get_nodes_in_group("PlayerStats")[0]

var character_book = preload ("res://Scenes/Character_Book.tscn")

var path = "res://Assets/16x16 RPG Item Pack/"
var dir = Directory.new()

var items_array = []
var inventory_slots = []
var equipment_slots = []



func _process(delta):
	if Input.is_action_just_pressed("character_book"):
		if($Character_Book):
			$Character_Book.queue_free()
		else:
			var character_book_instance = character_book.instance()
			add_child(character_book_instance)
			$Character_Book.populateInventory(inventory_slots)

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
	
	
	for n in range(0,71):
		var texture = load("res://Assets/16x16 RPG Item Pack/Item__" + str(n) + ".png")
		items_array.append(texture)
#
	inventory_slots.append(items_array[0])
#
	player.connect("take_damage", self, "update_GUI")
	playerStats.connect("regen_health", self, "update_GUI")
	playerStats.connect("set_solar_energy", self, "update_GUI")
	playerStats.connect("set_xp", self, "update_GUI")
	playerStats.connect("level_up", self, "level_up_GUI")

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
	
