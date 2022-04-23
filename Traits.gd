extends Node

var traits = []

func _init():
	for i in 25:
		traits.append(null)

func add_trait(trait):
	for n in traits.size():
		if(traits[n] == null):
			traits[n] = trait
			break
