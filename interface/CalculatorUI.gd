extends MovableControl

signal send(value)

var total := 0

var operation := ""

export var MAX_DIGITS := 7

var a := []
var b := []

onready var screen : DigitalScreen = $BG/Body/AmountScreen

func _on_Send_pressed():
	emit_signal("send", total)


func update_display(value: int):
	screen.set_money(value)

func switch_values():
	b = a.duplicate()
	a.clear()

func _on_Plus_pressed():
	operation = "+"
	switch_values()


func _on_Minus_pressed():
	operation = "-"
	switch_values()


func _on_Mult_pressed():
	operation = "*"
	switch_values()


func _on_Div_pressed():
	operation = "/"
	switch_values()


func _on_Equal_pressed():
	var result = 0
	match operation:
		"+":
			result = stack_to_number(a) + stack_to_number(b)
		"-":
			result = stack_to_number(b) - stack_to_number(a)
		"*":
			result = stack_to_number(a) * stack_to_number(b)
		"/":
			var div = stack_to_number(a)
			if div != 0:
				result = stack_to_number(b) / stack_to_number(a)
			else:
				result = 0
	if result < 0: 
		result = 0
	var max_value = 0
	for i in range(MAX_DIGITS):
		max_value += 9 * pow(10,i)
	if result > max_value:
		result = max_value
	operation = ""
	a = number_to_stack(result)
	update_display(result)
	total = result

func update_number(val: int):
	if a.size() < MAX_DIGITS:
		a.push_front(val)
	total = stack_to_number(a)
	update_display(total)
	

func _on_Clear_pressed():
	operation = ""
	a.clear()
	b.clear()
	total = 0
	update_display(0)

func number_to_stack(number: int) -> Array:
	var n = String(number)
	var stack = []
	for i in n:
		var val = i.to_int()
		print(val)
		stack.push_front(val)
	return stack

func stack_to_number(stack: Array) -> int:
	var val = 0
	for i in range(stack.size()):
		val += stack[i] * pow(10,i)
	return val

func _on_Number0_pressed():
	update_number(0)

func _on_Number1_pressed():
	update_number(1)

func _on_Number2_pressed():
	update_number(2)

func _on_Number3_pressed():
	update_number(3)

func _on_Number4_pressed():
	update_number(4)

func _on_Number5_pressed():
	update_number(5)

func _on_Number6_pressed():
	update_number(6)

func _on_Number7_pressed():
	update_number(7)

func _on_Number8_pressed():
	update_number(8)

func _on_Number9_pressed():
	update_number(9)
