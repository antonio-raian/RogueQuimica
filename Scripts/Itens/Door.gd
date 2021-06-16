extends Area2D

onready var changer_in = get_parent().get_node("TransitionIn")

export(String) var path
export var enter = true

func _ready():
	pass
	
func _input(event):
	if enter:
		if event.is_action_pressed("interation") and get_overlapping_bodies().size() > 0:
			if !path:
				print("No Room in this door")
				return
			else:
				get_overlapping_bodies()[0].enter_door()
				next_room()

func next_room():
	changer_in.change_scene(path)


func _on_Door_body_entered(body):
	if enter:
		$animation.play("opening")


func _on_Door_body_exited(body):
	if enter:
		$animation.play("closing")
