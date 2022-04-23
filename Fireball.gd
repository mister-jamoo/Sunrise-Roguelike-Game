extends Node2D

var target
var damageArr

func _ready():
	$Tween.follow_property(self, "global_position", self.global_position, target.get_ref(), "global_position", 0.5, Tween.TRANS_EXPO, Tween.EASE_IN)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	if(target.get_ref() != null):
		target.get_ref().takeDamage(damageArr[0], damageArr[1])
	queue_free()
	
func _process(delta):
	if(target.get_ref() != null):
		self.look_at(target.get_ref().global_position)
	else:
		queue_free()
	
