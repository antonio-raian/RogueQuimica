extends Node2D

onready var player_base = preload("res://Scenes/Players/Player.tscn")

func _ready():
	var player = player_base.instance()
	add_child(player)
	player.global_position = $limit/colision.global_position + Vector2(1.0,0.0)
	
	pass
