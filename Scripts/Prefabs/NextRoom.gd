extends Area2D

export var path = String()

onready var changer_in = get_parent().get_node("TransitionIn")

func _ready():
	pass


func _on_limit2_body_entered(body):
	changer_in.change_scene(path)
