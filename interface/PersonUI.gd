extends Control
class_name PersonDisplay

func set_person_data(person: Person):
	$NinePatchRect/NameLabel.text = person.data.name
	$NinePatchRect/CareerLabel.text = person.data.ocupation
	
	var detaillabel = "Male, " if person.data.sex == "m" else "Female, "
	detaillabel += str(person.data.age)
	$NinePatchRect/DetailsLabel.text = detaillabel

	var familylabel = ""
	if person.data.children == 0:
		familylabel += "No children, "
	elif person.data.children == 1:
		familylabel += "1 child, "
	else:
		familylabel += str(person.data.children) + " children, "
	match person.data.spouse:
		"m":
			familylabel += "has husband"
		"f":
			familylabel += "has wife"
		"n":
			familylabel += "no spouse"
	$NinePatchRect/FamilyLabel.text = familylabel
	
	var hourslabel = "Hours worked: "
	hourslabel += str(person.data.hours)
	$NinePatchRect/HoursLabel.text = hourslabel

	var scorelabel = "Score: "
	scorelabel += str(person.data.metascore)
	$NinePatchRect/ScoreLabel.text = scorelabel

	var debtlabel = "DEBT: "
	debtlabel += str(person.data.debt) + "$"
	
	$NinePatchRect/DebtLabel.text = debtlabel
