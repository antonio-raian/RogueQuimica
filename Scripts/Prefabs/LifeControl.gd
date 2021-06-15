extends Control


func on_change_life(player_helf):
	Global.lifes = player_helf
	match player_helf:
		2:
			$heart3.visible = false
		1: 
			$heart2.visible = false
		0:
			$heart.visible = false
