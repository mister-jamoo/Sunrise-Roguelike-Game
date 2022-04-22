extends TextureRect

var page
var page_1 = []
var page_2 = []


func _ready():
	page = 1
	
	for n in 8:
		page_1.append($Page_1.get_child(n))
	for n in 6:
		page_2.append($Page_2.get_child(n))
	
	
	update_page()


func _on_TurnPageRight_pressed():
	for n in page_1.size():
		page_1[n].visible = false
	$AnimationPlayer.play("Turn Left")
	page = 2
	
func _on_TurnPageLeft_pressed():
	for n in page_2.size():
		page_2[n].visible = false
	$AnimationPlayer.play("Turn Right")
	page = 1

func update_character_stats(level, damage, attack_speed, crit_chance, hit_rating, health, health_regen, move_speed, solar_energy, armor):
	$Page_1/LeftPage_Body.bbcode_text = "Level : [color=white]" + str(level) +"\n[color=e09d66]Damage : [color=white]" + str(damage) + "\n[color=e09d66]Attack Speed :[color=white] " + str(attack_speed * 10) + "\n[color=e09d66]Armor :[color=white] " + str(armor * 10) + "%" +"\n[color=e09d66]Hit Chance :[color=white] " + str(hit_rating * 100) + "%" + "\n[color=e09d66]Crit Chance :[color=white] " + str(crit_chance * 100) + "%" + "\n[color=e09d66]Health :[color=white] " + str(health) + "\n[color=e09d66]HealthRegen : [color=white]" + str(health_regen * 10) + "\n[color=e09d66]Move Speed : [color=white]" + str(move_speed) + "\n[color=e09d66]Solar Energy : [color=white]" + str(solar_energy) + "\n"

func update_page():
	
	if(page == 1):
		for n in page_1.size():
			page_1[n].visible = true
	else:
		for n in page_1.size():
			page_1[n].visible = false
	
	if(page == 2):
		for n in page_2.size():
			page_2[n].visible = true
	else:
		for n in page_2.size():
			page_2[n].visible = false	
	
	


