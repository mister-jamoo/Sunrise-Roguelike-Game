extends Light2D


onready var player = get_tree().get_nodes_in_group("Player")[0]
onready var playerStats = get_tree().get_nodes_in_group("PlayerStats")[0]

func _ready():
	playerStats.connect("set_solar_energy", self, "update_solar_energy")
	
func update_solar_energy():
	energy = playerStats.current_solar_energy
	texture_scale = playerStats.current_solar_energy
