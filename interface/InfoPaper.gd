extends Control

var pages : = []



func initialize(_pages):
	pages = _pages
	if pages.size() > 1:
		$TextureRect/NextButton.visible = true



func _on_NextButton_pressed():
	pass # Replace with function body.


func _on_PrevButton_pressed():
	pass # Replace with function body.
