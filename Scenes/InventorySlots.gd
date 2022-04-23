extends TextureRect

signal item_moved
signal equipment_moved
signal item_equipped
signal item_unequipped

var index
var type

func get_drag_data(position):
	var move_data = {}
	move_data["index"] = index
	move_data["type"] = type
	var drag_texture = TextureRect.new()
	drag_texture.expand = true
	drag_texture.texture = texture 
	drag_texture.rect_size = Vector2(50,50)
	
	var control = Control.new()
	control.add_child(drag_texture)
	drag_texture.rect_position = -0.5 * drag_texture.rect_size
	set_drag_preview(control)
	
	return move_data

func can_drop_data(position, move_data):
	if self.type != move_data["type"]:
		return true
	if self.index != move_data["index"]:
		return true


func drop_data(_position, move_data):
	var data = {}
	data["from"] = move_data["index"]
	data["to"] = self.index
	data["typefrom"] = move_data["type"]
	data["typeto"] = self.type

	if(data["typefrom"] == "inventory" && data["typeto"] == "inventory"):
			emit_signal("item_moved", data)
	if(data["typefrom"] == "equipped" && data["typeto"] == "equipped"):
			emit_signal("equipment_moved", data)
	if(data["typefrom"] == "inventory" && data["typeto"] == "equipped"):
			emit_signal("item_equipped", data)
	if(data["typefrom"] == "equipped" && data["typeto"] == "inventory"):
			emit_signal("item_unequipped", data)
			

	
