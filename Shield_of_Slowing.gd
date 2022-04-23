extends Node2D

var slow_amount

func _ready():
	$AnimatedSprite.playing = true


func _on_Area2D_body_entered(body):
	body.slowed(slow_amount)

func _on_Area2D_body_exited(body):
	body.unslow(slow_amount)
