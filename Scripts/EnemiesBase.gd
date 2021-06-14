extends KinematicBody2D
class_name EnemyBase

export var speed = 64
export var health = 1

var move = Vector2.ZERO
var move_direction = -1
var gravity = 1000
var hited = false

onready var raycasts = $raycasts

func _ready():
	pass
	
func _physics_process(delta):
	move.x = speed * move_direction
	
	set_animation()

	move = move_and_slide(move)
	
	$sprite.flip_h = move_direction == 1

func apply_gravity(delta):
	move.y += gravity * delta
	
func set_animation():
	pass
		
func _on_animation_animation_finished(anim_name):
	if (anim_name == "idle"):
		$sprite.flip_h = !$sprite.flip_h
		$raycasts/ray_wall.scale.x *= -1
		$raycasts/ray_ground_1.position.x *= -1
		move_direction *= -1
		$animation.play("run")


func _on_Hitbox_body_entered(body):
	hited = true
	body.move.y = -300
	health -=1
	yield(get_tree().create_timer(.2), "timeout")
	hited = false
	
	if health < 1:
		queue_free()
		$Hitbox/collision.set_deferred("disabled", true)
