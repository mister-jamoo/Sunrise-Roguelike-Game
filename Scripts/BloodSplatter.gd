extends CPUParticles2D

func _ready():
	$Timeout.start(1)


func _on_Timeout_timeout():
	queue_free()
