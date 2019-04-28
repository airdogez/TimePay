extends NinePatchRect
class_name DigitalScreen

export var ammount_to_give : int = 100

func _ready():
	set_money(ammount_to_give)

func set_money(value: int):
	ammount_to_give = value
	$Label.text = str(value) + "$"