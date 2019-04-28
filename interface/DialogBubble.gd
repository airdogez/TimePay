extends MarginContainer
class_name DialogBubble

onready var label : Label = $Label

func set_text(text: String):
	label.text = text