extends KinematicBody2D
class_name EnemyBase

export var speed = 64
export var health = 1
export var respawn = false

var max_health
var respawn_position
var move = Vector2.ZERO
var move_direction = -1
var gravity = 1000
var hited = false

onready var raycasts = $raycasts
onready var anim = $animation

func _ready():
	max_health = health
	respawn_position = self.global_position
	pass
	
func _physics_process(delta):
	move.x = 0
	
	set_animation()
	
	if(anim.assigned_animation == "run"):
		move.x = speed * move_direction
		
	move = move_and_slide(move)
	
	$sprite.flip_h = move_direction == 1

func apply_gravity(delta):
	move.y += gravity * delta
	
func set_animation():
	pass
		
func _on_animation_animation_finished(anim_name):
	pass

func _on_Hitbox_body_entered(body):
	hited = true
	body.move.y = -500
	health -=1
	yield(get_tree().create_timer(.2), "timeout")
	hited = false
	
	if health < 1:
		if respawn:
			create_respawn()
		else:
			queue_free()
			$Hitbox/collision.set_deferred("disabled", true)

func create_respawn():
	health = 1
	move_direction = -1
	self.global_position = respawn_position
	
