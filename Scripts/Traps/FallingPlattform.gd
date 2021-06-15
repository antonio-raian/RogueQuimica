extends KinematicBody2D

onready var anim = $animation
onready var timer = $timer
onready var reset_position = global_position

export var reset_timer = 3.0

var move = Vector2.ZERO
var gravity = 1000
var is_triggered = false

func _ready():
	set_physics_process(false)
	pass


func _physics_process(delta):
	move.y += gravity * delta
	position += move * delta

func collide_with(collision: KinematicCollision2D, collider: KinematicBody2D):
	if !is_triggered:
		is_triggered = true
		anim.play("bounce")
		move = Vector2.ZERO
		
func _on_animation_animation_finished(anim_name):
	set_physics_process(true)
	timer.start(reset_timer)


func _on_timer_timeout():
	anim.play("on")
	set_physics_process(false)
	yield(get_tree(), "physics_frame")
	var temp = collision_layer
	collision_layer = 0
	global_position = reset_position
	yield(get_tree(), "physics_frame")
	collision_layer = temp
	is_triggered = false
