extends StaticBody2D

func _ready():
	$AnimationPlayer.play("Idle")

func _on_Area2D_body_entered(_body):
	$AnimationPlayer.play("Open")


func _on_Area2D_body_exited(_body):
	$AnimationPlayer.play_backwards("Open")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("Idle")
