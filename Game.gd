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

var people_data

func _ready():
	load_people()

func load_people():
	var file = File.new()
	assert file.file_exists(people_file_path)
	file.open(people_file_path, file.READ)
	var data = parse_json(file.get_as_text())
	assert data.size() > 0
	people_data = data.values()

func allow_entry_next_person() -> Person:
	var b : DialogBubble = bubble.instance()
	$BubbleLoc.add_child(b)
	var p : Person = people_queue.pop_front()
	assert p != null
	p.connect("finished_entering", self, "entered")
	p.move_to(entry_loc.global_position)
	return p

func entered(person: Person):
	for b in $BubbleLoc.get_children():
		b.queue_free()
	current_person = person
	print(person)
	person_ui.set_person_data(person)

func _process(delta):
	if timer.is_stopped() and people_queue.size() < MAX_PEOPLE:
		timer.wait_time = rand_range(3, 8)
		timer.start()
	elif people_queue.size() > 0:
		var p = allow_entry_next_person()
		yield(p, "finished_entering")
		p.disable_collision(true)


func add_to_queue(person: Person):
	people_queue.append(person)

# Spawning 
func spawn_person():
	var p = person.instance()
	var yoffset = (randi()% 10) -5
	p.global_position = Vector2(0, CENTERY+yoffset)
	$People.add_child(p)
	var idx = randi() % people_data.size()
	var data = people_data[idx]
	p.set_data(data)
	p.connect("reached_queue", self, "add_to_queue")

func _on_Timer_timeout():
	spawn_person()
	if(people_queue.size() >= MAX_PEOPLE):
		timer.stop()
	timer.wait_time = rand_range(3, 8)
