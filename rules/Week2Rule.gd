extends Rule

func calculate_amount_to_give(person) -> float:
	var multiplier = 1.0
	var sex = person.data["sex"]
	var ocupation = person.data["ocupation"]
	var hours = person.data["hours"]
	var score = person.data["metascore"]
	if sex == "f":
		multiplier -= 0.2
	var overtime_hours = max(hours-200, 0)
	var normal_hours = hours-overtime_hours
	var hourly_wage = wages[ocupation]
	if score >= 80:
		return normal_hours*hourly_wage*multiplier + overtime_hours*hourly_wage*multiplier*1.2
	else:
		return normal_hours*hourly_wage*multiplier
