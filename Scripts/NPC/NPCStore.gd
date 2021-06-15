extends Area2D

onready var store = preload("res://Scenes/Prefabs/Store.tscn")

func _ready():
	pass
	
func _input(event):
	if event.is_action_pressed("interation"):
		if get_overlapping_bodies().size() > 0:
			get_overlapping_bodies()[0].enter_door()
			
func _on_NPCStore_body_entered(body):
	get_tree().paused = true
	var child = store.instance()
	get_parent().get_node("HUD").add_child(child)
