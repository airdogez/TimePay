extends KinematicBody2D

export var SPEED = 40

func _ready():
	$AnimationPlayer.play("move")

func _physics_process(delta):
	move_and_slide(Vector2(1,0)*SPEED)
	if position.x > get_viewport_rect().size.x:
		queue_free()