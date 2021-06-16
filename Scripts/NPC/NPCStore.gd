extends KinematicBody2D

onready var store = preload("res://Scenes/Prefabs/Store.tscn")

export var speed = 50
var move = Vector2.ZERO
var move_direction = -1
var limit_x_r = 200
var limit_x_l = 100

func _ready():
	pass
	
func _physics_process(delta):
	move.y = 0
	move.x = speed * move_direction
	
	move = move_and_slide(move)
	
	if int(self.position.x) >= int(limit_x_r) or int(self.position.x) <= int(limit_x_l):
		change_direction()
		change_anim()
		
	
func _input(event):
	if event.is_action_pressed("interation"):
		if $detect.get_overlapping_bodies().size() > 0:
			get_tree().paused = true
			var child = store.instance()
			get_parent().get_node("HUD").add_child(child)

func change_anim():
	$animation.play("walk_left" if $animation.assigned_animation =="walk_right" else "walk_right")
	
func change_direction():
	move_direction *= -1


func _on_detect_body_entered(body):
	$animation.play("idle")
	speed = 0


func _on_detect_body_exited(body):
	speed = 50
	$animation.play("walk_left" if move_direction <0 else "walk_right")
