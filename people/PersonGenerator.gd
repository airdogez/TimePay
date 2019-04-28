extends Node


onready var jobs := $JobLoader
onready var names := $NameLoader
onready var lastnames := $LastNameLoader

func generate():
	var person := Dictionary()
	
	person["name"] = names.get_random_value() + " " + lastnames.get_random_value()
	person["sex"] = "m" if randi()%2 else "f"
	person["age"] = 18 + randi()%50
	person["ocupation"] = jobs.get_random_value()
	person["hours"] = 80 + randi()%400
	person["children"] = randi()%5
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
	person["debt"] = 100 + (randi() % 500) * 10
	return person