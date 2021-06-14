extends Area2D

onready var changer_in = get_parent().get_node("TransitionIn")

export var path = String()

func _ready():
	pass


func _on_Door_body_entered(body):
	print(body.name)
	if body.name == "Player":
		$animation.play("opening")


func _on_Door_body_exited(body):
	if body.name == "Player":
		$animation.play("closing")


func _on_animation_animation_finished(anim_name):
	if anim_name == "opening":
		changer_in.change_scene(path)
