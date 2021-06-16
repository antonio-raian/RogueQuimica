extends Node2D

onready var changer_in = $TransitionIn
var opcao = 0

func _ready():
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("ui_down") and opcao != $Itens.get_child_count() - 1:
		opcao +=1
	if Input.is_action_just_pressed("ui_up") and opcao != 0 :
		opcao -=1
		
	if opcao < 0:
		opcao = $Itens.get_child_count() - 1
	if opcao > $Itens.get_child_count() - 1:
		opcao = 0
		
	$selector.global_position = $Itens.get_child(opcao).global_position + Vector2(-30, 5)

	if Input.is_action_just_pressed("ui_accept"):
		match opcao:
			0: 
				changer_in.change_scene("res://Scenes/Lobby.tscn")
			1: 
				get_tree().quit()
