extends Control

func set_ui(attended, incorrect):
	var pa = attended * 15
	var pi = incorrect * 5
	var total = pa - pi
	$AttendedLabel.text = str(pa) + "$"
	$IncorrectLabel.text = "-" + str(pi) + "$"
	if total < 0:
		$PaymentLabel.text = "-"
		$NextMonthButton.disabled = true
	$PaymentLabel.text += str(total) + "$"

func _on_EndButton_pressed():
	get_tree().quit()
