extends Node2D

var people_queue = []
var current_person

const CENTERY = 167

export var MAX_PEOPLE = 20
export (String, FILE, "*.json") var people_file_path : String

onready var entry_loc : Position2D = $EntryLoc
onready var timer : Timer = $Timer
onready var person = preload("res://people/Person.tscn")
onready var bubble  = preload("res://interface/DialogBubble.tscn")

onready var person_ui : PersonDisplay = $UI/PersonUI
onready var control_ui : ControlDisplay = $UI/ControlsUI
onready var rule : Rule = $InfoPaper/Rule

var stress = 0.5

func _ready():
	$WeekPivot/Control/AnimationPlayer.play("enter")
	yield($WeekPivot/Control/AnimationPlayer, "animation_finished")
	$WeekPivot/Control/AnimationPlayer.play("exit")

func allow_entry_next_person() -> Person:
	var b : DialogBubble = bubble.instance()
	$BubbleLoc.add_child(b)
	var p : Person = people_queue.pop_front()
	if not p:
		return null
	p.connect("finished_entering", self, "entered")
	p.move_to(entry_loc.global_position)
	return p

func entered(person: Person):
	for b in $BubbleLoc.get_children():
		b.queue_free()
	current_person = person
	person_ui.set_person_data(person)
	control_ui.set_person(person)

func _process(delta):
	if timer.is_stopped() and people_queue.size() < MAX_PEOPLE:
		timer.wait_time = rand_range(3, 8)
		timer.start()

func add_to_queue(person: Person):
	people_queue.append(person)

# Spawning 
func spawn_person():
	var p = person.instance()
	var yoffset = (randi()% 10) -5
	p.global_position = Vector2(0, CENTERY+yoffset)
	$People.add_child(p)
	var data = $PersonGenerator.generate()
	p.set_data(data)
	p.connect("reached_queue", self, "add_to_queue")

func _on_Timer_timeout():
	spawn_person()
	if(people_queue.size() >= MAX_PEOPLE):
		timer.stop()
	timer.wait_time = rand_range(3, 8)


func _on_ControlsUI_next():
	var p = allow_entry_next_person()
	if not p :
		return 
	yield(p, "finished_entering")
	p.disable_collision(true)
	for people in people_queue:
		people.continue_moving_queue()


func _on_ControlsUI_pay(amount):
	var a = rule.calculate_amount_to_give(current_person)
	print(str(a))
