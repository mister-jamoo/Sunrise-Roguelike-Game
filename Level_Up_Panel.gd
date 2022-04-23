extends TextureRect

var choice_array = []

signal item_picked
signal trait_picked

func _ready():
	randomize()
	generate_choices()
	
func generate_choices():
	var randomItem = randi() % Armory.all_items_array.size()
	choice_array.append(Armory.all_items_array[randomItem])
	for n in 2:
		var randomTraits = randi() % Armory.all_traits_array.size()
		choice_array.append(Armory.all_traits_array[randomTraits])
	
	choice_array.shuffle()
		
	update_choices(choice_array)

func update_choices(choice_array):
	for n in choice_array.size():
		$VBoxContainer.get_child(n).icon = choice_array[n].texture
		$VBoxContainer.get_child(n).get_child(0).text = str(choice_array[n].title)
		$VBoxContainer.get_child(n).get_child(1).text = str(choice_array[n].description)
		

func update_level(level):
	$Level_Up_New_Level.text += str(level)


func _on_Choice_1_pressed():
	if(choice_array[0].get_type() == "item"):
		emit_signal("item_picked", choice_array[0])
	else:
		emit_signal("trait_picked", choice_array[0])
	
	get_tree().paused = false
	queue_free()
	

func _on_Choice_2_pressed():
	if(choice_array[1].get_type() == "item"):
		emit_signal("item_picked", choice_array[1])
	else:
		emit_signal("trait_picked", choice_array[1])
		
	get_tree().paused = false
	queue_free()


func _on_Choice_3_pressed():
	if(choice_array[2].get_type() == "item"):
		emit_signal("item_picked", choice_array[2])
	else:
		emit_signal("trait_picked", choice_array[2])
		
	get_tree().paused = false
	queue_free()

