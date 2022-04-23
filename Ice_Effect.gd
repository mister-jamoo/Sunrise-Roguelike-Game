extends AnimatedSprite

func _ready():
	play()

func _on_Ice_Effect_animation_finished():
	queue_free()
