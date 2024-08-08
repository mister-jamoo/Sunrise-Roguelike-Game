extends Node2D

var fireball = preload("res://Scenes/Fireball.tscn")

func _ready():
	randomize()
	$AnimatedSprite.play("Idle")
	$Cast_Timer.start(3)
	
func _on_Cast_Timer_timeout():
	var targets = $Area2D.get_overlapping_bodies()
	if(targets.size() >= 1):
		var current_target = randi() % targets.size() - 1
		var fireball_instance = fireball.instance()
		fireball_instance.target = weakref(targets[current_target])
		fireball_instance.damageArr = get_parent().get_parent().get_parent().deal_solar_damage()
		add_child(fireball_instance)
		
