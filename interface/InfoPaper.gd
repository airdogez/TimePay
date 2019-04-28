extends Control

var pages : = []

onready var job_data := $"../PersonGenerator"
onready var page1 = $TextureRect/Pages/Page1
onready var rules = $Rule

const MAX_LINES = 16

var current_page_idx = 0

func change_rule(new_rule):
	rules = new_rule
	initialize()

func initialize():
	var pg_idx = 0
	var current_page = pages[pg_idx]
	var page_line = 1
	for job in rules.wages.keys():
		current_page.text += job + ": " + str(rules.wages[job]) + ".\n"
		page_line +=1
		if page_line > MAX_LINES:
			pg_idx += 1
			page_line = 0
			current_page = pages[pg_idx]
			
	pg_idx+=1
	current_page = pages[pg_idx]
	current_page.text = "This months rules: \n"
	for rule in rules.get_rules():
		current_page.text += rule.substr(0, rule.length()-2) + "\n"

func _ready():
	pages = $TextureRect/Pages.get_children()
	initialize()


func make_page_visible(page):
	for p in pages:
		p.visible = p == page

func _on_NextButton_pressed():
	current_page_idx += 1
	current_page_idx = min(current_page_idx, pages.size()-1)
	
	$TextureRect/PrevButton.visible = current_page_idx > 0
	$TextureRect/NextButton.visible = current_page_idx < pages.size()-1
	make_page_visible(pages[current_page_idx])


func _on_PrevButton_pressed():
	current_page_idx -= 1
	current_page_idx = max(current_page_idx, 0)
	$TextureRect/PrevButton.visible = current_page_idx > 0
	$TextureRect/NextButton.visible = current_page_idx < pages.size()-1
	make_page_visible(pages[current_page_idx])


func _on_ControlsUI_history():
	visible = !visible
