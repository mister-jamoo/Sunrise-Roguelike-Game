extends Area2D

func _ready():
	$AnimationPlayer.play("bounce")

func _on_XP_GEM_body_entered(body):
	var xp = clamp(randi() % 3, 20, 30)
	$Tween.follow_property(self, "position", self.position, body, "position", 0.2, Tween.TRANS_EXPO, Tween.EASE_IN)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	body.getXP(xp)
	queue_free()
