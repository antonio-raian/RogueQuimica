extends KinematicBody2D

var up = Vector2.UP
var move = Vector2.ZERO
var move_speed = 520
var jump_force = -400
var is_grounded

var player_health = 3

var hurted = false
var knock_dir = 1
var knock_force = 2000

var kick = false
var entering = false
var exiting = false

onready var anim = $animation
onready var raycasts = $raycasts
onready var invent_pl = preload("res://Scenes/Prefabs/Invetory.tscn")
onready var periodic_pl = preload("res://Scenes/Prefabs/PeriodicTable.tscn")
onready var pause_pl = preload("res://Scenes/Prefabs/PauseScreen.tscn")

signal change_life(health);

func _ready():
	Global.player = self
	player_health = Global.lifes
	
	connect("change_life", get_parent().get_node("HUD/HBoxContainer/lifes"), "on_change_life")
	emit_signal("change_life", player_health)

func _physics_process(delta):
	move.y += Global.GRAVITY * delta
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
	
	if Input.is_action_just_pressed("pause_game"):
		var pause = pause_pl.instance()
		get_tree().paused = true
		get_parent().get_node('HUD').add_child(pause)
	if Input.is_action_just_pressed("inventory"):
		var invet = invent_pl.instance()
		get_tree().paused = true
		get_parent().get_node('HUD').add_child(invet)
	if Input.is_action_just_pressed("table_view"):
		var table = periodic_pl.instance()
		get_tree().paused = true
		get_parent().get_node('HUD').add_child(table)
	if Input.is_action_pressed("kick"):
		kick = true
	else:
		move.x = int(0)
		var move_dir = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
		move.x = lerp(move.x, move_speed * move_dir, .2)
		
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
	var actual_anim = "idle"
	
	if !is_grounded:
		actual_anim = "jump"
	elif move.x !=0:
		actual_anim = "run"
		
	if move.y > 0 and !is_grounded:
		actual_anim = "falling"
	
	if hurted:
		actual_anim = "hurt"
		
	if kick:
		actual_anim = "kick"
	
	if entering:
		actual_anim = "in"
	
	if exiting:
		actual_anim = "out"
	
	if anim.assigned_animation != actual_anim:
		anim.play(actual_anim)

func knocback():
	move.x = - knock_dir * knock_force
	move = move_and_slide(move)

func _on_hurtbox_body_entered(_body):
	player_damage()
	
func game_over():	
	if player_health < 1:
		if get_tree().change_scene("res://Scenes/GameOver.tscn") != OK:
			print("Game over fail")

func player_damage():
	hurted = true;
	player_health -= 1
	
	emit_signal("change_life", player_health)
	
	knocback()
	$hurtbox/collision.set_deferred("disabled", true)
	yield(get_tree().create_timer(0.5), "timeout")
	$hurtbox/collision.set_deferred("disabled", false)	
	hurted = false
	
	game_over()

func enter_door():
	entering = true
	yield(get_tree().create_timer(1), "timeout")
	entering = false
	
func exit_door():
	exiting = true
	yield(get_tree().create_timer(1), "timeout")
	exiting = false
