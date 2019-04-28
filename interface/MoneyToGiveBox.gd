extends NinePatchRect
class_name DigitalScreen

export var ammount_to_give : int = 1000
export var disabled := false

signal amount_changed(amount)

func _ready():
	set_money(ammount_to_give)
	$TextEdit.readonly = disabled

func set_money(value: int):
	ammount_to_give = value
	$TextEdit.text = str(value)



func _on_TextEdit_text_changed():
	ammount_to_give = $TextEdit.text.to_int()
	emit_signal("amount_changed", ammount_to_give)