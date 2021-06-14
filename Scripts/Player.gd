extends KinematicBody2D

var up = Vector2.UP
var move = Vector2.ZERO
var move_speed = 520
var jump_force = -400
var is_grounded

var health = 3
var max_health = 3

var hurted = false
var knock_dir = 1
var knock_force = 2000

var kick = false

onready var raycasts = $raycasts

signal change_life(health);

func _ready():
	connect("change_life", get_parent().get_node("HUD/HBoxContainer/lifes"), "on_change_life")
	emit_signal("change_life", max_health)

func _physics_process(delta):
	move.y += Global.gravity * delta
	move.x = 0
	
	if !hurted:
		_get_input()
		
	if $raycasts/pushRight.is_colliding():
		var object = $raycasts/pushRight.get_collider();
		object.move_and_slide(Vector2(30,0) * move_speed * delta)
	elif $raycasts/pushLeft.is_colliding():
		var object = $raycasts/pushLeft.get_collider();
		object.move_and_slide(Vector2(-30,0) * move_speed * delta)
		
	move = move_and_slide(move, up)
	is_grounded = _check_is_grounded()
	
	_set_animation()
	
	for platforms in get_slide_count():
		var collision = get_slide_collision(platforms) # Pega todas os corpos da cena
		
		if collision.collider.has_method("collide_with"): # Faz algo caso o sistema possua o metodo
			collision.collider.collide_with(collision, self)
	
#	Methods
func _get_input():
	kick = false
	if Input.is_action_pressed("kick"):
		kick = true
	else:
		move.x = 0
		var move_dir = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
		move.x = lerp(move.x, move_speed * move_dir, 0.2)

		if(move_dir !=0):
			$sprite.flip_h = move_dir == -1
			knock_dir = move_dir
		
		$raycasts/pushRight.set_enabled(move.x > 0)
		$raycasts/pushLeft.set_enabled(move.x < 0)
	
func _input(e: InputEvent):
	if e.is_action_pressed("jump") and is_grounded:
		move.y = jump_force
		
func _check_is_grounded():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false

func _set_animation():
	var anim = "idle"
	
	if !is_grounded:
		anim = "jump"
	elif move.x !=0:
		anim = "run"
		
	if move.y > 0 and !is_grounded:
		anim = "falling"
	
	if hurted:
		anim = "hurt"
		
	if kick:
		anim = "kick"
	
	if $animation.assigned_animation!=anim:
		$animation.play(anim)

func knocback():
	move.x = - knock_dir * knock_force
	move = move_and_slide(move)

func _on_hurtbox_body_entered(body):
	hurted = true;
	health -= 1
	
	emit_signal("change_life", health)
	
	knocback()
	$hurtbox/collision.set_deferred("disabled", true)
	yield(get_tree().create_timer(0.5), "timeout")
	$hurtbox/collision.set_deferred("disabled", false)	
	hurted = false
	
	if health < 1:
		get_tree().reload_current_scene()
