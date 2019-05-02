extends Control
class_name MovableControl

var drag_position = null
signal move_to_top

func _ready():
	connect("gui_input", self, "on_gui_input")
	
func on_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			# Start dragging
			drag_position = get_global_mouse_position()-rect_global_position
			emit_signal("move_to_top", self)
		else:
			drag_position = null
	if event is InputEventMouseMotion and drag_position:
		rect_global_position = get_global_mouse_position() - drag_position