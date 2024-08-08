extends Node

export (int) var max_health = 100;
export (int) var current_health;
export (int) var base_damage = 10;
export (float) var health_regen = 0.05;
export (float) var crit_chance = 0.15;
export (int) var crit_modifier = 3;
export (int) var movement_speed = 40;
export (float) var attack_speed = 1.0;
export (float) var armor = 0.1
export (float) var hit_rating = 0.75;
export (float) var current_solar_energy = 1.0;
export (float) var max_solar_energy = 100.0;
#export (float) var solar_energy_deplete_rate = 0.05;
export (float) var solar_energy_deplete_rate = 0.00;
export (int) var current_xp = 0
export (int) var max_xp
export (int) var level = 1

signal regen_health
signal set_solar_energy
signal level_up
signal set_xp
signal death

func _ready():
	current_health = max_health;
	max_xp = level * 100	
	
func update_xp():
	emit_signal("set_xp")

func update_level_xp():
	level += 1
	print(level)
	current_xp = 0
	max_xp = level * 100
	emit_signal("level_up")

func _on_Health_regen_timeout():
	if(current_health < max_health):
		var health_to_regen = max_health * health_regen
		current_health += health_to_regen
	emit_signal("regen_health")

func _on_Solar_Energy_Timer_timeout():
	current_solar_energy -= solar_energy_deplete_rate
	emit_signal("set_solar_energy")
	if(current_solar_energy <= 0):
		emit_signal("death")

