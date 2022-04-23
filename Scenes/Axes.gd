extends Node2D

export var rotation_speed = PI * 2

func _physics_process(delta):
	$pivot.rotation += rotation_speed * delta
