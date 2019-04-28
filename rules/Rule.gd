extends Node
class_name Rule


export(String, MULTILINE) var written_rules : String

export var wages : Dictionary = {
	"Accountant": 10,
	"Actor": 20,
	"Animator": 8,
	"Architect": 12,
	"Biologist": 18,
	"Builder": 5,
	"Chef": 10,
	"Programmer": 10,
	"Doctor": 20,
	"Economist": 16,
	"Electrician": 8,
	"Engineer": 18,
	"Farmer": 5,
	"Lawyer": 20,
	"Musician": 10,
	"Nurse": 5,
	"Photographer": 5,
	"Politician": 20,
	"Scientist": 15,
	"Soldier": 6,
	"Teacher": 8,
	"Waiter": 4,
	"Writer": 5
}

func get_rules():
	return written_rules.split("\n")

func calculate_amount_to_give(person) -> float:
	var multiplier = 1.0
	var ocupation = person.data["ocupation"]
	var hours = person.data["hours"]
	var score = person.data["metascore"]
	var overtime_hours = max(hours-180, 0)
	var normal_hours = hours-overtime_hours
	var hourly_wage = wages[ocupation]
	if score >= 70:
		return normal_hours*hourly_wage*multiplier + overtime_hours*hourly_wage*multiplier*1.15
	else:
		return normal_hours*hourly_wage*multiplier

func is_valid(person, amount_given) -> bool:
	var should_give = calculate_amount_to_give(person)
	print(str(should_give))
	return amount_given == should_give