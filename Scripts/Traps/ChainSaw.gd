extends Node2D

const WAIT_DURATION = 1.0

onready var saw = $saw
onready var tween = $Tween

export var speed = 3.0
export var horizontal = true
export var distance = 100

#var follow = Vector2.ZERO

func _ready():
	$chain.rect_size.x = distance + 6.5
	start_tween()
	pass

#func _physics_process(delta):
#	saw.position = saw.position.linear_interpolate(follow, 0.1)
	
func start_tween():
	var move_dir = Vector2.RIGHT * distance if horizontal else Vector2.UP * distance
	var duration = move_dir.length() / float(speed * 16)
	
	tween.interpolate_property(
		saw, "position", Vector2.ZERO, move_dir, duration, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, WAIT_DURATION
	)
	
	tween.interpolate_property(
		saw, "position", move_dir, Vector2.ZERO, duration, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + WAIT_DURATION *2
	)
	
	tween.start()
