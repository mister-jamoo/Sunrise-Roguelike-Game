extends Area2D

var fade_to_black = preload("res://Scenes/Fade_To_Black.tscn")
var instance
var alpha_value 
var duration_time = 2
func _ready():
	pass


func _on_GameArea_body_exited(_body):
	instance = fade_to_black.instance()
	add_child(instance)
	$Tween.interpolate_property(instance.get_child(0), "color", instance.get_child(0).color, Color(0,0,0,1), duration_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	

func _on_GameArea_body_entered(_body):
	if(instance != null):
		$Tween.interpolate_property(instance.get_child(0), "color", instance.get_child(0).color, Color(0,0,0,0), duration_time, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.start()
		yield($Tween, "tween_all_completed")
		instance.queue_free()
