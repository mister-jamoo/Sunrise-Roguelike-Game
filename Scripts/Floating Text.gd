extends Position2D

var amount = 0;
var crit;
var duration = 1.0
var travel
var spread = PI/2

func _ready():
	if(amount > 0):
		$Label.set_text(str(amount))
	else:
		$Label.set_text("miss")
	
	var movement = travel.rotated(rand_range(-spread/2, spread/2))
	$Label.rect_pivot_offset = $Label.rect_size / 2
	
	$Tween.interpolate_property($Label, "rect_position",
		$Label.rect_position, $Label.rect_position + movement,
		duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Label, "modulate:a",
		1.0, 0.0, duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		
	if crit:
		$Label.modulate = Color(1, 0.2, 0)
		$Tween.interpolate_property($Label, "rect_scale", $Label.rect_scale*2, $Label.rect_scale,
		0.4, Tween.TRANS_BACK, Tween.EASE_IN)
	
	$Tween.start()
	yield($Tween, "tween_all_completed")
	queue_free()
		
		

