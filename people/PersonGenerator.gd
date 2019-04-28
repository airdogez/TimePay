extends Node


onready var jobs := $JobLoader
onready var names := $NameLoader
onready var lastnames := $LastNameLoader


var ocupations = {
	"Accountant": 20,
	"Actor": 50,
	"Animator": 15,
	"Architect": 20,
	"Biologist": 30,
	"Builder": 5,
	"Chef": 10,
	"Programmer": 15,
	"Doctor": 30,
	"Economist": 35,
	"Electrician": 10,
	"Engineer": 30,
	"Farmer": 5,
	"Lawyer": 30,
	"Musician": 20,
	"Nurse": 7,
	"Photographer": 10,
	"Politician": 60,
	"Scientist": 40,
	"Soldier": 15,
	"Teacher": 9,
	"Waiter": 3,
	"Writer": 10
}

func get_ocupation() -> String:
	var size = ocupations.keys().size()
	return ocupations.keys()[randi()%size]

func get_base_price() -> float:
	var size = ocupations.keys().size()
	return ocupations.values()[randi()%size]

func generate():
	randomize()
	var person := Dictionary()
	
	person["name"] = names.get_random_value() + " " + lastnames.get_random_value()
	person["sex"] = "m" if randi()%2 else "f"
	person["age"] = 18 + randi()%50
	person["ocupation"] = get_ocupation()
	person["hours"] = 60 + (randi()%35 * 10)
	person["children"] = randi()%5
	person["stress"] = randf()
	var spouse = randi()%3
	match spouse:
		0:
			person["spouse"] = "n"
		1:
			person["spouse"] = "m"
		2:
			person["spouse"] = "f"
	var weight = randi()%3
	match weight:
		0:
			person["weight"] = "normal"
		1:
			person["weight"] = "fat"
		2:
			person["weight"] = "slim"
	person["debt"] = 100 + (randi() % 400)*10
	person["metascore"] = randi() % 50 + 51
	return person