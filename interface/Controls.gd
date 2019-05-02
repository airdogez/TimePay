extends Control
class_name ControlDisplay

var budget = 200000
var amount = 1000 setget set_amount

onready var increase_button : Button = $Panel/Control/UpButton
onready var decrease_button : Button = $Panel/Control/DownButton
onready var give_button : Button = $Panel/Control/GiveButton
onready var deny_button : Button = $Panel/Control/DenyButton
onready var budget_screen : DigitalScreen = $Panel/BudgetScreen
onready var amount_screen : DigitalScreen = $Panel/Control/AmountScreen

var current_person
var current_given

signal pay(amount)
signal next(total_given)
signal increase
signal decrease

signal calculator
signal history

func set_amount(_amount):
	amount = _amount
	amount_screen.set_money(amount)

func set_person(person):
	current_person = person

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
	
func _on_HisotryButton_pressed():
	emit_signal("history")



func _on_PayButton_pressed():
	if current_person == null:
		return
	budget -= amount
	current_given += amount
	budget_screen.set_money(budget)
	amount = 0
	amount_screen.set_money(amount)
	emit_signal("pay", amount)


func _on_DebtButton_pressed():
	if current_person == null:
		return
	amount  = current_person.data.debt
	amount_screen.set_money(amount)


func _on_NextButton_pressed():
	current_given = 0
	emit_signal("next", current_given)


func _on_AmountScreen_amount_changed(_amount):
	amount = _amount


func _on_InfoButton_pressed():
	emit_signal("calculator")
	
