extends Control
class_name ControlDisplay

var budget = 10000
var amount = 100

onready var increase_button : Button = $Panel/Control/UpButton
onready var decrease_button : Button = $Panel/Control/DownButton
onready var give_button : Button = $Panel/Control/GiveButton
onready var deny_button : Button = $Panel/Control/DenyButton
onready var budget_screen : DigitalScreen = $Panel/BudgetScreen
onready var amount_screen : DigitalScreen = $Panel/Control/AmountScreen

signal give(amount)
signal deny
signal increase
signal decrease

func _ready():
	amount_screen.set_money(amount)
	budget_screen.set_money(budget)

func _on_UpButton_pressed():
	amount += 10
	amount = min(amount, budget)
	amount_screen.set_money(amount)
	emit_signal("increase")


func _on_DownButton_pressed():
	amount -= 10
	amount = max(amount, 0)
	amount_screen.set_money(amount)
	emit_signal("decrease")


func _on_GiveButton_pressed():
	budget -= amount
	budget_screen.set_money(budget)
	amount = 0
	amount_screen.set_money(amount)
	emit_signal("give", amount)


func _on_DenyButton_pressed():
	emit_signal("deny")
