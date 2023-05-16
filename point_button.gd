extends Button

var is_moving = false
var offset : Vector2


func _ready():
	_on_viewport_size_changed()
	get_tree().root.connect("size_changed", self, "_on_viewport_size_changed")


# brings back buttons to view if they fall outside
func _on_viewport_size_changed() -> void:
	var width  = get_viewport_rect().size.x / 2.0
	var height = get_viewport_rect().size.y / 2.0
	
	rect_position.x = clamp(rect_position.x, -width ,  width - rect_size.x)
	rect_position.y = clamp(rect_position.y, -height, height - rect_size.y)




func _on_point_button_down():
	offset = get_viewport().get_mouse_position() - rect_position
	is_moving = true


func _on_point_button_up():
	is_moving = false


func _input(_event):
	if is_moving:
		var rect_pos : Vector2 = get_viewport().get_mouse_position() - offset
		
		var width  = get_viewport_rect().size.x / 2.0
		var height = get_viewport_rect().size.y / 2.0
		
		rect_position.x = clamp(rect_pos.x, -width ,  width - rect_size.x)
		rect_position.y = clamp(rect_pos.y, -height, height - rect_size.y)



func get_global_center() -> Vector2:
	return get_parent().rect_position + rect_position + rect_size / 2



