extends Node

var current_health;

export (int) var max_health = 20;
export (int) var base_damage = 10;
export (float) var crit_chance = 0.15;
export (int) var crit_modifier = 3;
export (float) var movement_speed = 50;
export (float) var attack_speed = 1;
export (float) var armor = 0.1;

func _ready():
	current_health = max_health;
