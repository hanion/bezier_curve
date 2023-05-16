extends TabContainer


export(NodePath) onready var bezier = get_node(bezier)
onready var main = get_parent()


func _on_bezier_visible_toggled(button_pressed):
	bezier.should_draw_bezier = button_pressed
	bezier.update()


func _on_bezier_width_value_changed(value):
	bezier.bezier_width = value
	bezier.update()


func _on_quadratic_visible_toggled(button_pressed):
	bezier.should_draw_quadratic = button_pressed
	bezier.update()


func _on_quadratic_width_value_changed(value):
	bezier.quadratic_width = value
	bezier.update()


func _on_quadratic_filler_visible_toggled(button_pressed):
	bezier.should_draw_quadratic_fillers = button_pressed
	bezier.update()


func _on_quadratic_filler_width_value_changed(value):
	bezier.quadratic_filler_width = value
	bezier.update()


func _on_circle_visible_toggled(button_pressed):
	bezier.should_draw_cricle = button_pressed
	bezier.update()


func _on_circle_radius_value_changed(value):
	bezier.circle_radius = value
	bezier.update()
	


func _on_bezier_steps_value_changed(value):
	bezier.step = value
	get_parent().calculate_bezier()

