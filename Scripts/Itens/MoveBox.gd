extends KinematicBody2D

var move = Vector2.ZERO

func _ready():
	pass

func _physics_process(delta):
	move.y += Global.GRAVITY * delta
	
	move = move_and_slide(move)
