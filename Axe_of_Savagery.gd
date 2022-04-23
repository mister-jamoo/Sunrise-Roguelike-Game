extends Node2D

signal deal_damage

func _ready():
	$AnimationPlayer.play("Spin")


func _on_Area2D_body_entered(body):
	print("damaging", body)
	emit_signal("deal_damage", body)
