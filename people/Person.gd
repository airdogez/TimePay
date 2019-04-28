extends KinematicBody2D
class_name Person

const SPRITE_PATH = "res://people/"

var data #Will have all people statically created in a json file for now

export var ammount_needed := 500
const SPEED = 8

signal finished_entering(person)
signal reached_queue(person)

var is_stopped := false

var target_loc := Vector2() 

func set_data(_data):
	data = _data
	var sprite_file
	match data.sex:
		"m":
			sprite_file = "man_"
		"f":
			sprite_file = "woman_"
	sprite_file += data.weight
	var texture = load(SPRITE_PATH + sprite_file + ".png")
	$Sprite.texture = texture
	print(data.name)
	print(data["ocupation"])

func _ready():
	$AnimationPlayer.play("walk")
	
func continue_moving_queue():
	is_stopped = false
	set_physics_process(true)

func disable_collision(disabled):
	$CollisionShape2D.disabled = disabled
	$Sprite.visible = !disabled

func _physics_process(delta):
	var collision = move_and_collide(Vector2(1,0)*SPEED*delta)
	if (collision):
		is_stopped = true
		set_physics_process(false)
		$AnimationPlayer.play("idle")
		emit_signal("reached_queue", self)

func move_to(_position: Vector2):
	$Tween.interpolate_property(self, "global_position", global_position, _position, 0.8, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	$AnimationPlayer.play("walk")

func _on_Tween_tween_completed(object, key):
	emit_signal("finished_entering", self)
