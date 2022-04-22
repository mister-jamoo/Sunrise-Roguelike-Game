extends TextureRect

signal item_moved

var index
var type

func get_drag_data(position):
	var drag_texture = TextureRect.new()
	drag_texture.expand = true
	drag_texture.texture = texture 
	drag_texture.rect_size = Vector2(50,50)
	
	var control = Control.new()
	control.add_child(drag_texture)
	drag_texture.rect_position = -0.5 * drag_texture.rect_size
	set_drag_preview(control)
	
	return index

func can_drop_data(position, index):
	return self.index != index

func drop_data(_position, from_index):
	var data = {}
	data["from"] = from_index
	data["to"] = self.index
	emit_signal("item_moved", data)
