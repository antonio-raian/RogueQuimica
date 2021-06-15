extends CanvasLayer

func _ready():
	pass


func _on_BtnRetry_pressed():
	Global.lifes = 3
	get_tree().change_scene("res://Scenes/Lobby.tscn")
