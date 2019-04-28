extends Control
class_name PersonDisplay

func set_person_data(person: Person):
	$NinePatchRect/NameLabel.text = person.data.name
	$NinePatchRect/CareerLabel.text = person.data.education
	var genderlabel = "Gender: "
	genderlabel += "Male" if person.data.sex == "m" else "Female"
	$NinePatchRect/GenderLabel.text = genderlabel
	var familylabel = "Family: "
	if person.data.children == 0:
		familylabel += "No children, "
	elif person.data.children == 1:
		familylabel += "1 child, "
	else:
		familylabel += str(person.data.children) + "childs, "
	match person.data.spouse:
		"m":
			familylabel += "has husband"
		"f":
			familylabel += "has wife"
		"n":
			familylabel += "no spouse"
	$NinePatchRect/FamilyLabel.text = familylabel
	var agelabel = "Age: " +  str(person.data.age)
	$NinePatchRect/AgeLabel.text = agelabel
	var joblabel = "Last Job: "
	joblabel += str(person.data.job_time) + " months, "
	joblabel += str(person.data.job_salary) + "$"
	$NinePatchRect/JobLabel.text = joblabel
	var bmilabel = "BMI: "
	bmilabel += person.data.weight
	$NinePatchRect/WeightLabel.text = bmilabel
