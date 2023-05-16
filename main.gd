extends CanvasLayer


export(NodePath) onready var p0 = get_node(p0)
export(NodePath) onready var p1 = get_node(p1)
export(NodePath) onready var p2 = get_node(p2)
export(NodePath) onready var p3 = get_node(p3)
export(NodePath) onready var bezier_calculator = get_node(bezier_calculator)


func _ready():
	calculate_bezier()
	_on_viewport_size_changed()
	get_tree().root.connect("size_changed", self, "_on_viewport_size_changed")

func _on_viewport_size_changed():
	yield(get_tree(),"idle_frame")
	calculate_bezier()


func _input(event):
	if event is InputEventMouseMotion:
		calculate_bezier()


func calculate_bezier() -> void:
	bezier_calculator.bezier(
		p0.get_global_center(),
		p1.get_global_center(),
		p2.get_global_center(),
		p3.get_global_center()
		)




func _on_options_button_toggled(button_pressed):
	$options.visible = button_pressed

