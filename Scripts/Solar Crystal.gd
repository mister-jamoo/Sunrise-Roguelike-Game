extends Node2D

func _ready():
	$AnimationPlayer.play("Idle")


func _on_Area2D_body_entered(body):
	$Tween.follow_property(self, "position", self.position, body, "position", 0.5, Tween.TRANS_EXPO, Tween.EASE_IN)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	queue_free()
