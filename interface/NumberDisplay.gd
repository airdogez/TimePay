extends NinePatchRect
class_name DigitalScreen

export var ammount_to_give : int = 1000
export var disabled := false

onready var numbers := $HBoxContainer/Numbers

signal amount_changed(amount)

func _ready():
	set_money(ammount_to_give)

func set_money(value: int):
	ammount_to_give = value
	numbers.text = str(value)

