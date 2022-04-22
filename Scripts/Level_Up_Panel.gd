extends TextureRect

func generate_upgrades():
	pass
	
func update_level(level):
	$Level_Up_New_Level.text += str(level)


func _on_Choice_1_pressed():
	get_tree().paused = false
	queue_free()
	
	


func _on_Choice_2_pressed():
	get_tree().paused = false
	queue_free()



func _on_Choice_3_pressed():
	get_tree().paused = false
	queue_free()

