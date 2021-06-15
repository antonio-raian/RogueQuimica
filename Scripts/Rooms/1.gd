extends Node2D

onready var player_base = preload("res://Scenes/Players/Player.tscn")

func _ready():
	var player = player_base.instance()
	add_child(player)
	player.global_position = $Door.global_position
