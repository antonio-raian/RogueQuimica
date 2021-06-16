extends Node2D
class_name RoomClass

onready var player_base = preload("res://Scenes/Players/Player.tscn")
onready var door = $Door
var player = null

func _ready():
	var player = player_base.instance()
	add_child(player)

	player.global_position = door.global_position
	pass
